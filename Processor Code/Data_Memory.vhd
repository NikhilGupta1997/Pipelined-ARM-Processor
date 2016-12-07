----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:20:51 03/15/2016 
-- Design Name: 
-- Module Name:    Data_memory - Behavioral 
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

entity Data_memory is
port( clk:in std_logic;
address: in std_logic_vector(31 downto 0);
writen: in std_logic;
readen: in std_logic;
enable: in std_logic;
datai: in std_logic_vector(31 downto 0);
datao : out std_logic_vector(31 downto 0)
);
end Data_memory;

architecture Behavioral of Data_memory is
type mem is array(511 downto 0) of std_logic_vector (31 downto 0);
signal Data_Memory: mem:= (others => (others => '0'));

begin

process(clk, address, writen, readen, enable, datai)
	begin
			if(enable = '1') then
				if(writen = '1' and falling_edge(clk)) then
					Data_Memory(to_integer(unsigned(address))) <= datai;
				end if;
				if(readen = '1') then
					datao <= Data_Memory(to_integer(unsigned(address)));
				end if;
			end if;
	end process;
end Behavioral;

