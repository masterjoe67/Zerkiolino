library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Zerkiolino_ALU is
    Port (
        clk      : in  STD_LOGIC;
        reset_n  : in  STD_LOGIC;
        addr     : in  STD_LOGIC_VECTOR(3 downto 0); 
        data_in  : in  STD_LOGIC_VECTOR(7 downto 0);
        data_out : out STD_LOGIC_VECTOR(7 downto 0);
        nWR      : in  STD_LOGIC;
        nRD      : in  STD_LOGIC;
        nMREQ    : in  STD_LOGIC;
        cs_alu   : in  STD_LOGIC; 
        busy     : out STD_LOGIC
    );
end Zerkiolino_ALU;

architecture Behavioral of Zerkiolino_ALU is
    signal reg_a, reg_b : signed(31 downto 0) := (others => '0');
    signal res_64      : signed(63 downto 0) := (others => '0');
    signal res_div_r   : signed(31 downto 0) := (others => '0');
    signal div_busy    : std_logic := '0';
    signal div_count   : integer range 0 to 33 := 0;
    signal op_a_tmp, op_b_tmp : unsigned(31 downto 0) := (others => '0');
    signal quot_tmp, rem_tmp  : unsigned(31 downto 0) := (others => '0');
    signal sign_res    : std_logic := '0';
begin
    busy <= div_busy;

    -- SCRITTURA (Sincrona su rising_edge)
    process(clk, reset_n)
        variable next_rem : unsigned(31 downto 0);
    begin
        if reset_n = '0' then
            reg_a <= (others => '0'); reg_b <= (others => '0');
            res_64 <= (others => '0'); res_div_r <= (others => '0');
            div_busy <= '0';
        elsif rising_edge(clk) then
            if cs_alu = '1' and nWR = '0' then
                case addr is
                    when x"0" => reg_a(7 downto 0)   <= signed(data_in);
                    when x"1" => reg_a(15 downto 8)  <= signed(data_in);
                    when x"2" => reg_a(23 downto 16) <= signed(data_in);
                    when x"3" => reg_a(31 downto 24) <= signed(data_in);
                    when x"4" => reg_b(7 downto 0)   <= signed(data_in);
                    when x"5" => reg_b(15 downto 8)  <= signed(data_in);
                    when x"6" => reg_b(23 downto 16) <= signed(data_in);
                    when x"7" => reg_b(31 downto 24) <= signed(data_in);
                    when x"8" =>
                        case data_in is
                            when x"01" => res_64(31 downto 0) <= reg_a + reg_b; -- ADD
                            when x"02" => res_64(31 downto 0) <= reg_a - reg_b; -- SUB
                            when x"03" => res_64 <= reg_a * reg_b;              -- MUL
                            when x"04" => -- DIV START
                                if reg_b /= 0 then
                                    div_busy <= '1'; div_count <= 32;
                                    sign_res <= reg_a(31) xor reg_b(31);
                                    op_a_tmp <= unsigned(abs(reg_a)); op_b_tmp <= unsigned(abs(reg_b));
                                    quot_tmp <= (others => '0'); rem_tmp <= (others => '0');
                                end if;
                            when x"05" => res_64(31 downto 0) <= shift_left(reg_a, to_integer(reg_b(4 downto 0)));  -- SHL
                            when x"06" => res_64(31 downto 0) <= shift_right(reg_a, to_integer(reg_b(4 downto 0))); -- SHR
                            when others => null;
                        end case;
                    when others => null;
                end case;
            end if;

            -- Motore Divisione
            if div_busy = '1' then
                if div_count > 0 then
                    next_rem := (rem_tmp(30 downto 0) & op_a_tmp(div_count-1));
                    if next_rem >= op_b_tmp then
                        rem_tmp <= next_rem - op_b_tmp;
                        quot_tmp(div_count-1) <= '1';
                    else
                        rem_tmp <= next_rem;
                        quot_tmp(div_count-1) <= '0';
                    end if;
                    div_count <= div_count - 1;
                else
                    if sign_res = '1' then res_64(31 downto 0) <= -signed(quot_tmp);
                    else res_64(31 downto 0) <= signed(quot_tmp); end if;
                    res_div_r <= signed(rem_tmp);
                    div_busy <= '0';
                end if;
            end if;
        end if;
    end process;

    -- LETTURA (Combinatoria - Fondamentale per il bus T80)
    process(cs_alu, nRD, addr, res_64, res_div_r, div_busy)
    begin
        data_out <= x"00";
        if cs_alu = '1' and nRD = '0' then
            case addr is
                when x"9" => data_out <= "0000000" & div_busy;
                when x"A" => data_out <= std_logic_vector(res_64(7 downto 0));
                when x"B" => data_out <= std_logic_vector(res_64(15 downto 8));
                when x"C" => data_out <= std_logic_vector(res_64(23 downto 16));
                when x"D" => data_out <= std_logic_vector(res_64(31 downto 24));
                when x"E" => data_out <= std_logic_vector(res_64(39 downto 32)); -- Per MUL Q16.16
                when x"F" => data_out <= std_logic_vector(res_64(47 downto 40)); -- Per MUL Q16.16
                when x"0" => data_out <= std_logic_vector(res_div_r(7 downto 0));   -- Resto LSB
                when x"1" => data_out <= std_logic_vector(res_div_r(15 downto 8));  -- Resto MSB
                when others => data_out <= x"00";
            end case;
        end if;
    end process;
end Behavioral;