library ieee; 
use ieee.std_logic_1164.all;


entity tb_top is 
end entity;

architecture sim of tb_top is 
    signal clk, button_rst, sensorLeft, sensorRight, button_start : std_logic := '0';
    signal motorRight, motorLeft                                  : std_logic;

begin 

    uut : entity work.top 
        port map (
            clk             => clk,
            button_rst      => button_rst,

            sensorLeft      => sensorLeft,
            sensorRight     => sensorRight,

            button_start    => button_start,

            motorLeft       => motorLeft,
            motorRight      => motorRight
        );

    
    clk_process : process
    begin 
        while true loop 
            clk         <= '0'; wait for 5 ns; -- 100Mhz 
            clk         <= '1'; wait for 5 ns;
        end loop;
    end process; 

    stimulus : process 
    begin 

    -- reset 
    button_rst          <=  '1'; wait for 20 ns ;
    button_rst          <= '0'; wait for 20 ns ;

    -- start 
    button_start        <= '1'; wait for 20 ns; -- press 
    button_start        <= '0'; wait for 20 ns; -- release 

    -- move straight 
    sensorLeft          <= '0';
    sensorRight         <= '0'; wait for 40 ms; 

    -- turn right 
    sensorLeft          <= '0';
    sensorRight         <= '1'; wait for 40 ms; 

    -- turn left 
    sensorLeft          <= '1';
    sensorRight         <= '0'; wait for 40 ms; 

    -- both 1s 
    sensorLeft          <= '1'; 
    sensorRight         <= '1'; wait for 40 ms;

    -- stop 
    button_start        <= '1'; wait for 20 ns;
    button_start        <= '0'; wait for 20 ns;

    wait ;

    end process; 

end architecture;