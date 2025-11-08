library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity startstop is 
    port(
        clk : in std_logic;
        reset : in std_logic;
        button : in std_logic;
        is_running : out std_logic
    );
end entity startstop;

architecture rtl of startstop is 
-- FSM state 
    type state_type is (IDLE, RUN);  
    signal state : state_type := IDLE; -- initialization


    signal button_prev : std_logic := '0'; 



begin     
    process(clk)
    begin 
        if rising_edge(clk) then 
            if reset = '1' then 
                state <= IDLE;
                button_prev <= '0';
            else 
            -- button edge detection 
                if (button = '1' and button_prev = '0') then  -- press 
                    case state is 
                        when IDLE =>
                            state <= RUN;

                        when RUN =>
                            state <= IDLE;
                     end case ; 
                end if ;
                button_prev <= button ; 
            end if ; 
        end if ;
    end process;
    is_running <= '1' when state = RUN else '0';
    
end architecture rtl;