library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all ; 

-- wrapper 
entity tb_pwm is 
end entity tb_pwm;


architecture sim of tb_pwm is 
-- Signal declarations 
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';

    signal pwm_slw  : std_logic;
    signal pwm_std  : std_logic;
    signal pwm_fst  : std_logic;

-- DUT instantiate 
    begin 
        uut : entity work.pwm 
            port map (
                clk     => clk,
                rst     => rst,

                pwm_slw => pwm_slw,
                pwm_std => pwm_std,
                pwm_fst => pwm_fst
            );

-- Stimulus process and clock (50 Mhz, 20 ns) process 
    clk_process : process 
    begin 
        while true loop 
            clk     <= '0';
            wait for 5 ns; 
            clk     <= '1';
            wait for 5 ns;
        end loop ;
    end process;

    stim_process: process 
    begin 
        rst <= '1'; 
        wait for 50 ns;
        rst <= '0'; 
        wait ; 
    end process; 

    end_sim : process 
    begin 
        wait for 100 ms;
        assert false report "Simulation ended" severity failure; 
    end process;

end architecture sim ; 



