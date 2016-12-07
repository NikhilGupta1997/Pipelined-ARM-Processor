----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:27:30 03/15/2016 
-- Design Name: 
-- Module Name:    Rotater - Behavioral 
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
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;

entity Rotater is
port( input: in std_logic_vector(7 downto 0);
output: out std_logic_vector(31 downto 0);
enable :in std_logic;
rot_amount : in std_logic_vector(3 downto 0)
);
end Rotater;

architecture Behavioral of Rotater is

begin

process(input, rot_amount, enable)
variable rot:integer;
variable rot2:integer;
variable store:std_logic_vector(31 downto 0):=(others => '0');
	begin
		rot := to_integer(unsigned(rot_amount(3 downto 0)));
		rot2 := rot*2;
		store(7 downto 0 ) := input(7 downto 0);
		if(enable = '1')then
			output<= to_stdlogicvector(to_bitvector(store)ror rot2);	
		else 
			output<=store;
		end if;
	end process;


end Behavioral;
