-- Copyright (C) 2022  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 22.1std.0 Build 915 10/25/2022 SC Standard Edition"
-- CREATED		"Mon Apr  6 20:44:19 2026"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY T80_core IS 
	PORT
	(
		CLOCK_50 :  IN  STD_LOGIC;
		DRAM_DQ :  INOUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		KEY :  IN  STD_LOGIC_VECTOR(0 TO 0);
		LED :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		
		--SDRAM
		DRAM_CLK :  OUT  STD_LOGIC;
		DRAM_CKE :  OUT  STD_LOGIC;
		DRAM_CS_N :  OUT  STD_LOGIC;
		DRAM_RAS_N :  OUT  STD_LOGIC;
		DRAM_CAS_N :  OUT  STD_LOGIC;
		DRAM_WE_N :  OUT  STD_LOGIC;
		DRAM_ADDR :  OUT  STD_LOGIC_VECTOR(12 DOWNTO 0);
		DRAM_BA :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		DRAM_DQM :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		
		--VGA
		VGAVS :  OUT  STD_LOGIC;
		VGAHS :  OUT  STD_LOGIC;
		VGAR0 :  OUT  STD_LOGIC;
		VGAR1 :  OUT  STD_LOGIC;
		VGAG0 :  OUT  STD_LOGIC;
		VGAG1 :  OUT  STD_LOGIC;
		VGAB0 :  OUT  STD_LOGIC;
		VGAB1 :  OUT  STD_LOGIC;
		VGAR2 :  OUT  STD_LOGIC;
		VGAG2 :  OUT  STD_LOGIC;
		VGAB2 :  OUT  STD_LOGIC;
		
		--UART
		RX    :  IN  STD_LOGIC;
		TX 	:  OUT  STD_LOGIC;
		
		--SD card
		sd_cs_pin   :  OUT  STD_LOGIC;
      sd_mosi_pin :  OUT  STD_LOGIC;
      sd_miso_pin :  IN  STD_LOGIC;
      sd_sclk_pin :  OUT  STD_LOGIC
	);
END T80_core;

ARCHITECTURE bdf_type OF T80_core IS 

