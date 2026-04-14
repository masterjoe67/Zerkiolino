library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity sd_controller is
    generic (
        CLKEDGE_DIVIDER : integer := 120  
    );
    port (
        clk              : in  std_logic;
        rst_n            : in  std_logic;
        -- Interfaccia T80
        sd_ce            : in  std_logic; -- SEGNALE FONDAMENTALE REINSERITO
        mem_ramadr       : in  std_logic_vector(15 downto 0);
        ramre            : in  std_logic; 
        ramwe            : in  std_logic; 
        data_in          : in  std_logic_vector(7 downto 0);
        data_out         : out std_logic_vector(7 downto 0);
        -- Interfaccia SD
        sdCS             : out std_logic;
        sdMOSI           : out std_logic;
        sdMISO           : in  std_logic;
        sdSCLK           : out std_logic;
        driveLED         : out std_logic
    );
end sd_controller;

architecture rtl of sd_controller is
    type states is (
        rst, init, cmd0, cmd8, cmd55, acmd41, poll_cmd, cmd58, cardsel,
        idle, read_block_cmd, read_block_wait, read_block_data,
        send_cmd, send_regreq, receive_ocr_wait, receive_byte_wait, receive_byte,
        write_block_cmd, write_block_init, write_block_data, write_block_byte, write_block_wait
    );

    constant write_data_size : integer := 515;

    signal state, return_state : states;
    signal sclk_sig : std_logic := '0';
    signal cmd_out : std_logic_vector(55 downto 0);
    signal recv_data : std_logic_vector(39 downto 0);

    signal clkCount : std_logic_vector(7 downto 0) := (others => '0');
    signal clkEn : std_logic;
    signal HighSpeed : std_logic := '0';
    signal status : std_logic_vector(7 downto 0) := x"00";

    signal block_read : std_logic := '0';
    signal block_write : std_logic := '0';
    signal block_start_ack : std_logic := '0';

    signal cmd_mode : std_logic := '1';
    signal response_mode : std_logic := '1';
    signal data_sig : std_logic_vector(7 downto 0) := x"00";
    signal din_latched : std_logic_vector(7 downto 0) := x"00";
    signal dout : std_logic_vector(7 downto 0) := x"00";

    signal sdhc : std_logic := '0';
    signal sd_read_flag : std_logic := '0';
    signal host_read_flag : std_logic := '0';
    signal sd_write_flag : std_logic := '0';
    signal host_write_flag : std_logic := '0';

    signal init_busy : std_logic := '1';
    signal block_busy : std_logic := '0';
    signal address : std_logic_vector(31 downto 0) := (others => '0');
    signal led_on_count : integer range 0 to 2000000;
    signal sdMISO_sync : std_logic_vector(1 downto 0);

