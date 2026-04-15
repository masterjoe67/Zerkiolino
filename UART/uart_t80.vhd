--**********************************************************************************************
-- UART Peripheral - Core T80 (Z80) - Versione Corretta 80MHz
--**********************************************************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity uart_t80 is 
    port(
        clk      : in  std_logic;        -- Clock 80MHz
        reset_n  : in  std_logic;        -- Reset attivo basso
        addr     : in  std_logic_vector(1 downto 0); 
        ce_n     : in  std_logic;        
        wr_n     : in  std_logic;        
        rd_n     : in  std_logic;        
        din      : in  std_logic_vector(7 downto 0); 
        dout     : out std_logic_vector(7 downto 0); 
        rxd      : in  std_logic;
        txd      : out std_logic
    );
end uart_t80;

architecture RTL of uart_t80 is

-- Registri Interni (Storage)
signal UDR_Tx       : std_logic_vector(7 downto 0);
signal UDR_Rx       : std_logic_vector(7 downto 0);
signal UBRR_reg     : std_logic_vector(7 downto 0);

-- Segnali individuali per USR (Status) per evitare Multiple Drivers
signal r_rxc, r_txc, r_udre, r_fe, r_dor : std_logic;
signal USR_internal : std_logic_vector(7 downto 0);

-- Segnali individuali per UCR (Controllo)
signal r_rxcie, r_txcie, r_udrie, r_rxen, r_txen, r_chr9, r_rxb8, r_txb8 : std_logic;
signal UCR_internal : std_logic_vector(7 downto 0);

-- Supporto per rilevamento fronti (Edge Detector)
signal wr_n_d       : std_logic;
signal wr_pulse     : std_logic;

-- Segnali UART Core
signal UART_Clk_En  : std_logic;
signal SR_Tx        : std_logic_vector(7 downto 0);
signal SR_Tx_In     : std_logic_vector(7 downto 0); 
signal TX_In_bit    : std_logic;
signal Flag_A, Flag_B : std_logic;
signal CHR9_Latched, TXB8_Latched : std_logic;

-- Macchina a stati Trasmettitore
signal nUART_Tr_St0 : std_logic;
signal st : std_logic_vector(11 downto 1); -- Tr_St1 to Tr_St11

-- Segnali decodifica
signal UDR_Wr_En, UCR_Wr_En, UBRR_Wr_En : std_logic;
signal UDR_Rd, USR_Rd, UCR_Rd, UBRR_Rd : std_logic;

-- Baud Generator
signal Baud_Gen_Cnt : std_logic_vector(7 downto 0);
signal Baud_Gen_Out : std_logic;
signal Div16_Cnt    : std_logic_vector(3 downto 0);
signal Div16_Eq     : std_logic;

-- Ricevitore (Segnali essenziali)
signal RXD_ResyncA, RXD_ResyncB : std_logic;
signal UART_Rc_Delay : std_logic;
signal UART_Rc_SR    : std_logic_vector(9 downto 0);

signal st_rx : std_logic_vector(2 downto 0);

begin

--========================================================================
-- EDGE DETECTOR E DECODIFICA
--========================================================================
process(clk) begin
    if rising_edge(clk) then wr_n_d <= wr_n; end if;
end process;
wr_pulse <= '1' when (wr_n = '0' and wr_n_d = '1') else '0';

UDR_Wr_En  <= '1' when (ce_n = '0' and wr_pulse = '1' and addr = "00" and r_txen = '1') else '0';
UCR_Wr_En  <= '1' when (ce_n = '0' and wr_pulse = '1' and addr = "10") else '0';
UBRR_Wr_En <= '1' when (ce_n = '0' and wr_pulse = '1' and addr = "11") else '0';

UDR_Rd  <= '1' when (ce_n = '0' and rd_n = '0' and addr = "00") else '0';
USR_Rd  <= '1' when (ce_n = '0' and rd_n = '0' and addr = "01") else '0';
UCR_Rd  <= '1' when (ce_n = '0' and rd_n = '0' and addr = "10") else '0';
UBRR_Rd <= '1' when (ce_n = '0' and rd_n = '0' and addr = "11") else '0';

-- Riassemblaggio registri per lettura
USR_internal <= r_rxc & r_txc & r_udre & r_fe & r_dor & "000";
UCR_internal <= r_rxcie & r_txcie & r_udrie & r_rxen & r_txen & r_chr9 & r_rxb8 & r_txb8;

--dout <= UDR_Rx       when UDR_Rd = '1' else
--        USR_internal when USR_Rd = '1' else
--        UCR_internal when UCR_Rd = '1' else
--        UBRR_reg     when UBRR_Rd = '1' else
--        (others => '0');

dout <= UDR_Rx       when (addr = "00" and rd_n = '0' and ce_n = '0') else
        USR_internal when (addr = "01" and rd_n = '0' and ce_n = '0') else
        UCR_internal when (addr = "10" and rd_n = '0' and ce_n = '0') else
        UBRR_reg     when (addr = "11" and rd_n = '0' and ce_n = '0') else
        (others => '0');

