library ieee;
use ieee.std_logic_1164.all;

entity tb_direction is
end entity;

architecture sim of tb_direction is

    signal clk          : std_logic := '0';
    signal refPWMfst    : std_logic := '0';
    signal refPWMstd    : std_logic := '0'; 
    signal refPWMslw    : std_logic := '0';
    signal rst          : std_logic := '0';
    signal sensorLeft   : std_logic := '0'; 
    signal sensorRight  : std_logic := '0'; 
    signal state_move   : std_logic := '0';

    signal motorRight   : std_logic ;
    signal motorLeft    : std_logic ; 

    signal pwm_slw      : std_logic; 
    signal pwm_std      : std_logic; 
    signal pwm_fst      : std_logic; 


begin

    u_pwm : entity work.pwm
        port map (
            clk         => clk, 
            rst         => rst,
            pwm_slw     => pwm_slw,
            pwm_std     => pwm_std,
            pwm_fst     => pwm_fst
        
        );
    
    u_direction : entity work.direction
        port map (
            clk         =>  clk,
            refPWMfst   =>  pwm_fst,
            refPWMstd   =>  pwm_std,
            refPWMslw   =>  pwm_slw,
            rst         => rst,
            sensorLeft  => sensorLeft,
            sensorRight => sensorRight,
            state_move  => state_move,

            motorRight  => motorRight,
            motorLeft   => motorLeft

        );
    
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    stimulus : process 
    begin 
        rst <= '1'; wait for 20 ns;
        rst <= '0'; wait for 20 ns;


        state_move <= '1';

        -- straight 
        sensorLeft  <= '0';
        sensorRight <= '0';
        wait for 40 ms;

        -- turn right  
        sensorLeft  <= '0';
        sensorRight <= '1';
        wait for 40 ms ;

        -- turn right  
        sensorLeft  <= '1';
        sensorRight <= '0';
        wait for 40 ms ;

        -- both 1 
        sensorRight <= '0';
        sensorLeft  <= '0';
        wait for 40 ms ;

        state_move  <= '0';
        wait for 20 ns;

        assert false report "Simulation finished" severity failure;
    end process; 
end architecture;