begin

    process(clk)
    begin
        if rising_edge(clk) then
            sdMISO_sync <= sdMISO_sync(0) & sdMISO;
        end if;
    end process;

    clock_enable: process(clk)
    begin
        if rising_edge(clk) then
            if clkCount < (CLKEDGE_DIVIDER - 1) then
                clkCount <= clkCount + 1;
            else
                clkCount <= (others=>'0');
            end if;
        end if;
    end process;

    clkEn <= '1' when ( clkCount = 0 ) or ( HighSpeed = '1' ) else '0';

    -- INTERFACCIA REGISTRI CON sd_ce
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            address <= (others => '0');
            din_latched <= (others => '0');
            host_read_flag <= '0';
            host_write_flag <= '0';
            block_read <= '0';
            block_write <= '0';
        elsif rising_edge(clk) then
            if block_start_ack = '1' then
                block_read <= '0';
                block_write <= '0';
            end if;

            -- Scrittura (solo se sd_ce è attivo)
            if sd_ce = '1' and ramwe = '1' then
                case mem_ramadr is
                    when x"C010" => 
                        if (sd_write_flag = host_write_flag) then
                            din_latched <= data_in;
                            host_write_flag <= not host_write_flag;
                        end if;
                    when x"C011" => 
                        if data_in = x"00" then block_read <= '1';
                        elsif data_in = x"01" then block_write <= '1';
                        end if;
                    when x"C012" => 
                        if sdhc = '0' then address(16 downto 9) <= data_in;
                        else address(7 downto 0) <= data_in; end if;
                    when x"C013" => 
                        if sdhc = '0' then address(24 downto 17) <= data_in;
                        else address(15 downto 8) <= data_in; end if;
                    when x"C014" => 
                        if sdhc = '0' then address(31 downto 25) <= data_in(6 downto 0);
                        else address(23 downto 16) <= data_in; end if;
                    when others => null;
                end case;
            end if;

            -- Lettura (solo se sd_ce è attivo)
            if sd_ce = '1' and ramre = '1' and mem_ramadr = x"C010" then
                if (sd_read_flag /= host_read_flag) then
                    host_read_flag <= not host_read_flag;
                end if;
            end if;
        end if;
    end process;

    data_out <= dout   when mem_ramadr = x"C010" else
                status when mem_ramadr = x"C011" else
                x"00";

    status(7) <= '1' when host_write_flag = sd_write_flag else '0';
    status(6) <= '1' when host_read_flag /= sd_read_flag else '0';
    status(5) <= block_busy;
    status(4) <= init_busy;

    -- FSM ORIGINALE (COPIA INTEGRALE AVR)
    fsm: process(clk, rst_n)
        variable byte_counter : integer range 0 to write_data_size;
        variable bit_counter : integer range 0 to 160;
    begin
        if (rst_n='0') then
            state <= rst;
            sclk_sig <= '0';
            sdCS <= '1';
            HighSpeed <= '0';
        elsif rising_edge(clk) and clkEn = '1' then
            case state is
                when rst =>
                    sd_read_flag <= host_read_flag;
                    sd_write_flag <= host_write_flag;
                    sclk_sig <= '0';
                    cmd_out <= (others => '1');
                    byte_counter := 0;
                    cmd_mode <= '1';
                    response_mode <= '1';
                    bit_counter := 160;
                    sdCS <= '1';
                    state <= init;
                    init_busy <= '1';
                    block_start_ack <= '0';

                when init =>
                    if (bit_counter = 0) then
                        sdCS <= '0';
                        state <= cmd0;
                    else
                        bit_counter := bit_counter - 1;
                        sclk_sig <= not sclk_sig;
                    end if;

                when cmd0 =>
                    cmd_out <= x"ff400000000095";
                    bit_counter := 55;
                    return_state <= cmd8;
                    state <= send_cmd;

                when cmd8 =>
                    cmd_out <= x"ff48000001aa87";
                    bit_counter := 55;
                    return_state <= cmd55;
                    state <= send_regreq;

                when cmd55 =>
                    cmd_out <= x"ff770000000001";
                    bit_counter := 55;
                    return_state <= acmd41;
                    state <= send_cmd;

                when acmd41 =>
                    cmd_out <= x"ff694000000077";
                    bit_counter := 55;
                    return_state <= poll_cmd;
                    state <= send_cmd;

                when poll_cmd =>
                    if (recv_data(0) = '0') then state <= cmd58;
                    else state <= cmd55; end if;

                when cmd58 =>
                    cmd_out <= x"ff7a00000000fd";
                    bit_counter := 55;
                    return_state <= cardsel;
                    state <= send_regreq;

                when cardsel =>
                    if (recv_data(31) = '0' ) then state <= cmd58;
                    else sdhc <= recv_data(30); state <= idle; end if;

                when idle =>
                    HighSpeed <= '1';
                    sd_read_flag <= host_read_flag;
                    sd_write_flag <= host_write_flag;
                    sclk_sig <= '0';
                    cmd_out <= (others => '1');
                    data_sig <= (others => '1');
                    byte_counter := 0;
                    cmd_mode <= '1';
                    response_mode <= '1';
                    block_busy <= '0';
                    init_busy <= '0';
                    dout <= (others => '0');
                    if (block_read = '1') then
                        state <= read_block_cmd;
                        block_start_ack <= '1';
                    elsif (block_write='1') then
                        state <= write_block_cmd;
                        block_start_ack <= '1';
                    else
                        state <= idle;
                        block_start_ack <= '0';
                    end if;

                when read_block_cmd =>
                    block_busy <= '1';
                    block_start_ack <= '0';
                    cmd_out <= x"ff" & x"51" & address & x"ff";
                    bit_counter := 55;
                    return_state <= read_block_wait;
                    state <= send_cmd;

                when read_block_wait =>
                    if (sclk_sig='0' and sdMISO_sync(1) ='0') then
                        state <= receive_byte;
                        byte_counter := 513;
                        bit_counter := 8; 
                        return_state <= read_block_data;
                    end if;
                    sclk_sig <= not sclk_sig;

