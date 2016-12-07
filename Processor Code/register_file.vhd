----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:35 03/15/2016 
-- Design Name: 
-- Module Name:    register_file - Behavioral 
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

entity register_file is
Port( clk:in std_logic;
	   enable:in STD_LOGIC;
		wenable:in STD_LOGIC;
		reada1:in STD_LOGIC_VECTOR(3 downto 0);
		reada2:in STD_LOGIC_VECTOR(3 downto 0);
		writea:in STD_LOGIC_VECTOR(3 downto 0);
		data:in STD_LOGIC_VECTOR(31 downto 0);
		out1:out STD_LOGIC_VECTOR(31 downto 0);
		out2:out STD_LOGIC_VECTOR(31 downto 0)
		);
end register_file;


architecture Behavioral of register_file is

type mem is array(15 downto 0) of std_logic_vector (31 downto 0);
signal registers: mem := (others => (others => '0'));

begin

process(clk, enable, writea, reada1, reada2, data, wenable)
	begin
			if(enable = '1') then
				if(wenable = '1' and falling_edge(clk)) then
					registers(to_integer(unsigned(writea))) <= data;
				end if;
			out1 <= registers(to_integer(unsigned(reada1)));
			out2 <= registers(to_integer(unsigned(reada2)));
			end if;
	end process;
end Behavioral;