library ieee ; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity pwm is 
    port (
        clk : in std_logic ; 
        duty : in unsigned(7 downto 0);  -- 0 - 255
        pwm_out : out std_logic
    );

end entity ;

architecture rtl of pwm is 
    signal count : unsigned(19 downto 0) := (others => '0');
    signal threshold : unsigned (19 downto 0);
    constant ticks_per_period : integer := 1_000_000;
begin 
    threshold <= to_unsigned(to_integer(duty) * ticks_per_period / 255, threshold'length); 

    process(clk)
    begin 
        -- sequential stuff here 
        if rising_edge(clk) then 
            count <= count + 1 ;
            if to_integer(count) = ticks_per_period - 1 then
                count <= (others => '0') ; -- do i need to do counter <= (others => '0');
            end if ;
            if to_integer(count) < to_integer(threshold) then 
                pwm_out <= '1' ;
            else 
                pwm_out <= '0' ; 
            end if ;
        end if ;

    end process ; 

end architecture rtl; 
