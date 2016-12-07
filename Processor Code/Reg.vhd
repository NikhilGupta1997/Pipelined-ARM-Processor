----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:23:47 03/15/2016 
-- Design Name: 
-- Module Name:    Reg - Behavioral 
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

entity Reg is
port( clk:in STD_LOGIC;
		read_write_enable:in STD_LOGIC;
		input:in STD_LOGIC_VECTOR(31 downto 0);
		output:out STD_LOGIC_VECTOR(31 downto 0)
		);
end Reg;
 
architecture Behavioral of Reg is

signal temp:std_logic_vector(31 downto 0):= (others => '0');
begin

process(clk,input,read_write_enable)
	begin
			if(rising_edge(clk)) then
			output <= temp;
			temp <= input;
			end if;
	end process;
end Behavioral;

