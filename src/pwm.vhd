library ieee ; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity pwm is 
    port (
        clk : in std_logic; 
        rst : in std_logic;
        -- duty : in unsigned(7 downto 0);  -- 0 - 255 (8 bit range)
        pwm_slw : out std_logic;
        pwm_std : out std_logic;
        pwm_fst : out std_logic
    );

end entity ;

architecture rtl of pwm is 
    -- 200 uS (5 kHz) PWM & 100 MHz (10 nS) clock 
    signal tick : unsigned (14 downto 0); -- 20,000 ticks per one PWM period 
    signal pwm_count : unsigned (6 downto 0); -- 0 to 100
    constant ticks_per_period : integer := 20_000;
    constant tick_max : unsigned (14 downto 0) := to_unsigned(ticks_per_period-1, 15);


begin 

    tick_process : process(clk, rst) is 
    begin 
        if rst = '1' then
            tick <= (others => '0');
            pwm_count <= (others => '0');  
            
        elsif rising_edge(clk) then 
            if tick = tick_max then 
                tick <= (others => '0');

                if pwm_count = to_unsigned(99, pwm_count'length) then 
                    pwm_count <= (others => '0');
                else 
                    pwm_count <= pwm_count + 1;  -- add 1 every 200 uS 
                end if ;




            else 
                tick <= tick + 1;
                
            end if ;
        end if ;
    end process tick_process;

    pwm_slw  <= '1' when pwm_count < to_unsigned(25, pwm_count'length) else '0' ; 
    pwm_std <= '1' when pwm_count < to_unsigned(50, pwm_count'length) else '0';
    pwm_fst <= '1' when pwm_count < to_unsigned(75, pwm_count'length) else '0' ;




end architecture rtl; 
