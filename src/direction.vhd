library ieee;
use ieee.std_logic_1164.all;

entity direction is
    port (
        clk       : in std_logic;
        refPWMfst : in std_logic;
        refPWMstd : in std_logic; 
        refPWMslw : in std_logic;
        rst       : in std_logic;
        sensorLeft : in std_logic;
        sensorRight : in std_logic;
        state_move : in std_logic; -- '1' = run, '0' = stop

        motorLeft : out std_logic;
        motorRight : out std_logic
    );
end entity;

architecture rtl of direction is
begin
    process(rst, state_move, sensorLeft, sensorRight,
        refPWMfst, refPWMstd, refPWMslw) --combinational no clk 
    begin 
        if rst = '1' then 
            motorLeft <= '0'; 
            motorRight <= '0';


        elsif state_move = '1' then 
            if sensorLeft = '0' and sensorRight = '0' then -- move straight 
                motorLeft <= refPWMstd ;
                motorRight <= refPWMstd ;
            elsif sensorLeft = '0' and sensorRight = '1' then -- turn right 
                motorRight <= refPWMslw;
                motorLeft <= refPWMfst; 
            elsif sensorLeft = '1' and sensorRight = '0' then -- turn left 
                motorRight <= refPWMfst ; 
                motorLeft <= refPWMslw; 

            else -- both 1 
                motorRight <= '0';
                motorLeft <= '0'; 

            end if;
        else   
            motorLeft <= '0' ; 
            motorRight <= '0' ;

        end if ;
    end process; 
    
end architecture;