library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vgaout is
    generic(
        hor_active_video    : integer := 640;
        hor_front_porch     : integer := 16;
        hor_sync_pulse      : integer := 96;
        hor_back_porch      : integer := 48;
        vert_active_video   : integer := 480;
        vert_front_porch    : integer := 10;
        vert_sync_pulse     : integer := 2;
        vert_back_porch     : integer := 33        
    );
    port(
        clock_vga    : in std_logic;
        clock_dram   : in std_logic;
        vga_out      : out unsigned(10 downto 0); -- r(3), g(3), b(3), hsync, vsync
        pixel_in     : in unsigned(15 downto 0);        
        row_number   : out unsigned(9 downto 0);
        col_number   : out unsigned(9 downto 0); 
        load_req     : out std_logic := '0';
        load_ack     : in std_logic;
        scanline     : in std_logic;
        video_active : in std_logic -- 0: segnale AVR, 1: barre colore
    );
end vgaout;

architecture behavioral of vgaout is

    signal hcount : unsigned(11 downto 0) := (others => '0');
    signal vcount : unsigned(9 downto 0) := (others => '0');
    signal hsync_reg, vsync_reg : std_logic := '1';
    
    -- Funzione per l'effetto scanline (riduce la luminosità)
    function f_scanline(color_in: unsigned) return unsigned is
        variable tmp : unsigned(2 downto 0);
    begin
        case color_in is
            when "000" => tmp := "000";
            when "001" => tmp := "000";
            when "010" => tmp := "001";
            when "011" => tmp := "010";
            when "100" => tmp := "011";
            when "101" => tmp := "100";
            when "110" => tmp := "101";
            when "111" => tmp := "110";
            when others => tmp := "000";
        end case;
        return tmp;
    end f_scanline;

begin

    -- 1. GENERAZIONE TIMING VGA (HCOUNT e VCOUNT)
    process(clock_vga)
    begin
        if rising_edge(clock_vga) then
            -- Contatore Orizzontale
            if hcount = (hor_active_video + hor_front_porch + hor_sync_pulse + hor_back_porch - 1) then
                hcount <= (others => '0');
                -- Contatore Verticale
                if vcount = (vert_active_video + vert_front_porch + vert_sync_pulse + vert_back_porch - 1) then
                    vcount <= (others => '0');
                else
                    vcount <= vcount + 1;
                end if;
            else
                hcount <= hcount + 1;
            end if;
        end if;
    end process;

    -- 2. SEGNALI DI SINCRONISMO (H-Sync e V-Sync)
    process(clock_vga)
    begin
        if rising_edge(clock_vga) then
            -- HSync: attivo basso
            if hcount >= (hor_active_video + hor_front_porch) and 
               hcount < (hor_active_video + hor_front_porch + hor_sync_pulse) then
                hsync_reg <= '0';
            else
                hsync_reg <= '1';
            end if;

            -- VSync: attivo basso
            if vcount >= (vert_active_video + vert_front_porch) and 
               vcount < (vert_active_video + vert_front_porch + vert_sync_pulse) then
                vsync_reg <= '0';
            else
                vsync_reg <= '1';
            end if;
        end if;
    end process;

    -- 3. INDIRIZZAMENTO SDRAM / RAM LINE BUFFER
    --row_number <= vcount; -- Indirizzo riga per SDRAM
    
    process(clock_vga)
    begin
        if rising_edge(clock_vga) then
            -- col_number pilota la lettura della RAM2 (Line Buffer)
            -- Deve essere 0 esattamente quando hcount è 0.
            if hcount < hor_active_video then
                col_number <= hcount(9 downto 0);
            else
                col_number <= (others => '0');
            end if;
            
            -- row_number per la riga successiva o attuale
            row_number <= vcount;
        end if;
    end process;

    -- 4. RICHIESTA CARICAMENTO RIGA (LOAD_REQ)
    -- Carica la riga dalla SDRAM durante il Blanking Orizzontale
    process(clock_dram, load_ack)
    begin
        if load_ack = '1' then
            load_req <= '0';
        elsif rising_edge(clock_dram) then
            -- Chiediamo il caricamento appena finisce l'area attiva
            if hcount = (hor_active_video + 1) then 
                load_req <= '1';
            end if;
        end if;
    end process;

    -- 5. USCITA VIDEO (RGB + SYNC)
    process(clock_vga)
        variable is_blank : boolean;
        variable final_rgb : unsigned(8 downto 0);
        variable bar_rgb : unsigned(8 downto 0);
    begin
        if rising_edge(clock_vga) then
            is_blank := (hcount >= hor_active_video) or (vcount >= vert_active_video);
            
            -- Logica Barre Colore (Semplificata per test)
            if hcount < 213 then bar_rgb := "111000000"; -- Rosso
            elsif hcount < 426 then bar_rgb := "000111000"; -- Verde
            else bar_rgb := "000000111"; -- Blu
            end if;

            -- Selezione Sorgente (AVR o Barre)
            if video_active = '0' then
                final_rgb := pixel_in(8 downto 0);
            else
                final_rgb := bar_rgb;
            end if;

            -- Effetto Scanline
            if scanline = '0' and vcount(0) = '0' then
                final_rgb := f_scanline(final_rgb(8 downto 6)) & 
                             f_scanline(final_rgb(5 downto 3)) & 
                             f_scanline(final_rgb(2 downto 0));
            end if;

            -- Output finale con Blanking e Sync
            if is_blank then
                vga_out(10 downto 2) <= (others => '0');
            else
                vga_out(10 downto 2) <= final_rgb;
            end if;
            
            vga_out(1) <= hsync_reg;
            vga_out(0) <= vsync_reg;
        end if;
    end process;

end behavioral;