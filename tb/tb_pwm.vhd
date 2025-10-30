library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all ; 

-- wrapper 
entity tb_pwm is 
end entity tb_pwm;


architecture sim of tb_pwm is 
-- Signal declarations 
    signal clk      : std_logic := '0';
    signal duty     : unsigned(7 downto 0) := (others => '0');
    signal pwm_out  : std_logic;

-- DUT instantiate 
begin 
    uut : entity work.pwm 
        port map (
            clk     => clk,
            duty    => duty,
            pwm_out => pwm_out
        );
-- Stimulus process and clock (50 Mhz, 20 ns) process 
    clk_process : process 
    begin 
        while true loop 
            clk     <= '0';
            wait for 10 ns; 
            clk     <= '1';
            wait for 10 ns;
        end loop ;
    end process;

    stim_proc : process 
    begin 
        duty    <= to_unsigned(0, duty'length);    wait for 40 ms;
        duty    <= to_unsigned(128, duty'length);  wait for 40 ms; 
        duty    <= to_unsigned(255, duty'length);  wait for 40 ms;
        wait; -- stop 
    end process;

end architecture sim ; 