--========================================================================
-- BAUD RATE GENERATOR (80MHz)
--========================================================================
process(clk, reset_n) begin
    if reset_n='0' then
        Baud_Gen_Cnt <= (others => '0'); Baud_Gen_Out <= '0';
    elsif rising_edge(clk) then
        if UBRR_reg = Baud_Gen_Cnt then
            Baud_Gen_Cnt <= (others => '0'); Baud_Gen_Out <= '1';
        else
            Baud_Gen_Cnt <= Baud_Gen_Cnt + 1; Baud_Gen_Out <= '0';
        end if;
    end if;
end process;

process(clk, reset_n) begin
    if reset_n='0' then Div16_Cnt <= (others => '0');
    elsif rising_edge(clk) then
        if Baud_Gen_Out='1' then Div16_Cnt <= Div16_Cnt + 1; end if;
    end if;
end process;
Div16_Eq <= '1' when Div16_Cnt = "1111" else '0';

process(clk, reset_n) begin
    if reset_n='0' then UART_Clk_En <= '0';
    elsif rising_edge(clk) then UART_Clk_En <= Div16_Eq and Baud_Gen_Out;
    end if;
end process;

--========================================================================
-- TRASMETTITORE
--========================================================================
process(clk, reset_n) begin
    if reset_n='0' then
        UBRR_reg <= (others => '0');
        r_rxcie <= '0'; r_txcie <= '0'; r_udrie <= '0'; r_rxen <= '0'; r_txen <= '0'; r_chr9 <= '0'; r_txb8 <= '0';
    elsif rising_edge(clk) then
        if UBRR_Wr_En='1' then UBRR_reg <= din; end if;
        if UCR_Wr_En='1' then
            r_rxcie <= din(7); r_txcie <= din(6); r_udrie <= din(5);
            r_rxen  <= din(4); r_txen  <= din(3); r_chr9  <= din(2); r_txb8  <= din(0);
        end if;
    end if;
end process;

process(clk, reset_n) begin
    if (reset_n='0') then
        UDR_Tx <= (others => '0'); CHR9_Latched <= '0'; TXB8_Latched <= '0';
    elsif rising_edge(clk) then
        if (UDR_Wr_En = '1') then
            UDR_Tx <= din; CHR9_Latched <= r_chr9; TXB8_Latched <= r_txb8;
        end if;
    end if;
end process;

-- Logica UDRE (Buffer Vuoto)
--process(clk, reset_n) begin
--    if reset_n='0' then r_udre <= '1';
--    elsif rising_edge(clk) then
--        if UDR_Wr_En='1' then r_udre <= '0';
--        elsif (st(11)='1' and Flag_B='1' and UART_Clk_En='1') then r_udre <= '1';
--        end if;
--    end if;
--end process;

--========================================================================
-- Logica UDRE (Buffer Vuoto - Corretta per Singolo Buffer)
--========================================================================
process(clk, reset_n) begin
    if reset_n='0' then 
        r_udre <= '1';
    elsif rising_edge(clk) then
        if UDR_Wr_En='1' then 
            r_udre <= '0'; -- Occupato appena scrivo
        elsif (st(11)='1' and UART_Clk_En='1') then 
            r_udre <= '1'; -- Libero appena finisce lo Stop Bit (IGNORA Flag_B)
        end if;
    end if;
end process;

-- Macchina a stati TX semplificata (Shift Register)
process(clk, reset_n) begin
    if reset_n='0' then
        nUART_Tr_St0 <= '0'; st <= (others => '0'); Flag_A <= '0'; Flag_B <= '0';
    elsif rising_edge(clk) then
        -- Gestione Flag di caricamento
        if UDR_Wr_En='1' then
            if nUART_Tr_St0 = '0' then Flag_A <= '1'; else Flag_B <= '1'; end if;
        end if;

        if UART_Clk_En = '1' then
            nUART_Tr_St0 <= (Flag_A) or (nUART_Tr_St0 and not (st(11) and not Flag_B));
            st(1)  <= (not nUART_Tr_St0 and Flag_A) or (st(11) and (Flag_B));
            st(11 downto 2) <= st(10 downto 1);
            
            if st(1)='1' then Flag_A <= Flag_B; Flag_B <= '0'; end if;
        end if;
    end if;
end process;

-- TX Output logic
TX_In_bit <= '0' when st(1)='1' else -- Start bit
             UDR_Tx(0) when st(2)='1' else
             UDR_Tx(1) when st(3)='1' else
             -- ... (continuazione logica mux TX)
             '1';