COMPONENT t80se
GENERIC (IOWait : INTEGER;
			Mode : INTEGER;
			T2Write : INTEGER
			);
	PORT(RESET_n : IN STD_LOGIC;
		 CLK_n : IN STD_LOGIC;
		 CLKEN : IN STD_LOGIC;
		 WAIT_n : IN STD_LOGIC;
		 INT_n : IN STD_LOGIC;
		 NMI_n : IN STD_LOGIC;
		 BUSRQ_n : IN STD_LOGIC;
		 DI : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 M1_n : OUT STD_LOGIC;
		 MREQ_n : OUT STD_LOGIC;
		 IORQ_n : OUT STD_LOGIC;
		 RD_n : OUT STD_LOGIC;
		 WR_n : OUT STD_LOGIC;
		 RFSH_n : OUT STD_LOGIC;
		 HALT_n : OUT STD_LOGIC;
		 BUSAK_n : OUT STD_LOGIC;
		 A : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 DO : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sd_controller
    generic (
        CLKEDGE_DIVIDER : integer := 120  -- Adatto per clock FPGA
    );
    port (
        clk              : in  std_logic;
        rst_n            : in  std_logic;
        -- Interfaccia T80 (mappata come memoria o I/O)
		  sd_ce            : in  std_logic;
        mem_ramadr       : in  std_logic_vector(15 downto 0);
        ramre            : in  std_logic; -- rd_n o equivalente
        ramwe            : in  std_logic; -- wr_n o equivalente
        data_in          : in  std_logic_vector(7 downto 0);
        data_out         : out std_logic_vector(7 downto 0);
        -- Interfaccia SD
        sdCS             : out std_logic;
        sdMOSI           : out std_logic;
        sdMISO           : in  std_logic;
        sdSCLK           : out std_logic;
        driveLED         : out std_logic
    );
end COMPONENT;

COMPONENT Zerkiolino_ALU 
    Port (
        clk      : in  STD_LOGIC;
        reset_n  : in  STD_LOGIC;
        -- Interfaccia Bus T80
        addr     : in  STD_LOGIC_VECTOR(3 downto 0); -- A3..A0 (0-F)
        data_in  : in  STD_LOGIC_VECTOR(7 downto 0);
        data_out : out STD_LOGIC_VECTOR(7 downto 0);
        nWR      : in  STD_LOGIC;
        nRD      : in  STD_LOGIC;
        nMREQ    : in  STD_LOGIC;
        cs_alu   : in  STD_LOGIC; -- Chip Select decodificato a 0xC020
        busy     : out STD_LOGIC
    );
end COMPONENT;

COMPONENT Z80_Bus_Arbiter 
    port(
        clk             : in  std_logic; -- 50MHz
        reset_n         : in  std_logic;

        -- CPU Interface
        cpu_addr        : in  std_logic_vector(15 downto 0);
        cpu_din         : out std_logic_vector(7 downto 0);
        cpu_dout        : in  std_logic_vector(7 downto 0);
        mreq_n          : in  std_logic;
        iorq_n          : in  std_logic;
        rd_n            : in  std_logic;
        wr_n            : in  std_logic;
        wait_n          : out std_logic;

        -- Memory Interface (ROM/RAM rimangono in MREQ)
        rom_data        : in  std_logic_vector(7 downto 0);
        rom_cs          : out std_logic;
        ram_data        : in  std_logic_vector(7 downto 0);
        ram_cs          : out std_logic;
        ram_we          : out std_logic;

        -- Video Interface (Spostata in I/O)
        vga_data_in     : in  std_logic_vector(7 downto 0);
        vga_cs          : out std_logic;
        vga_we          : out std_logic;
        sdram_busy      : in  std_logic;

        -- SD Interface (Già in I/O)
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
end COMPONENT;

COMPONENT pll_sys
	PORT(inclk0 : IN STD_LOGIC;
		 c0 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT t80_ram_16k
	PORT(wren : IN STD_LOGIC;
		 rden : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT t80_rom_32k
	PORT(rden : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dso_video_subsystem
	PORT(clk_cpu : IN STD_LOGIC;
		 clk_sync : IN STD_LOGIC;
		 clk_vga : IN STD_LOGIC;
		 clk_pixel : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 vga_cs : IN STD_LOGIC;
		 vga_we : IN STD_LOGIC;
		 dram_dq : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 vga_addr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 vga_wdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 sdram_busy : OUT STD_LOGIC;
		 vga_hsync : OUT STD_LOGIC;
		 vga_vsync : OUT STD_LOGIC;
		 dram_clk : OUT STD_LOGIC;
		 dram_cke : OUT STD_LOGIC;
		 dram_cs_n : OUT STD_LOGIC;
		 dram_ras_n : OUT STD_LOGIC;
		 dram_cas_n : OUT STD_LOGIC;
		 dram_we_n : OUT STD_LOGIC;
		 dram_addr : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
		 dram_ba : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 dram_dqm : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 vga_rdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 vga_rgb : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pll_vga
	PORT(inclk0 : IN STD_LOGIC;
		 c0 : OUT STD_LOGIC;
		 c1 : OUT STD_LOGIC;
		 c2 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT DCLK_BUF 
	PORT
	(
		datain_h		: IN STD_LOGIC_VECTOR (0 DOWNTO 0);
		datain_l		: IN STD_LOGIC_VECTOR (0 DOWNTO 0);
		outclock		: IN STD_LOGIC ;
		dataout		: OUT STD_LOGIC_VECTOR (0 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	clk_sys :  STD_LOGIC;
SIGNAL	CLOCK_PIXEL :  STD_LOGIC;
SIGNAL	CLOCK_SYNC :  STD_LOGIC;
SIGNAL	CLOCK_VGA :  STD_LOGIC;
SIGNAL	cpu_addr :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	cpu_din :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	cpu_dout :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	DRAM_BA_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	DRAM_DQM_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	iorq_n :  STD_LOGIC;
SIGNAL	MAIN_CLK :  STD_LOGIC;
SIGNAL	mreq_n :  STD_LOGIC;
SIGNAL	ram_cs :  STD_LOGIC;
SIGNAL	ram_we :  STD_LOGIC;
SIGNAL	rd_n :  STD_LOGIC;
SIGNAL	rom_cs :  STD_LOGIC;
SIGNAL	rst_n :  STD_LOGIC;
SIGNAL	sdram_busy :  STD_LOGIC;
SIGNAL	vga_cs :  STD_LOGIC;
SIGNAL	VGA_OUT :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	vga_rdata :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL   sd_data_out  :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	vga_we :  STD_LOGIC;
SIGNAL	wait_n :  STD_LOGIC;
SIGNAL	wr_n :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL   sd_cs : std_logic;
SIGNAL   sd_we : std_logic;
SIGNAL   sd_rd : std_logic;
SIGNAL	led_sd_activity : std_logic;
signal alu_cs_sig   : std_logic;
signal alu_data_out : std_logic_vector(7 downto 0);
signal alu_busy_sig : std_logic;
-- Segnali per il collegamento Arbiter <-> UART
signal s_uart_ce      : std_logic;
signal s_uart_data_in : std_logic_vector(7 downto 0); -- Dati dalla UART verso la CPU

BEGIN 
SYNTHESIZED_WIRE_8 <= '1';

-- Istanza della ALU Hardware
u_alu : Zerkiolino_ALU
    port map (
        clk      => clk_sys,      -- Il tuo clock di sistema
        reset_n  => rst_n,
        addr     => cpu_addr(3 DOWNTO 0),
        data_in  => cpu_dout,       -- Dati in uscita dalla CPU
        data_out => alu_data_out,   -- Dati prodotti dall'ALU
        nWR      => wr_n,
        nRD      => rd_n,
        nMREQ    => mreq_n,
        cs_alu   => alu_cs_sig,
        busy     => alu_busy_sig
    );

-- Istanziazione della cella DDIO per il clock della SDRAM
u_dram_clk_gen : DCLK_BUF
port map (
    datain_h(0) => '1',      -- Valore da mandare sul fronte di salita
    datain_l(0) => '0',      -- Valore da mandare sul fronte di discesa
    outclock    => CLOCK_PIXEL, -- Il segnale di clock che esce dal PLL (es. quello a 114MHz sfasato)
    dataout(0)  => DRAM_CLK  -- Il pin fisico che va verso il chip SDRAM
);

b2v_inst : t80se
GENERIC MAP(IOWait => 1,
			Mode => 0,
			T2Write => 0
			)
PORT MAP(RESET_n => rst_n,
		 CLK_n => clk_sys,
		 CLKEN => SYNTHESIZED_WIRE_8,
		 WAIT_n => wait_n,
		 INT_n => SYNTHESIZED_WIRE_8,
		 NMI_n => SYNTHESIZED_WIRE_8,
		 BUSRQ_n => SYNTHESIZED_WIRE_8,
		 DI => cpu_din,
		 MREQ_n => mreq_n,
		 IORQ_n => iorq_n,
		 RD_n => rd_n,
		 WR_n => wr_n,
		 A => cpu_addr,
		 DO => cpu_dout);


SYNTHESIZED_WIRE_7 <= NOT(clk_sys);



SYNTHESIZED_WIRE_6 <= NOT(clk_sys);



b2v_inst2 : z80_bus_arbiter
PORT MAP(clk => clk_sys,
		 reset_n => rst_n,
		 mreq_n => mreq_n,
		 iorq_n => iorq_n,
		 rd_n => rd_n,
		 wr_n => wr_n,
		 sdram_busy => sdram_busy,
		 cpu_addr => cpu_addr,
		 cpu_dout => cpu_dout,
		 ram_data => SYNTHESIZED_WIRE_4,
		 rom_data => SYNTHESIZED_WIRE_5,
		 vga_data_in => vga_rdata,
		 sd_data_in  => sd_data_out,
		 wait_n => wait_n,
		 rom_cs => rom_cs,
		 ram_cs => ram_cs,
		 ram_we => ram_we,
		 vga_cs => vga_cs,
		 vga_we => vga_we,
		 sd_cs  => sd_cs,
       sd_we  => sd_we,
       sd_rd  => sd_rd,
		 -- Nuova interfaccia ALU
       alu_data_in  => alu_data_out,
       alu_cs       => alu_cs_sig,
       alu_busy     => alu_busy_sig,
		 -- Interfaccia UART (0xC030)
		 uart_data_in  => s_uart_data_in, -- L'arbiter legge i dati prodotti dalla UART
		 uart_ce       => s_uart_ce,       -- L'arbiter dice quando la UART è selezionata
		 cpu_din => cpu_din);


b2v_inst4 : pll_sys
PORT MAP(inclk0 => MAIN_CLK,
		 c0 => clk_sys);


b2v_inst5 : t80_ram_16k
PORT MAP(wren => ram_we,
		 rden => ram_cs,
		 clock => SYNTHESIZED_WIRE_6,
		 address => cpu_addr(13 DOWNTO 0),
		 data => cpu_dout,
		 q => SYNTHESIZED_WIRE_4);


b2v_inst6 : t80_rom_32k
PORT MAP(rden => rom_cs,
		 clock => SYNTHESIZED_WIRE_7,
		 address => cpu_addr(14 DOWNTO 0),
		 q => SYNTHESIZED_WIRE_5);



b2v_inst8 : dso_video_subsystem
PORT MAP(clk_cpu => clk_sys,
		 clk_sync => CLOCK_SYNC,
		 clk_vga => CLOCK_VGA,
		 clk_pixel => CLOCK_PIXEL,
		 reset_n => rst_n,
		 vga_cs => vga_cs,
		 vga_we => vga_we,
		 dram_dq => DRAM_DQ,
		 vga_addr => cpu_addr(3 DOWNTO 0),
		 vga_wdata => cpu_dout,
		 sdram_busy => sdram_busy,
		 vga_hsync => VGAHS,
		 vga_vsync => VGAVS,
		 dram_clk => open,
		 dram_cke => DRAM_CKE,
		 dram_cs_n => DRAM_CS_N,
		 dram_ras_n => DRAM_RAS_N,
		 dram_cas_n => DRAM_CAS_N,
		 dram_we_n => DRAM_WE_N,
		 dram_addr => DRAM_ADDR,
		 dram_ba => DRAM_BA_ALTERA_SYNTHESIZED,
		 dram_dqm => DRAM_DQM_ALTERA_SYNTHESIZED,
		 vga_rdata => vga_rdata,
		 vga_rgb => VGA_OUT);


b2v_inst9 : pll_vga
PORT MAP(inclk0 => MAIN_CLK,
		 c0 => CLOCK_SYNC,
		 c1 => CLOCK_VGA,
		 c2 => CLOCK_PIXEL);
		 
-- Istanza del Controller SD
u_sd_controller : entity work.sd_controller
    generic map (
        CLKEDGE_DIVIDER => 60      
    )
    port map (
        clk           => clk_sys,  
        rst_n         => rst_n,   
        
        mem_ramadr    => cpu_addr, 
        
        -- Assicurati che sd_we/rd/cs siano attivi ALTI dall'Arbiter
        ramwe         => sd_we,  
        ramre         => sd_rd,  
        sd_ce     	 => sd_cs,  
        
        data_in       => cpu_dout,   
        data_out      => sd_data_out, 
        
        sdCS         => sd_cs_pin,  
        sdMOSI       => sd_mosi_pin,
        sdMISO       => sd_miso_pin,
        sdSCLK       => sd_sclk_pin,
        driveLED     => led_sd_activity 
    );

u_uart : entity work.uart_t80
port map (
    clk      => clk_sys,    -- Il tuo clock di sistema
    reset_n  => rst_n,      -- Reset attivo basso
    
    -- Bus Indirizzi: prendiamo i bit bassi A1 e A0 dallo Z80
    addr     => cpu_addr(1 downto 0), 
    
    -- Logica di controllo
    ce_n     => not s_uart_ce, -- Invertiamo: l'arbiter dà '1', la UART vuole '0'
    wr_n     => wr_n,          -- Segnale WR dello Z80
    rd_n     => rd_n,          -- Segnale RD dello Z80
    
    -- Bus Dati
    din      => cpu_dout,      -- Quello che la CPU SCRIVE (esce dalla CPU)
    dout     => s_uart_data_in, -- Quello che la UART RISPONDE (va all'arbiter)
    
    -- Pin Fisici (verso l'esterno dell'FPGA)
    rxd      => RX,
    txd      => TX
);
	 
	 
	 

MAIN_CLK <= CLOCK_50;
rst_n <= KEY(0);
LED(7) <= led_sd_activity;
VGAR0 <= VGA_OUT(0);
VGAR1 <= VGA_OUT(1);
VGAR2 <= VGA_OUT(2);

VGAG0 <= VGA_OUT(3);
VGAG1 <= VGA_OUT(4);
VGAG2 <= VGA_OUT(5);

VGAB0 <= VGA_OUT(6);
VGAB1 <= VGA_OUT(7);
VGAB2 <= VGA_OUT(8);

DRAM_BA <= DRAM_BA_ALTERA_SYNTHESIZED;
DRAM_DQM <= DRAM_DQM_ALTERA_SYNTHESIZED;

END bdf_type;