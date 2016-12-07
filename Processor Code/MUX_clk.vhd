----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:53:16 03/17/2016 
-- Design Name: 
-- Module Name:    MUX_clk - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_clk is
port( clk : in STD_LOGIC;
input1 : in STD_LOGIC_VECTOR(31 downto 0);
input2 : in STD_LOGIC_VECTOR(31 downto 0);
output : out STD_LOGIC_VECTOR(31 downto 0);
sig : in STD_LOGIC);
end MUX_clk;

architecture Behavioral of MUX_clk is

signal temp: std_logic:= '0';

begin
process(clk)
--variable store : std_logic_vector
		begin
		if(rising_edge(clk)) then
			temp <= sig;
			if(temp = '0') then
				output <= input1;
			else
				output <= input2;
			end if;
		end if;
		end process;

end Behavioral;

