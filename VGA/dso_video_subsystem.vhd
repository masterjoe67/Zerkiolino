library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dso_video_subsystem is
    port (
        clk_cpu      : in std_logic;    -- 60.00 MHz
        clk_sync     : in std_logic;    -- 114.54 MHz
        clk_vga      : in std_logic;    -- 25.2 MHz
        clk_pixel    : in std_logic;    -- 114.54 MHz
        reset_n      : in std_logic;

        -- Interfaccia CPU
        vga_cs       : in  std_logic;
        vga_we       : in  std_logic;
        vga_addr     : in  std_logic_vector(3 downto 0);
        vga_wdata    : in  std_logic_vector(7 downto 0);
        vga_rdata    : out std_logic_vector(7 downto 0);
        
        sdram_busy   : out std_logic;

        -- Pin Fisici SDRAM e VGA
        vga_hsync    : out std_logic;
        vga_vsync    : out std_logic;
        vga_rgb      : out std_logic_vector(8 downto 0);
        dram_clk     : out std_logic;
        dram_cke     : out std_logic;
        dram_cs_n    : out std_logic;
        dram_ras_n   : out std_logic;
        dram_cas_n   : out std_logic;
        dram_we_n    : out std_logic;
        dram_ba      : out std_logic_vector(1 downto 0);
        dram_addr    : out unsigned(12 downto 0);
        dram_dqm     : out std_logic_vector(1 downto 0);
        dram_dq      : inout unsigned(15 downto 0)
    );
end dso_video_subsystem;

architecture rtl of dso_video_subsystem is

    -- Registri di coordinate e controllo
    signal reg_x             : unsigned(9 downto 0) := (others => '0');
    signal reg_y             : unsigned(9 downto 0) := (others => '0');
    signal reg_data_low      : std_logic_vector(7 downto 0) := (others => '0');
    signal video_active_reg  : std_logic := '1'; 
    signal scanline_reg      : std_logic := '1';
    
    signal vga_we_prev        : std_logic := '0';

    -- Buffer Pagine (Pagine da 1MB @ 32MB SDRAM = 32 Pagine)
    signal reg_read_page  : std_logic_vector(4 downto 0) := (others => '0'); -- Mapped to 0xC007
    signal reg_write_page : std_logic_vector(4 downto 0) := (others => '0'); -- Mapped to 0xC008

    -- Buffer Pendente per Scrittura Sicura
    signal pending_pixel_wr  : std_logic := '0';
    signal pending_fifo_data : std_logic_vector(39 downto 0) := (others => '0');

    -- Segnali DCFIFO (40 bit: 24 addr + 16 data)
    signal fifo_wr_data      : std_logic_vector(39 downto 0);
    signal fifo_rd_data      : std_logic_vector(39 downto 0);
    signal fifo_wr_req       : std_logic := '0';
    signal fifo_rd_req       : std_logic := '0';
    signal fifo_empty        : std_logic;
    signal fifo_full         : std_logic;

    -- Segnali Interni per SDRAM e VGA
    signal sdr_pixel_out    : unsigned(15 downto 0);
    signal sdr_col_wr_addr  : unsigned(9 downto 0);
    signal vga_row_req_addr : unsigned(9 downto 0);
    signal vga_col_req_addr : unsigned(9 downto 0);
    signal vga_bus_internal : unsigned(10 downto 0);
    signal sdr_load_req      : std_logic;
    signal sdr_load_ack      : std_logic;
    signal wren_sdr_to_ram2 : std_logic;
    signal ram2_q_vec        : std_logic_vector(15 downto 0);

    component vga_fifo
        port (
            aclr    : in  std_logic := '0';
            data    : in  std_logic_vector(39 downto 0);
            rdclk   : in  std_logic;
            rdreq   : in  std_logic;
            wrclk   : in  std_logic;
            wrreq   : in  std_logic;
            q       : out std_logic_vector(39 downto 0);
            rdempty : out std_logic;
            wrfull  : out std_logic;
            wrusedw : OUT STD_LOGIC_VECTOR (5 DOWNTO 0)
        );
    end component;

