

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sdram is
    generic(
        page0 : integer := 320;
        page1 : integer := 320
    );
    port(
        clk             : in std_logic; 
        pixelOut        : out unsigned(15 downto 0);
        rowLoadNr       : in unsigned(9 downto 0); 
        colLoadNr       : buffer unsigned(9 downto 0); 
        rowLoadReq      : in std_logic;
        rowLoadAck      : out std_logic := '0';
        wren_sdr        : out std_logic;
        addrDirect      : in unsigned(23 downto 0); 
        pixelDirectIn   : in unsigned(15 downto 0);
        directWriteReq  : in std_logic; 
        directAck       : out std_logic := '0'; 
        
        pMemClk : out std_logic; pMemCke : out std_logic; pMemCs_n : out std_logic;
        pMemRas_n : out std_logic; pMemCas_n : out std_logic; pMemWe_n : out std_logic;
        pMemUdq : out std_logic; pMemLdq : out std_logic;
        pMemBa1 : out std_logic; pMemBa0 : out std_logic;
        pMemAdr : out unsigned(12 downto 0);
        pMemDat : inout unsigned(15 downto 0)
    );
end sdram;

architecture rtl of sdram is
    signal SdrCmd : unsigned(3 downto 0);
    signal SdrBa0_s, SdrBa1_s : std_logic;
    signal SdrAdr_s : unsigned(12 downto 0);
    signal SdrDat_s : unsigned(15 downto 0);

    constant SdrCmd_pr : unsigned(3 downto 0) := "0010"; -- PRECHARGE
    constant SdrCmd_re : unsigned(3 downto 0) := "0001"; -- REFRESH
    constant SdrCmd_ms : unsigned(3 downto 0) := "0000"; -- MODE REGISTER
    constant SdrCmd_xx : unsigned(3 downto 0) := "0111"; -- NOP
    constant SdrCmd_ac : unsigned(3 downto 0) := "0011"; -- ACTIVATE
    constant SdrCmd_rd : unsigned(3 downto 0) := "0101"; -- READ
    constant SdrCmd_wr : unsigned(3 downto 0) := "0100"; -- WRITE
    constant SdrCmd_bt : unsigned(3 downto 0) := "0110"; -- BURST TERMINATE

    type typSdrRoutine is (SdrRoutine_Init, SdrRoutine_Idle, SdrRoutine_LoadRow, SdrRoutine_DirectWrite);
    signal curRow : unsigned(9 downto 0);
    signal sdr_write_active : std_logic := '0';

begin
    pMemClk <= clk; 
    pMemCke <= '1';
    pMemCs_n <= SdrCmd(3); pMemRas_n <= SdrCmd(2); pMemCas_n <= SdrCmd(1); pMemWe_n <= SdrCmd(0);
    pMemBa0 <= SdrBa0_s; pMemBa1 <= SdrBa1_s; pMemAdr <= SdrAdr_s; 
    pMemUdq <= '0'; pMemLdq <= '0'; 
    pMemDat <= SdrDat_s when sdr_write_active = '1' else (others => 'Z');

process(clk)
    variable SdrRoutine : typSdrRoutine := SdrRoutine_Init;
    variable SdrRoutineSeq : integer range 0 to 2048 := 0;
    variable SdrAddress : unsigned(23 downto 0);
