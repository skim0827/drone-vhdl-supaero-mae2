library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all ; 

-- wrapper 
entity tb_startstop is 
end entity tb_startstop;

architecture sim of tb_startstop is 
-- Signal declarations 
    signal clk      : std_logic := '0';
    signal rst    : std_logic := '0';
    signal button   : std_logic := '0';
    signal is_running  : std_logic;

-- DUT instantiate 
    begin 
        uut : entity work.startstop 
            port map (
                clk     => clk,
                rst    => rst,
                button  => button, 
                is_running => is_running
            );

        clk_process : process 
        begin 
            while true loop
                clk <= '0';
                wait for 10 ns ; 
                clk <= '1';
                wait for 10 ns ;
            end loop ;

        end process clk_process ;

        stim_proc : process 
        begin 
        -- apply reset 
            rst <= '1'; wait for 40 ns;
            rst <= '0'; wait for 100 ns; 

        -- stimulate button press 
            button <= '1'; wait for 20 ms;
            button <= '0'; wait for 20 ms;

            button <= '1'; wait for 20 ms;
            button <= '0'; wait for 20 ms; 

        -- observe output 


            wait ;
        end process stim_proc;

end architecture sim;