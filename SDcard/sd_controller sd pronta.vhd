library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity sd_controller is
generic (
    constant CLKEDGE_DIVIDER : integer := 450 -- 90MHz / 450 / 2 = 100kHz per init
);
port (
    clk      : in  std_logic;
    n_reset  : in  std_logic;
    
    -- Interfaccia Bus Z80
    cs       : in  std_logic;
    addr     : in  std_logic_vector(2 downto 0);
    rd_n     : in  std_logic;
    wr_n     : in  std_logic;
    dataIn   : in  std_logic_vector(7 downto 0);
    dataOut  : out std_logic_vector(7 downto 0);
    
    -- SD Card SPI
    sdCS     : out std_logic;
    sdMOSI   : out std_logic;
    sdMISO   : in  std_logic;
    sdSCLK   : out std_logic;
    
	 LED		 : out std_logic_vector(3 downto 0);
    driveLED : out std_logic
);
end sd_controller;

architecture rtl of sd_controller is

    -- [I tipi e i segnali FSM originali rimangono invariati]
    type states is (
        rst, init, cmd0, cmd8, cmd55, acmd41, poll_cmd, cmd58, cardsel, idle,
        read_block_cmd, read_block_wait, read_block_data, send_cmd, send_regreq,
        receive_ocr_wait, receive_byte_wait, receive_byte, write_block_cmd,
        write_block_init, write_block_data, write_block_byte, write_block_wait
    );

    constant write_data_size : integer := 515;

    signal state, return_state : states;
    signal sclk_sig : std_logic := '0';
    signal cmd_out : std_logic_vector(55 downto 0);
    signal recv_data : std_logic_vector(39 downto 0);

    signal clkCount : std_logic_vector(7 downto 0); -- Aumentato per contenere 225
    signal clkEn : std_logic;
    signal HighSpeed : std_logic := '0';
    signal status : std_logic_vector(7 downto 0) := x"00";

    signal block_read, block_write, block_start_ack : std_logic := '0';
    signal cmd_mode, response_mode : std_logic := '1';
    signal data_sig, din_latched, dout : std_logic_vector(7 downto 0) := x"00";

    signal sdhc : std_logic := '0';
    signal sd_read_flag, host_read_flag : std_logic := '0';
    signal sd_write_flag, host_write_flag : std_logic := '0';
    signal init_busy : std_logic := '1';
    signal block_busy : std_logic := '0';

    signal address: std_logic_vector(31 downto 0) := x"00000000";
    signal led_on_count : integer range 0 to 200;

    -- Segnali interni per sincronizzazione bus Z80
    signal wr_pulse, rd_pulse : std_logic := '0';
    signal wr_prev, rd_prev : std_logic := '1';
	 signal sdMISO_sync : std_logic_vector(1 downto 0);

begin

    ------------------------------------------------------------------
    -- 1. SINCRONIZZAZIONE BUS T80 (Edge Detection)
    ------------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then
            wr_pulse <= '0';
            rd_pulse <= '0';
            sdMISO_sync <= sdMISO_sync(0) & sdMISO;
            -- Rileva il fronte di discesa di wr_n qualificato dal chip select
            if cs = '1' and wr_n = '0' then
                if wr_prev = '1' then
                    wr_pulse <= '1';
                end if;
                wr_prev <= '0';
            else
                wr_prev <= '1';
            end if;

            -- Rileva il fronte di discesa di rd_n
            if cs = '1' and rd_n = '0' then
                if rd_prev = '1' then
                    rd_pulse <= '1';
                end if;
                rd_prev <= '0';
            else
                rd_prev <= '1';
            end if;
        end if;
    end process;

    ------------------------------------------------------------------
    -- 2. GENERAZIONE CLOCK ENABLE PER SPI
    ------------------------------------------------------------------
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

    -- Nota per i 90MHz: in HighSpeed il clkEn è sempre 1, quindi sdSCLK toggla a 45MHz.
    -- Se la scheda SD o i cavi falliscono, cambia questa riga per rallentarlo un po'.
    --clkEn <= '1' when (clkCount = 0) or (HighSpeed = '1') else '0';
	 clkEn <= '1' when (clkCount = 0) or (HighSpeed = '1' and clkCount(2 downto 0) = "000") else '0';
    ------------------------------------------------------------------
    -- 3. REGISTRI CPU (Sincroni al 100%)
    ------------------------------------------------------------------
    regs_process: process(clk)
    begin
        if rising_edge(clk) then
            if wr_pulse = '1' then
                -- Indirizzi LBA
                if sdhc = '0' then 
                    if addr = "010" then address(16 downto 9)  <= dataIn; end if;
                    if addr = "011" then address(24 downto 17) <= dataIn; end if;
                    if addr = "100" then address(31 downto 25) <= dataIn(6 downto 0); end if;
                else
                    if addr = "010" then address(7 downto 0)   <= dataIn; end if;
                    if addr = "011" then address(15 downto 8)  <= dataIn; end if;
                    if addr = "100" then address(23 downto 16) <= dataIn; end if;
                end if;

                -- Dati da scrivere
                if addr = "000" and (sd_write_flag = host_write_flag) then
                    din_latched <= dataIn;
                    host_write_flag <= not host_write_flag;
                end if;

                -- Comandi
                if init_busy = '0' and block_start_ack = '0' then
                    if addr = "001" and dataIn = x"00" then block_read <= '1'; end if;
                    if addr = "001" and dataIn = x"01" then block_write <= '1'; end if;
                end if;
            else
                if init_busy='1' or block_start_ack='1' then
                    block_read <= '0';
                    block_write <= '0';
                end if;
            end if;

            -- Dati da leggere
            if rd_pulse = '1' then
                if addr = "000" and (sd_read_flag /= host_read_flag) then
                    host_read_flag <= not host_read_flag;
                end if;
            end if;
        end if;
    end process;

    dataOut <= dout   when addr = "000" else
               status when addr = "001" else
               x"00";

    ------------------------------------------------------------------
    -- 4. MACCHINA A STATI SPI (Mantenuta invariata)
    ------------------------------------------------------------------
    fsm: process(clk, n_reset)
        variable byte_counter : integer range 0 to write_data_size;
        variable bit_counter : integer range 0 to 160;
    begin
        if (n_reset='0') then
            state <= rst;
            sclk_sig <= '0';
            sdCS <= '1';
            HighSpeed <= '0';
        elsif rising_edge(clk) and clkEn = '1' then
			case state is

				when rst =>