begin
    if rising_edge(clk) then
        SdrCmd <= SdrCmd_xx; 
        rowLoadAck <= '0'; 
        directAck <= '0'; 
        wren_sdr <= '0';
        sdr_write_active <= '0';
        
        SdrBa0_s <= SdrBa0_s; SdrBa1_s <= SdrBa1_s; SdrAdr_s <= SdrAdr_s;

        case SdrRoutine is
            
            when SdrRoutine_Init =>
                if SdrRoutineSeq = 100 then 
                    SdrCmd <= SdrCmd_pr; SdrAdr_s(10) <= '1'; SdrBa0_s <= '0'; SdrBa1_s <= '0';
                elsif SdrRoutineSeq = 110 or SdrRoutineSeq = 120 then 
                    SdrCmd <= SdrCmd_re;
                elsif SdrRoutineSeq = 130 then 
                     SdrCmd <= SdrCmd_ms; 
                     -- CL3, Sequential, Burst Full Page
                     SdrAdr_s <= "000" & '0' & "00" & "011" & "0" & "111"; 
                elsif SdrRoutineSeq = 140 then 
                    SdrRoutine := SdrRoutine_Idle; 
                end if;
                SdrRoutineSeq := SdrRoutineSeq + 1;

            when SdrRoutine_Idle =>
                SdrRoutineSeq := 0;
                if (rowLoadReq = '1') then
                    curRow <= rowLoadNr;
                    SdrRoutine := SdrRoutine_LoadRow;
                elsif (directWriteReq = '1') then
                    SdrAddress := addrDirect;
                    SdrRoutine := SdrRoutine_DirectWrite;
                end if;

            when SdrRoutine_DirectWrite =>
                if SdrRoutineSeq = 0 then
                    SdrCmd <= SdrCmd_ac; 
                    SdrBa0_s <= SdrAddress(22); SdrBa1_s <= SdrAddress(23); 
                    SdrAdr_s <= SdrAddress(21 downto 9);
                elsif SdrRoutineSeq = 3 then
                    SdrCmd <= SdrCmd_wr; 
                    SdrAdr_s(10) <= '0'; -- NIENTE Auto-Precharge per i Full Page
                    SdrAdr_s(8 downto 0) <= SdrAddress(8 downto 0);
                    SdrDat_s <= pixelDirectIn;
                    sdr_write_active <= '1';
                elsif SdrRoutineSeq = 4 then
                    -- Stoppiamo immediatamente la scrittura a raffica
                    SdrCmd <= SdrCmd_bt; 
                    directAck <= '1'; 
                elsif SdrRoutineSeq = 6 then 
                    -- Attendiamo il tWR (Write Recovery) e poi forziamo il Precharge
                    SdrCmd <= SdrCmd_pr;
                    SdrAdr_s(10) <= '1'; 
                elsif SdrRoutineSeq = 10 then 
                    SdrRoutine := SdrRoutine_Idle;
                end if;
                SdrRoutineSeq := SdrRoutineSeq + 1;

            when SdrRoutine_LoadRow =>
                if SdrRoutineSeq = 0 then
                    SdrCmd <= SdrCmd_ac; SdrBa0_s <= '0'; SdrBa1_s <= '0';
                    SdrAdr_s <= "000" & curRow;
                    colLoadNr <= (others => '0');
                elsif SdrRoutineSeq = 3 then
                    SdrCmd <= SdrCmd_rd;
                    SdrAdr_s <= (others => '0'); SdrAdr_s(10) <= '0'; 
                
                -- INTERCETTAMENTO: Il Precharge va inviato 3 cicli (CL=3) PRIMA della fine cattura
                elsif SdrRoutineSeq = 4 + page0 then
                    SdrCmd <= SdrCmd_pr; 
                    SdrBa0_s <= '0'; SdrBa1_s <= '0'; SdrAdr_s(10) <= '0'; 

                -- Cattura Bank 0
                elsif SdrRoutineSeq >= 7 and SdrRoutineSeq < 7 + page0 then
                    pixelOut <= pMemDat;
                    wren_sdr <= '1';
                    -- Evitiamo il bug "Off-by-one": l'indirizzo avanza dal ciclo 8 in poi
                    if SdrRoutineSeq > 7 then 
                        colLoadNr <= colLoadNr + 1;
                    end if;

                -- Attivazione Bank 1
                elsif SdrRoutineSeq = 8 + page0 then
                    SdrCmd <= SdrCmd_ac; SdrBa0_s <= '0'; SdrBa1_s <= '1';
                    SdrAdr_s <= "000" & curRow;
                elsif SdrRoutineSeq = 11 + page0 then
                    SdrCmd <= SdrCmd_rd;
                    SdrAdr_s <= (others => '0'); SdrAdr_s(10) <= '0'; 

                -- INTERCETTAMENTO Bank 1
                elsif SdrRoutineSeq = 12 + page0 + page1 then
                    SdrCmd <= SdrCmd_pr; 
                    SdrBa0_s <= '0'; SdrBa1_s <= '1'; SdrAdr_s(10) <= '0';

                -- Cattura Bank 1
                elsif SdrRoutineSeq >= 15 + page0 and SdrRoutineSeq < 15 + page0 + page1 then
                    pixelOut <= pMemDat;
                    wren_sdr <= '1';
                    -- Qui incrementiamo sempre per riagganciarci all'ultimo valore del Bank 0
                    colLoadNr <= colLoadNr + 1; 

                elsif SdrRoutineSeq = 18 + page0 + page1 then 
                    rowLoadAck <= '1';
                    SdrRoutine := SdrRoutine_Idle;
                end if;
                SdrRoutineSeq := SdrRoutineSeq + 1;

        end case;
    end if;
end process;
end rtl;