----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:52:04 03/15/2016 
-- Design Name: 
-- Module Name:    FLAGS - Behavioral 
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

entity FLAGS is
port( flagin:in STD_LOGIC_VECTOR(3 downto 0);
		flagout:out STD_LOGIC_VECTOR(3 downto 0);
		Fset:in STD_LOGIC);
end FLAGS;

architecture Behavioral of FLAGS is

signal flag:std_logic_vector(3 downto 0):= (others => '0');

begin
process(flagin, Fset, flag)
	begin 
		if(Fset = '1') then
			flag <= flagin;
			flagout <= flagin;
		else
			flagout <= flag;
		end if;
	end process;
end Behavioral;

