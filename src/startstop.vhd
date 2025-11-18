library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity startstop is 
    port(
        clk : in std_logic;
        rst : in std_logic;
        button : in std_logic;
        is_running : out std_logic
    );
end entity startstop;

architecture rtl of startstop is 
-- FSM state 
    type state_type is (IDLE1,IDLE2, IDLE3, RUN);
    signal state : state_type := IDLE2; -- initialization
begin     
    process(clk, rst)
    begin 
        if rst = '1' then 
            state <= IDLE2; 
        elsif rising_edge(clk) then 
            case state is 
                when IDLE2 => 
                    if button = '1' then -- PRESSED 
                        state <= IDLE3 ;
                    end if;

                when IDLE3 =>
                    if button = '0' then -- PRESSED 
                        state <= RUN ; 

                    end if; 
                when RUN  =>
                    if button = '1' then -- PRESSED 
                        state <= IDLE1; 

                    end if;   
                when IDLE1 =>
                    if button = '0' then -- PRESSED 
                        state <= IDLE2; 

                    end if;               
            end case ; 
        end if ;
    end process;
    is_running <= '1' when state = RUN else '0';
end architecture rtl;