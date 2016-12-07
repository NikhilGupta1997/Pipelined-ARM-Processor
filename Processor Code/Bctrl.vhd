----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:26:40 03/15/2016 
-- Design Name: 
-- Module Name:    Bctrl - Behavioral 
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

entity Bctrl is
port( instruction:in STD_LOGIC_VECTOR(3 downto 0);
		flags:in STD_LOGIC_VECTOR(3 downto 0); -- C,V,N,Z
		P:out STD_LOGIC);
end Bctrl;

architecture Behavioral of Bctrl is
	
begin
process(instruction, flags)
	begin 
		case(instruction) is
			when ("0000") =>	P <= flags(0);				
			when ("0001") =>  P <= not(flags(0));
			when ("0010") =>  P <= flags(3);
			when ("0011") =>  P <= not(flags(3));
			when ("0100") =>  P <= flags(1);
			when ("0101") =>  P <= not(flags(1));
			when ("0110") =>  P <= flags(2);
			when ("0111") =>  P <= not(flags(2));
			when ("1000") =>  P <= flags(3)and not(flags(0));
			when ("1001") =>  P <= not(flags(3)and not(flags(0)));
			when ("1010") =>  P <= flags(1) xnor flags(2) ;
			when ("1011") =>  P <= not(flags(1) xnor flags(2));
			when ("1100") =>  P <= not(flags(0)) and (flags(1) xnor flags(2));
			when ("1101") =>  P <= not(not(flags(0)) and (flags(1) xnor flags(2)));
			when ("1110") =>  P <= '1';
			when others =>    P <= '0';
		end case;
	end process;
end Behavioral;