--					HighSpeed <= '0';
					sd_read_flag <= host_read_flag;
					sd_write_flag <= host_write_flag;
					sclk_sig <= '0';
					cmd_out <= (others => '1');
					byte_counter := 0;
					cmd_mode <= '1';	-- 0=data, 1=command
					response_mode <= '1';	-- 0=data, 1=command
					bit_counter := 160;
					sdCS <= '1';
					state <= init;
					init_busy <= '1';
					block_start_ack <= '0';

				when init =>		-- cs=1, send 80 clocks, cs=0
					if (bit_counter = 0) then
						sdCS <= '0';
						state <= cmd0;
					else
						bit_counter := bit_counter - 1;
						sclk_sig <= not sclk_sig;
					end if;

				when cmd0 =>
					cmd_out <= x"ff400000000095";	-- GO_IDLE_STATE here, Select SPI
					bit_counter := 55;
					return_state <= cmd8;
					state <= send_cmd;

				when cmd8 =>
					cmd_out <= x"ff48000001aa87";	-- SEND_IF_COND
					bit_counter := 55;
					return_state <= cmd55;
					state <= send_regreq;

				-- cmd55 is the "prefix" command for ACMDs
				when cmd55 =>
					cmd_out <= x"ff770000000001";	-- APP_CMD
					bit_counter := 55;
					return_state <= acmd41;
					state <= send_cmd;

				when acmd41 =>
					cmd_out <= x"ff694000000077";	-- SD_SEND_OP_COND
					bit_counter := 55;
					return_state <= poll_cmd;
					state <= send_cmd;

				when poll_cmd =>
					if (recv_data(0) = '0') then
						state <= cmd58;
					else
						-- still busy; go round and do it again
						state <= cmd55;
					end if;

				when cmd58 =>
					cmd_out <= x"ff7a00000000fd";	-- READ_OCR
					bit_counter := 55;
					return_state <= cardsel;
					state <= send_regreq;

				when cardsel =>
					if (recv_data(31) = '0' ) then	-- power up not completed
						state <= cmd58;
					else
						sdhc <= recv_data(30);	-- CCS bit
						state <= idle;
					end if;

				when idle =>
					HighSpeed <= '1';
					sd_read_flag <= host_read_flag;
					sd_write_flag <= host_write_flag;
					sclk_sig <= '0';
					cmd_out <= (others => '1');
					data_sig <= (others => '1');
					byte_counter := 0;
					cmd_mode <= '1';	-- 0=data, 1=command
					response_mode <= '1';	-- 0=data, 1=command

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
					end if;

				when read_block_cmd =>
					block_busy <= '1';
					block_start_ack <= '0';
					cmd_out <= x"ff" & x"51" & address & x"ff";     -- CMD17 read single block
					bit_counter := 55;
					return_state <= read_block_wait;
					state <= send_cmd;

				-- wait until data token read (= 11111110)
				when read_block_wait =>
					if (sclk_sig='0' and sdMISO_sync(1)='0') then
						state <= receive_byte;
						byte_counter := 513; -- data plus crc
						bit_counter := 8; -- ???????????????????????????????
						return_state <= read_block_data;
					end if;
					sclk_sig <= not sclk_sig;

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
					if (sclk_sig = '1') then	-- sending command
						if (bit_counter = 0) then	-- command sent
							state <= receive_byte_wait;
						else
							bit_counter := bit_counter - 1;
							cmd_out <= cmd_out(54 downto 0) & '1';
						end if;
					end if;
					sclk_sig <= not sclk_sig;

				when send_regreq =>
					if (sclk_sig = '1') then	-- sending command
						if (bit_counter = 0) then	-- command sent
							state <= receive_ocr_wait;
						else
							bit_counter := bit_counter - 1;
							cmd_out <= cmd_out(54 downto 0) & '1';
						end if;
					end if;
					sclk_sig <= not sclk_sig;

				when receive_ocr_wait =>
					if (sclk_sig = '0') then
						if (sdMISO_sync(1) = '0') then	-- wait for zero bit
							recv_data <= (others => '0');
							bit_counter := 38;	-- already read bit 39
							state <= receive_byte;
						end if;
					end if;
					sclk_sig <= not sclk_sig;

				when receive_byte_wait =>
					if (sclk_sig = '0') then
						if (sdMISO_sync(1) = '0') then	-- wait for start bit
							recv_data <= (others => '0');
							if (response_mode='0') then	-- data mode
								bit_counter := 3;	-- already read bits 7..4
							else	-- command mode
								bit_counter := 6;	-- already read bit 7 (start bit)
							end if;
							state <= receive_byte;
						end if;
					end if;
					sclk_sig <= not sclk_sig;

				-- read 8-bit data or 8-bit R1 response or 40-bit R7 response
				when receive_byte =>
					if (sclk_sig = '0') then
						recv_data <= recv_data(38 downto 0) & sdMISO_sync(1);	-- read next bit
						if (bit_counter = 0) then
							state <= return_state;
							-- if real data received then flag it (byte counter = 0 for both crc bytes)
							if return_state= read_block_data and byte_counter > 0 then
								sd_read_flag <= not sd_read_flag;
								dout <= recv_data(7 downto 0);
							end if;
						else
							bit_counter := bit_counter - 1;
						end if;
					end if;
					sclk_sig <= not sclk_sig;

				when write_block_cmd =>
					block_busy <= '1';
					block_start_ack <= '0';
					cmd_mode <= '1';
					cmd_out <= x"ff" & x"58" & address & x"ff";	-- CMD24 write single block
					bit_counter := 55;
					return_state <= write_block_init;
					state <= send_cmd;

				when write_block_init =>
					cmd_mode <= '0';
					byte_counter := write_data_size;
					state <= write_block_data;

				when write_block_data =>
					if byte_counter = 0 then
						state <= receive_byte_wait;
						return_state <= write_block_wait;
						response_mode <= '0';
					else
						if ((byte_counter = 2) or (byte_counter = 1)) then
							data_sig <= x"ff"; -- two crc bytes
							bit_counter := 7;
							state <= write_block_byte;
							byte_counter := byte_counter - 1;
						elsif byte_counter = write_data_size then
							data_sig <= x"fe"; -- start byte, single block
							bit_counter := 7;
							state <= write_block_byte;
							byte_counter := byte_counter - 1;
						elsif host_write_flag /= sd_write_flag then -- only send if flag set
							data_sig <= din_latched;
							bit_counter := 7;
							state <= write_block_byte;
							byte_counter := byte_counter - 1;
							sd_write_flag <= not sd_write_flag;
						end if;
					end if;

				when write_block_byte =>
					if (sclk_sig = '1') then
						if bit_counter=0 then
							state <= write_block_data;
						else
							data_sig <= data_sig(6 downto 0) & '1';
							bit_counter := bit_counter - 1;
						end if;
					end if;
					sclk_sig <= not sclk_sig;

				when write_block_wait =>
					cmd_mode <= '1';
					response_mode <= '1';
					if sclk_sig='0' then
						if sdMISO_sync(1)='1' then
							state <= idle;
						end if;
					end if;
					sclk_sig <= not sclk_sig;

				when others =>
					state <= idle;
			end case;
        end if;
    end process;

    sdSCLK <= sclk_sig;
    sdMOSI <= cmd_out(55) when cmd_mode='1' else data_sig(7);

    status(7) <= '1' when host_write_flag = sd_write_flag else '0'; 
    status(6) <= '0' when host_read_flag = sd_read_flag else '1'; 
    status(5) <= block_busy;
    status(4) <= init_busy;

    -- LED Control
    ctl_led: process (clk)
    begin
        if rising_edge(clk) then
            if block_busy='1' or init_busy = '1' then
                led_on_count <= 200; 
                driveLED <= '0';
            else
                if led_on_count > 0 then
                    led_on_count <= led_on_count - 1;
                    driveLED <= '0';
                else
                    driveLED <= '1';
                end if;
            end if;
        end if;
    end process;




	 LED(3 downto 0) <= "0001" when state = rst else
                   "0010" when state = init else
                   "0100" when state = idle else
                   "1000" when state = read_block_cmd else
                   "0000";

end rtl;