begin

    ------------------------------------------------------------------
    -- 1. LOGICA DI WAIT (SDRAM_BUSY)
    ------------------------------------------------------------------
    sdram_busy <= fifo_full or pending_pixel_wr;

    ------------------------------------------------------------------
    -- 2. ISTANZIAZIONE FIFO
    ------------------------------------------------------------------
    pixel_fifo : vga_fifo
        port map (
            aclr    => not reset_n,
            data    => fifo_wr_data,
            wrclk   => clk_cpu,
            wrreq   => fifo_wr_req,
            rdclk   => clk_pixel,
            rdreq   => fifo_rd_req,
            q       => fifo_rd_data,
            rdempty => fifo_empty,
            wrfull  => fifo_full,
            wrusedw => open
        );

    ------------------------------------------------------------------
    -- 3. GESTIONE SCRITTURA E REGISTRI (Dominio clk_cpu)
    ------------------------------------------------------------------
    process(clk_cpu, reset_n)
        variable addr_temp : unsigned(23 downto 0);
    begin
        if reset_n = '0' then
            reg_x <= (others => '0');
            reg_y <= (others => '0');
            reg_data_low <= (others => '0');
            vga_we_prev <= '0';
            fifo_wr_req <= '0';
            pending_pixel_wr <= '0';
            reg_read_page <= (others => '0');
            reg_write_page <= (others => '0');
        elsif rising_edge(clk_cpu) then
            vga_we_prev <= vga_we;
            fifo_wr_req <= '0'; 

            -- A) CATTURA REGISTRI (Edge Detector)
            if vga_cs = '1' and vga_we = '1' and vga_we_prev = '0' then
                case vga_addr is
                    when x"0" => reg_x(7 downto 0) <= unsigned(vga_wdata);
                    when x"1" => reg_x(9 downto 8) <= unsigned(vga_wdata(1 downto 0));
                    when x"2" => reg_y(7 downto 0) <= unsigned(vga_wdata);
                    when x"3" => reg_y(9 downto 8) <= unsigned(vga_wdata(1 downto 0));
                    when x"4" => reg_data_low      <= vga_wdata;
                    
                    when x"5" => 
    -- addr_temp deve essere costruito per pilotare SdrAddress nel controller
    -- Struttura: [Pagina 5-bit][Bank 1-bit][Y 9-bit][X 9-bit]
    if reg_x < 320 then
        -- Scrive nel Banco 0 della pagina selezionata
        addr_temp := unsigned(reg_write_page) & '0' & reg_y(8 downto 0) & reg_x(8 downto 0);
    else
        -- Scrive nel Banco 1 della pagina selezionata
        addr_temp := unsigned(reg_write_page) & '1' & reg_y(8 downto 0) & unsigned(reg_x - 320)(8 downto 0);
    end if;
    
    pending_fifo_data <= std_logic_vector(addr_temp) & vga_wdata & reg_data_low;
    pending_pixel_wr <= '1';

                    when x"6" => 
                        video_active_reg <= vga_wdata(0);
                        scanline_reg     <= vga_wdata(1);

                    when x"7" => 
                        reg_read_page  <= vga_wdata(4 downto 0); -- Numero pagina visualizzata
                    when x"8" => 
                        reg_write_page <= vga_wdata(4 downto 0); -- Numero pagina in scrittura
                    when others => null;
                end case;
            end if;

            -- B) SMALTIMENTO IN FIFO
            if pending_pixel_wr = '1' and fifo_full = '0' then
                fifo_wr_data <= pending_fifo_data;
                fifo_wr_req  <= '1';
                pending_pixel_wr <= '0'; 
            end if;

        end if;
    end process;

    -- Lettura Registri di stato
    process(vga_cs, vga_addr, fifo_full, video_active_reg, scanline_reg)
    begin
        vga_rdata <= (others => '0');
        if vga_cs = '1' then
            case vga_addr is
                when x"5" => vga_rdata <= "0000000" & fifo_full; 
                when x"6" => vga_rdata <= "000000" & scanline_reg & video_active_reg;
                when others => vga_rdata <= x"00";
            end case;
        end if;
    end process;

    ------------------------------------------------------------------
    -- 4. ISTANZIAZIONE COMPONENTI
    ------------------------------------------------------------------
    sdram_ctrl : entity work.sdram
        generic map ( page0 => 320, page1 => 320 )
        port map (
            clk             => clk_pixel,
            pixelOut        => sdr_pixel_out,
            read_page       => reg_read_page, -- COLLEGAMENTO AGGIUNTO
            rowLoadNr       => vga_row_req_addr,
            rowLoadReq      => sdr_load_req,
            rowLoadAck      => sdr_load_ack,
            colLoadNr       => sdr_col_wr_addr,
            wren_sdr        => wren_sdr_to_ram2,
            
            -- Interfaccia FIFO 
            addrDirect      => unsigned(fifo_rd_data(39 downto 16)),
            pixelDirectIn   => unsigned(fifo_rd_data(15 downto 0)),
            directWriteReq  => not fifo_empty, 
            directAck       => fifo_rd_req, 

            pMemClk => dram_clk, pMemCke => dram_cke, pMemCs_n => dram_cs_n,
            pMemRas_n => dram_ras_n, pMemCas_n => dram_cas_n, pMemWe_n => dram_we_n,
            pMemUdq => dram_dqm(1), pMemLdq => dram_dqm(0),
            pMemBa1 => dram_ba(1), pMemBa0 => dram_ba(0),
            pMemAdr => dram_addr, pMemDat => dram_dq
        );

    read_buffer : entity work.ram2
        port map (
            data => std_logic_vector(sdr_pixel_out), 
            wraddress => std_logic_vector(sdr_col_wr_addr),
            wrclock => clk_sync, 
            wren => wren_sdr_to_ram2, 
            rdaddress => std_logic_vector(vga_col_req_addr),
            rdclock => clk_vga, 
            q => ram2_q_vec
        );

    vga_engine : entity work.vgaout
        port map (
            clock_vga => clk_vga, 
            clock_dram => clk_pixel, 
            video_active => video_active_reg,
            scanline => scanline_reg, 
            pixel_in => unsigned(ram2_q_vec), 
            load_req => sdr_load_req,
            load_ack => sdr_load_ack, 
            row_number => vga_row_req_addr, 
            col_number => vga_col_req_addr,
            vga_out => vga_bus_internal
        );

    vga_hsync <= std_logic(vga_bus_internal(1));
    vga_vsync <= std_logic(vga_bus_internal(0));
    vga_rgb   <= std_logic_vector(vga_bus_internal(10 downto 2));

end rtl;