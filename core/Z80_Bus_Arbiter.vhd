library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Z80_Bus_Arbiter is
    port(
        clk             : in  std_logic;
        reset_n         : in  std_logic;

        -- Interfaccia CPU T80se
        cpu_addr        : in  std_logic_vector(15 downto 0);
        cpu_din         : out std_logic_vector(7 downto 0);
        cpu_dout        : in  std_logic_vector(7 downto 0);
        mreq_n          : in  std_logic;
        iorq_n          : in  std_logic;
        rd_n            : in  std_logic;
        wr_n            : in  std_logic;
        wait_n          : out std_logic;

        -- Interfaccia ROM
        rom_data        : in  std_logic_vector(7 downto 0);
        rom_cs          : out std_logic;

        -- Interfaccia RAM
        ram_data        : in  std_logic_vector(7 downto 0);
        ram_cs          : out std_logic;
        ram_we          : out std_logic;

        -- Interfaccia Video (0xC000 - 0xC00F)
        vga_data_in     : in  std_logic_vector(7 downto 0);
        vga_cs          : out std_logic;
        vga_we          : out std_logic;
        sdram_busy      : in  std_logic;

        -- Interfaccia SD Controller (0xC010 - 0xC01F)
        sd_data_in      : in  std_logic_vector(7 downto 0);
        sd_cs           : out std_logic;
        sd_we           : out std_logic;
        sd_rd           : out std_logic;
        
        -- Interfaccia ALU Hardware (0xC020 - 0xC02F)
        alu_data_in     : in  std_logic_vector(7 downto 0);
        alu_cs          : out std_logic;
        alu_busy        : in  std_logic;
        
        -- Interfaccia UART (0xC030 - 0xC03F)
        uart_data_in    : in  std_logic_vector(7 downto 0);
        uart_ce         : out std_logic
    );
end Z80_Bus_Arbiter;

architecture Behavioral of Z80_Bus_Arbiter is

    -- Conversione indirizzo per comparatori
    signal addr : unsigned(15 downto 0);
    
    -- Segnali di selezione interni
    signal sel_rom : std_logic;
    signal sel_ram : std_logic;
    signal in_io_zone : std_logic; -- Zona 0xC000 - 0xC0FF
    
    -- Range di Memoria
    constant ROM_LIMIT : unsigned(15 downto 0) := x"7FFF"; -- 32KB
    constant RAM_START : unsigned(15 downto 0) := x"8000"; 
    constant RAM_LIMIT : unsigned(15 downto 0) := x"BFFF"; -- 16KB

    ------------------------------------------------------------------
    -- LOGICA MULTIPLEXER ESPANDIBILE (Stile MemRdMux)
    ------------------------------------------------------------------
    constant C_NUM_SLAVES : integer := 4; -- VGA, SD, ALU, UART (Aggiornato a 4)
    
    type Slave_Out_Type is record
        dout : std_logic_vector(7 downto 0);
        sel  : std_logic;
    end record;

    type Slaves_Bus_Type is array (0 to C_NUM_SLAVES-1) of Slave_Out_Type;
    signal slv_bus : Slaves_Bus_Type;

    -- Segnali di selezione specifici
    signal s_vga, s_sd, s_alu, s_uart : std_logic;

begin

    addr <= unsigned(cpu_addr);

    ------------------------------------------------------------------
    -- 1. ADDRESS DECODER (Ottimizzato)
    ------------------------------------------------------------------
    -- ROM e RAM
    sel_rom <= '1' when (addr <= ROM_LIMIT) else '0';
    sel_ram <= '1' when (addr >= RAM_START and addr <= RAM_LIMIT) else '0';
    
    -- Zona Periferiche: 0xC000 - 0xC0FF
    in_io_zone <= '1' when (addr(15 downto 8) = x"C0") else '0';

    -- Decodifica per Slot (ogni slot = 16 byte)
    s_vga  <= '1' when (in_io_zone = '1' and addr(7 downto 4) = x"0") else '0'; -- 0xC000
    s_sd   <= '1' when (in_io_zone = '1' and addr(7 downto 4) = x"1") else '0'; -- 0xC010
    s_alu  <= '1' when (in_io_zone = '1' and addr(7 downto 4) = x"2") else '0'; -- 0xC020
    s_uart <= '1' when (in_io_zone = '1' and addr(7 downto 4) = x"3") else '0'; -- 0xC030

    ------------------------------------------------------------------
    -- 2. ASSEGNAZIONE BUS DEGLI SLAVE
    ------------------------------------------------------------------
    slv_bus(0).dout <= vga_data_in;  slv_bus(0).sel <= s_vga;
    slv_bus(1).dout <= sd_data_in;   slv_bus(1).sel <= s_sd;
    slv_bus(2).dout <= alu_data_in;  slv_bus(2).sel <= s_alu;
    slv_bus(3).dout <= uart_data_in; slv_bus(3).sel <= s_uart;

    ------------------------------------------------------------------
    -- 3. OUTPUT SIGNALS (Chip Select e Write Enable)
    ------------------------------------------------------------------
    rom_cs <= sel_rom and (not mreq_n);
    ram_cs <= sel_ram and (not mreq_n);
    
    -- Chip Select periferiche (Attivi ALTI)
    vga_cs  <= s_vga  and (not mreq_n);
    sd_cs   <= s_sd   and (not mreq_n);
    alu_cs  <= s_alu  and (not mreq_n);
    uart_ce <= s_uart and (not mreq_n);

    -- Scrittura
    ram_we <= sel_ram and (not mreq_n) and (not wr_n);
    vga_we <= s_vga   and (not mreq_n) and (not wr_n);
    sd_we  <= s_sd    and (not mreq_n) and (not wr_n);
    
    -- Lettura SD
    sd_rd  <= s_sd    and (not mreq_n) and (not rd_n);

    ------------------------------------------------------------------
    -- 4. BUS MULTIPLEXER INTEGRATO (Dati verso CPU)
    ------------------------------------------------------------------
    process(addr, mreq_n, rd_n, sel_rom, sel_ram, rom_data, ram_data, slv_bus)
    begin
        cpu_din <= x"FF"; -- Default Pull-up

        if (mreq_n = '0' and rd_n = '0') then
            if sel_rom = '1' then
                cpu_din <= rom_data;
            elsif sel_ram = '1' then
                cpu_din <= ram_data;
            else
                -- Ciclo for combinatorio per il MUX periferiche
                for i in 0 to C_NUM_SLAVES-1 loop
                    if slv_bus(i).sel = '1' then
                        cpu_din <= slv_bus(i).dout;
                        exit;
                    end if;
                end loop;
            end if;
        end if;
    end process;

    ------------------------------------------------------------------
    -- 5. WAIT STATE MANAGEMENT
    ------------------------------------------------------------------
    wait_n <= '0' when (s_vga = '1' and mreq_n = '0' and sdram_busy = '1') or 
                       (s_alu = '1' and mreq_n = '0' and alu_busy = '1') 
              else '1';

end Behavioral;