library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity top is 
    port (
        clk             : in std_logic;
        button_rst      : in std_logic;

        sensorLeft      : in std_logic;
        sensorRight     : in std_logic;

        button_start    : in std_logic; 

        motorRight      : out std_logic;
        motorLeft       : out std_logic
    );
end entity;

architecture rtl of top is 
-- internal signals 
signal pwm_slw, pwm_std, pwm_fst    : std_logic;
signal state_move                   : std_logic;


begin 
    u_stopstart : entity work.startstop
        port map (
            clk         => clk,
            rst         => button_rst,
            button      => button_start,

            is_running  => state_move
        );

    u_pwm : entity work.pwm 
        port map (
            clk         => clk, 
            rst         => button_rst,

            pwm_fst     => pwm_fst,
            pwm_std     => pwm_std,
            pwm_slw     => pwm_slw
        );

    u_direction : entity work.direction 
        port map (
            clk         => clk,
            refPWMfst   => pwm_fst,
            refPWMstd   => pwm_std,
            refPWMslw   => pwm_slw,
            rst         => button_rst,
            sensorLeft  => sensorLeft,
            sensorRight => sensorRight,
            state_move  => state_move,
            motorLeft   => motorLeft,
            motorRight  => motorRight 
        );

end architecture;