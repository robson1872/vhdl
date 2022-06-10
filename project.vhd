library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity project is
    port (
        clk, reset, nickel, dime, quarter: in std_logic;
        dispense, returnickel, returndime, returntwodimes: out std_logic
    );
end;

architecture arch of project is
    type statetype is (v0, v5, v10, v15, v20, v25, v30, v35, v40, v45);
    signal state : statetype := v0;
	 signal prvnickel, prvdime, prvquarter :std_logic := '0';
	 signal nickel_on,dime_on,quarter_on :std_logic := '0';
	 
begin
    process(clk,reset)
    begin
        if (reset = '1') then state <= v0;dispense <= '0';returnickel <= '0';returndime <= '0';returntwodimes <= '0';
		  elsif (rising_edge(clk)) then 
			if(state = v0)then  if (nickel_on = '1') then state <= v5 ;
					elsif (dime_on = '1') then state <= v10 ;
					elsif (quarter_on = '1') then  state <= v25 ;
					end if;
			elsif(state = v5) then if (nickel_on = '1') then state <= v10 ;
					elsif (dime_on = '1') then state <= v15 ;
					elsif (quarter_on = '1') then state <= v30 ;
					end if;
			elsif(state = v10) then if (nickel_on = '1') then state <= v15 ;
					elsif (dime_on = '1') then state <= v20 ;
					elsif (quarter_on = '1') then state <= v35 ;
					end if;
			elsif(state = v15) then if (nickel_on = '1') then state <= v20 ;
					elsif (dime_on = '1') then state <= v25 ;
					elsif (quarter_on = '1') then state <= v40;
					end if;
			elsif(state = v20)then if (nickel_on = '1') then state <= v25 ;
					elsif (dime_on = '1') then state <= v30 ;
					elsif (quarter_on = '1') then state <= v45 ;
					end if;
			elsif(state = v25)then dispense <= '1';
			elsif(state = v30)then dispense <= '1';
					returnickel <= '1';
			elsif(state = v35)then dispense <= '1';
					returndime <= '1';
			elsif(state = v40)then dispense <= '1';
					returnickel <= '1';
					returndime <= '1';
			elsif(state = v45) then dispense <= '1';
					returntwodimes <= '1';
			end if;
			if (nickel = '1' and prvnickel = '0') then nickel_on <= '1';
				elsif(nickel = '1') then nickel_on <= '0';
				else  nickel_on <= '0';
				end if;
				
				if (dime = '1' and prvdime = '0') then dime_on <= '1';
				elsif(dime ='1') then dime_on <= '0';
				else  dime_on <= '0';
				end if;
				
				if (quarter = '1' and prvquarter = '0') then  quarter_on <= '1';
				elsif(quarter = '1')then quarter_on <= '0';
				else  quarter_on <= '0';
				end if;
			prvnickel <= nickel;
			prvdime <= dime;
			prvquarter <= quarter;
        end if;
		  
    end process;
end arch ;