----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:59:11 03/15/2016 
-- Design Name: 
-- Module Name:    MUX_4 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_4 is
port( input1 : in STD_LOGIC_VECTOR(3 downto 0);
input2 : in STD_LOGIC_VECTOR(3 downto 0);
output : out STD_LOGIC_VECTOR(3 downto 0);
sig : in STD_LOGIC);
end MUX_4;

architecture Behavioral of MUX_4 is

begin
	process(input1, input2, sig)
		begin
			if(sig = '0') then
				output <= input1;
			else
				output <= input2;
			end if;
		end process;
end Behavioral;
