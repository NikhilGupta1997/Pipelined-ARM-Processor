----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:22:54 03/15/2016 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
port(
		enable: in std_logic;
		data:in std_logic_vector(31 downto 0);
		out1:out std_logic_vector(31 downto 0);
		out2:out std_logic_vector(31 downto 0);
		clk:in std_logic;
		offset:in std_logic_vector(23 downto 0)
		);
end PC;

architecture Behavioral of PC is
signal temp1:std_logic_vector(31 downto 0) := (others => '0');
signal temp2:std_logic_vector(31 downto 0) := (others => '0');
signal temp3:std_logic_vector(31 downto 0) := (others => '0');
signal temp4:std_logic_vector(31 downto 0) := (others => '0');
signal word_offset:std_logic_vector(23 downto 0) :=(others => '0');

begin

process(clk)

variable off:integer := to_integer(unsigned(word_offset));
variable byte_offset:integer := off*4;
	begin 
	word_offset(23 downto 0) <= offset;
		out1 <= (others => '0');
		out2 <= (others => '0');
		if(falling_edge(clk))then
			out1 <= data + 1;
			out2 <= data + 1 + word_offset;
		elsif(rising_edge(clk))then
			temp3 <= temp1;
			temp4 <= temp2;
	
		end if;
		

	end process;

--process(clk, temp1, temp2)
--	begin
--		if(rising_edge(clk))then
--			if(branch = '1') then
--				PCout <= temp2;
--			else
--				PCout <= temp1;
--			end if;
--		end if;
--	end process;
		
end Behavioral;