--                when read_block_data =>
--                    if (byte_counter = 0) then state <= idle;
--                    elsif (sd_read_flag /= host_read_flag) then state <= read_block_data;
--                    else
--                        byte_counter := byte_counter - 1;
--                        return_state <= read_block_data;
--                        bit_counter := 7;
--                        state <= receive_byte;
--                    end if;
				when read_block_data =>
					if (byte_counter = 1) then -- crc byte 1 - ignore
						byte_counter := byte_counter - 1;
						return_state <= read_block_data;
						bit_counter := 7;
						state <= receive_byte;
					elsif (byte_counter = 0) then -- crc byte 2 - ignore
						bit_counter := 7;
						return_state <= idle;
						state <= receive_byte;
					elsif (sd_read_flag /= host_read_flag) then
						state <= read_block_data; -- stay here until previous byte read
					else
						byte_counter := byte_counter - 1;
						return_state <= read_block_data;
						bit_counter := 7;
						state <= receive_byte;
					end if;

                when send_cmd =>
                    if (sclk_sig = '1') then
                        if (bit_counter = 0) then state <= receive_byte_wait;
                        else bit_counter := bit_counter - 1; cmd_out <= cmd_out(54 downto 0) & '1'; end if;
                    end if;
                    sclk_sig <= not sclk_sig;

                when send_regreq =>
                    if (sclk_sig = '1') then
                        if (bit_counter = 0) then state <= receive_ocr_wait;
                        else bit_counter := bit_counter - 1; cmd_out <= cmd_out(54 downto 0) & '1'; end if;
                    end if;
                    sclk_sig <= not sclk_sig;

                when receive_ocr_wait =>
                    if (sclk_sig = '0') then
                        if (sdMISO_sync(1) = '0') then
                            recv_data <= (others => '0');
                            bit_counter := 38;
                            state <= receive_byte;
                        end if;
                    end if;
                    sclk_sig <= not sclk_sig;

                when receive_byte_wait =>
                    if (sclk_sig = '0') then
                        if (sdMISO_sync(1) = '0') then
                            recv_data <= (others => '0');
                            if (response_mode='0') then bit_counter := 3;
                            else bit_counter := 6; end if;
                            state <= receive_byte;
                        end if;
                    end if;
                    sclk_sig <= not sclk_sig;

                when receive_byte =>
                    if (sclk_sig = '0') then
                        recv_data <= recv_data(38 downto 0) & sdMISO_sync(1);
                        if (bit_counter = 0) then
                            state <= return_state;
                            if return_state = read_block_data and byte_counter > 0 then
                                sd_read_flag <= not sd_read_flag;
                                dout <= recv_data(6 downto 0) & sdMISO_sync(1);
                            end if;
                        else bit_counter := bit_counter - 1; end if;
                    end if;
                    sclk_sig <= not sclk_sig;

                when others => state <= idle;
            end case;
        end if;
    end process;

    sdSCLK <= sclk_sig;
    sdMOSI <= cmd_out(55) when cmd_mode='1' else data_sig(7);

    process (clk)
    begin
        if (rising_edge(clk)) then
            if block_busy='1' or init_busy = '1' then
                led_on_count <= 2000000; 
                driveLED <= '0';
            elsif led_on_count > 0 then
                led_on_count <= led_on_count - 1;
                driveLED <= '0';
            else
                driveLED <= '1';
            end if;
        end if;
    end process;

end rtl;