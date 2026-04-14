--
--
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--
--entity Z80_Bus_Arbiter is
--    port(
--        clk             : in  std_logic;
--        reset_n         : in  std_logic;
--
--        -- Interfaccia CPU T80se
--        cpu_addr        : in  std_logic_vector(15 downto 0);
--        cpu_din         : out std_logic_vector(7 downto 0);
--        cpu_dout        : in  std_logic_vector(7 downto 0);
--        mreq_n          : in  std_logic;
--        iorq_n          : in  std_logic;
--        rd_n            : in  std_logic;
--        wr_n            : in  std_logic;
--        wait_n          : out std_logic;
--
--        -- Interfaccia ROM
--        rom_data        : in  std_logic_vector(7 downto 0);
--        rom_cs          : out std_logic;
--
--        -- Interfaccia RAM
--        ram_data        : in  std_logic_vector(7 downto 0);
--        ram_cs          : out std_logic;
--        ram_we          : out std_logic;
--
--        -- Interfaccia Video (0xC000 - 0xC00F)
--        vga_data_in     : in  std_logic_vector(7 downto 0);
--        vga_cs          : out std_logic;
--        vga_we          : out std_logic;
--        sdram_busy      : in  std_logic;
--
--        -- Interfaccia SD Controller (0xC010 - 0xC01F)
--        sd_data_in      : in  std_logic_vector(7 downto 0);
--        sd_cs           : out std_logic;
--        sd_we           : out std_logic;
--        sd_rd           : out std_logic;
--        
--        -- Interfaccia ALU Hardware (0xC020 - 0xC02F)
--        alu_data_in     : in  std_logic_vector(7 downto 0);
--        alu_cs          : out std_logic;
--        alu_busy        : in  std_logic
--    );
--end Z80_Bus_Arbiter;
--
--architecture Behavioral of Z80_Bus_Arbiter is
--
--    -- Conversione indirizzo per comparatori
--    signal addr : unsigned(15 downto 0);
--    
--    -- Segnali di selezione interni (stile 74LS138)
--    signal sel_rom : std_logic;
--    signal sel_ram : std_logic;
--    signal sel_vga : std_logic;
--    signal sel_sd  : std_logic;
--    signal sel_alu : std_logic;
--
--    -- Definizione dei Range di Memoria (Configurabili)
--    constant ROM_LIMIT : unsigned(15 downto 0) := x"7FFF"; -- 32KB
--    constant RAM_START : unsigned(15 downto 0) := x"8000"; 
--    constant RAM_LIMIT : unsigned(15 downto 0) := x"BFFF"; -- 16KB
--    
--    constant VGA_BASE  : unsigned(15 downto 0) := x"C000"; -- 16 byte
--    constant SD_BASE   : unsigned(15 downto 0) := x"C010"; -- 16 byte
--    constant ALU_BASE  : unsigned(15 downto 0) := x"C020"; -- 16 byte
--
--begin
--
--    addr <= unsigned(cpu_addr);
--
--    ------------------------------------------------------------------
--    -- 1. ADDRESS DECODER (Combinatorio puro)
--    ------------------------------------------------------------------
--    -- ROM: 0x0000 - 0x7FFF
--    sel_rom <= '1' when (addr <= ROM_LIMIT) else '0';
--    
--    -- RAM: 0x8000 - 0xBFFF
--    sel_ram <= '1' when (addr >= RAM_START and addr <= RAM_LIMIT) else '0';
--    
--    -- VGA: 0xC000 - 0xC00F
--    sel_vga <= '1' when (addr >= VGA_BASE and addr <= (VGA_BASE + 15)) else '0';
--    
--    -- SD:  0xC010 - 0xC01F
--    sel_sd  <= '1' when (addr >= SD_BASE and addr <= (SD_BASE + 15)) else '0';
--
--    -- ALU: 0xC020 - 0xC02F
--    sel_alu <= '1' when (addr >= ALU_BASE and addr <= (ALU_BASE + 15)) else '0';
--
--
--    ------------------------------------------------------------------
--    -- 2. OUTPUT SIGNALS (Chip Select e Write Enable)
--    ------------------------------------------------------------------
--    -- I Chip Select sono attivi solo se MREQ è basso
--    rom_cs <= sel_rom and (not mreq_n);
--    ram_cs <= sel_ram and (not mreq_n);
--    vga_cs <= sel_vga and (not mreq_n);
--    sd_cs  <= sel_sd  and (not mreq_n);
--    alu_cs <= sel_alu and (not mreq_n);
--
--    -- I segnali di scrittura seguono WR e MREQ (Asincroni)
--    ram_we <= sel_ram and (not mreq_n) and (not wr_n);
--    vga_we <= sel_vga and (not mreq_n) and (not wr_n);
--    sd_we  <= sel_sd  and (not mreq_n) and (not wr_n);
--    
--    -- Segnale di lettura specifico per il controller SD
--    sd_rd  <= sel_sd  and (not mreq_n) and (not rd_n);
--
--
--    ------------------------------------------------------------------
--    -- 3. BUS MULTIPLEXER (Lettura Dati verso CPU)
--    ------------------------------------------------------------------
--    -- Gestisce il flusso dai vari chip alla CPU in base all'indirizzo
--    process(addr, mreq_n, rd_n, sel_rom, sel_ram, sel_vga, sel_sd, sel_alu, 
--            rom_data, ram_data, vga_data_in, sd_data_in, alu_data_in)
--    begin
--        -- Bus flottante (Pull-up logico)
--        cpu_din <= x"FF";
--        
--        if (mreq_n = '0' and rd_n = '0') then
--            if    sel_rom = '1' then cpu_din <= rom_data;
--            elsif sel_ram = '1' then cpu_din <= ram_data;
--            elsif sel_vga = '1' then cpu_din <= vga_data_in;
--            elsif sel_sd  = '1' then cpu_din <= sd_data_in;
--            elsif sel_alu = '1' then cpu_din <= alu_data_in;
--            end if;
--        end if;
--    end process;
--
--
--    ------------------------------------------------------------------
--    -- 4. WAIT STATE MANAGEMENT
--    ------------------------------------------------------------------
--    -- Genera il segnale WAIT se la VGA (SDRAM) o l'ALU sono occupate.
--    -- Abbiamo combinato i due controlli con un OR logico.
--wait_n <= '0' when (sel_vga = '1' and mreq_n = '0' and sdram_busy = '1') or 
--                   (sel_alu = '1' and mreq_n = '0' and alu_busy = '1') 
--          else '1';
--
--
--end Behavioral;

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
        alu_busy        : in  std_logic
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
    constant C_NUM_SLAVES : integer := 3; -- VGA, SD, ALU (Slot 3 libero)
    
    type Slave_Out_Type is record
        dout : std_logic_vector(7 downto 0);
        sel  : std_logic;
    end record;

    type Slaves_Bus_Type is array (0 to C_NUM_SLAVES-1) of Slave_Out_Type;
    signal slv_bus : Slaves_Bus_Type;

    -- Segnali di selezione specifici
    signal s_vga, s_sd, s_alu : std_logic;

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
    s_vga <= '1' when (in_io_zone = '1' and addr(7 downto 4) = x"0") else '0'; -- 0xC000
    s_sd  <= '1' when (in_io_zone = '1' and addr(7 downto 4) = x"1") else '0'; -- 0xC010
    s_alu <= '1' when (in_io_zone = '1' and addr(7 downto 4) = x"2") else '0'; -- 0xC020

    ------------------------------------------------------------------
    -- 2. ASSEGNAZIONE BUS DEGLI SLAVE
    ------------------------------------------------------------------
    slv_bus(0).dout <= vga_data_in; slv_bus(0).sel <= s_vga;
    slv_bus(1).dout <= sd_data_in;  slv_bus(1).sel <= s_sd;
    slv_bus(2).dout <= alu_data_in; slv_bus(2).sel <= s_alu;

    ------------------------------------------------------------------
    -- 3. OUTPUT SIGNALS (Chip Select e Write Enable)
    ------------------------------------------------------------------
    rom_cs <= sel_rom and (not mreq_n);
    ram_cs <= sel_ram and (not mreq_n);
    
    -- Chip Select periferiche
    vga_cs <= s_vga and (not mreq_n);
    sd_cs  <= s_sd  and (not mreq_n);
    alu_cs <= s_alu and (not mreq_n);

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