process(clk, reset_n) begin
    if reset_n='0' then txd <= '1';
    elsif rising_edge(clk) then
        if (UART_Clk_En = '1') then
            if nUART_Tr_St0 = '1' then
                -- Semplificato per brevità: implementa lo shift reale qui
                if st(1)='1' then txd <= '0';
                elsif st(2)='1' then txd <= UDR_Tx(0);
                elsif st(3)='1' then txd <= UDR_Tx(1);
                elsif st(4)='1' then txd <= UDR_Tx(2);
                elsif st(5)='1' then txd <= UDR_Tx(3);
                elsif st(6)='1' then txd <= UDR_Tx(4);
                elsif st(7)='1' then txd <= UDR_Tx(5);
                elsif st(8)='1' then txd <= UDR_Tx(6);
                elsif st(9)='1' then txd <= UDR_Tx(7);
                elsif st(11)='1' then txd <= '1'; -- Stop bit
                end if;
            else txd <= '1';
            end if;
        end if;
    end if;
end process;

-- Logica TXC (Trasmissione Completata)
--process(clk, reset_n) begin
--    if reset_n='0' then r_txc <= '0';
--    elsif rising_edge(clk) then
--        if (st(11)='1' and Flag_B='0' and UART_Clk_En='1') then r_txc <= '1';
--        elsif UDR_Wr_En='1' or (USR_Rd='1' and din(6)='1') then r_txc <= '0';
--        end if;
--    end if;
--end process;

--========================================================================
-- Logica TXC (Trasmissione Completata - Corretta e Pulita)
--========================================================================
process(clk, reset_n) begin
    if reset_n='0' then 
        r_txc <= '0';
    elsif rising_edge(clk) then
        if (st(11)='1' and UART_Clk_En='1') then 
            r_txc <= '1'; -- Alzato alla fine dello Stop Bit
        elsif UDR_Wr_En='1' then 
            r_txc <= '0'; -- Resettato SOLO quando scrivo un nuovo dato
        end if;
    end if;
end process;

--========================================================================
-- RICEVITORE (Reinserito e Corretto)
--========================================================================

-- 1. Sincronizzazione segnale RXD (Anti-Metastabilità)
process(clk) begin
    if rising_edge(clk) then
        RXD_ResyncA <= rxd;
        RXD_ResyncB <= RXD_ResyncA;
    end if;
end process;

-- 2. Macchina a stati Ricevitore
-- 2. Macchina a stati Ricevitore (Versione Ottimizzata 80MHz)
process(clk, reset_n)
    variable rx_bit_cnt    : integer range 0 to 15;
    variable rx_sample_cnt : integer range 0 to 7; -- 0 a 7 per gli 8 bit
begin
    if reset_n = '0' then
        st_rx <= (others => '0');
        r_rxc <= '0';
        r_fe  <= '0';
        r_dor <= '0';
        UART_Rc_SR <= (others => '0');
        UDR_Rx <= (others => '0');
        rx_bit_cnt := 0;
        rx_sample_cnt := 0;
    elsif rising_edge(clk) then
        -- Reset flag RXC quando la CPU legge il dato (UDR_Rd)
        if UDR_Rd = '1' then 
            r_rxc <= '0'; 
        end if;

        if Baud_Gen_Out = '1' then
            case st_rx is
                when "000" => -- IDLE
                    if RXD_ResyncB = '0' then -- Possibile Start Bit
                        rx_bit_cnt := 0;
                        st_rx <= "001";
                    end if;

                when "001" => -- START BIT
                    if rx_bit_cnt = 7 then -- Centro dello Start Bit
                        if RXD_ResyncB = '0' then
                            rx_bit_cnt := 0;
                            rx_sample_cnt := 0;
                            st_rx <= "010";
                        else
                            st_rx <= "000"; -- Falso allarme
                        end if;
                    else
                        rx_bit_cnt := rx_bit_cnt + 1;
                    end if;

                when "010" => -- DATA BITS
                    if rx_bit_cnt = 15 then -- Centro del bit di dato
                        rx_bit_cnt := 0;
                        UART_Rc_SR(rx_sample_cnt) <= RXD_ResyncB;
                        if rx_sample_cnt = 7 then
                            st_rx <= "011";
                        else
                            rx_sample_cnt := rx_sample_cnt + 1;
                        end if;
                    else
                        rx_bit_cnt := rx_bit_cnt + 1;
                    end if;

                when "011" => -- STOP BIT
                    if rx_bit_cnt = 15 then
                        -- Check Overrun: se r_rxc è ancora 1, il vecchio dato non è stato letto
                        if r_rxc = '1' then 
                            r_dor <= '1'; 
                        else 
                            r_dor <= '0'; 
                        end if;

                        -- Check Frame Error: lo stop bit deve essere '1'
                        if RXD_ResyncB = '1' then
                            UDR_Rx <= UART_Rc_SR(7 downto 0);
                            r_rxc  <= '1'; -- Notifica Z80
                            r_fe   <= '0';
                        else
                            r_fe   <= '1'; -- Errore di sincronizzazione
                        end if;
                        
                        st_rx <= "000";
                    else
                        rx_bit_cnt := rx_bit_cnt + 1;
                    end if;

                when others => 
                    st_rx <= "000";
            end case;
        end if;
    end if;
end process;

--r_fe <= '0'; -- Placeholder per brevità
--r_dor <= '0';
--r_rxc <= '0';

end RTL;