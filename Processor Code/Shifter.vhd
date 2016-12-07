----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:27:56 03/15/2016 
-- Design Name: 
-- Module Name:    Shifter - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;

entity Shifter is
port( input:in STD_LOGIC_VECTOR(31 downto 0);
		shift_type:in STD_LOGIC_VECTOR(1 downto 0);
		shift_amount:in STD_LOGIC_VECTOR(4 downto 0);
		output:out STD_LOGIC_VECTOR (31 downto 0);
		enable:in STD_LOGIC
		);
end Shifter;

architecture Behavioral of Shifter is

begin

process(enable, input, shift_amount, shift_type)
variable shift:integer;
variable zero:std_logic_vector(31 downto 0):=(others=> '0');
variable one:std_logic_vector(31 downto 0):=(others=> '1');
begin 
shift := to_integer(unsigned(shift_amount));
	if(enable = '1') then
		if(shift /= 0) then
			if(shift_type = "00") then
				output(31 downto shift) <= input(31 - shift downto 0);
				output(shift -1  downto 0) <= zero(31 downto 32-shift);
			elsif(shift_type = "01") then
				output(31-shift downto 0) <= input(31 downto shift);
				output(31 downto 32 - shift) <= zero(shift-1 downto 0);
			elsif(shift_type = "10") then
				output(31-shift downto 0) <= input(31 downto shift);
				if(input(31) = '0') then
				output(31 downto 32 - shift) <= zero(shift-1 downto 0);
				else
				output(31 downto 32 - shift) <= one(shift-1 downto 0);
				end if;
			else
				output <= to_stdlogicvector(to_bitvector(input(31 downto 0))ror shift);
			end if;
		else output <= input;
		end if;
	else
		output <= input;
	end if;
	
end process;

end Behavioral;

