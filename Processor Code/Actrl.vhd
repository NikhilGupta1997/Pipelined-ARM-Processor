----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:12 03/15/2016 
-- Design Name: 
-- Module Name:    Actrl - Behavioral 
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

entity Actrl is
port( instruction: in STD_LOGIC_VECTOR ( 5 downto 0);
		operation: out STD_LOGIC_VECTOR ( 3 downto 0)
		);
end Actrl;

architecture Behavioral of Actrl is
signal temp: std_logic_vector(3 downto 0);

begin
temp <= instruction(3 downto 0);

process(instruction, temp)
	begin
		if(instruction(5) = '1') then
			if(instruction(2) = '1') then
				operation <= "0100";
			else
				operation <= "0010";
			end if;
		else
			case (temp) is
				when ("0000") =>	operation <= "0000";				
				when ("0001") =>  operation <= "0001";
				when ("0010") =>  operation <= "0010";
				when ("0011") =>  operation <= "0011";
				when ("0100") =>  operation <= "0100";
				when ("0101") =>  operation <= "0101";
				when ("0110") =>  operation <= "0110";
				when ("0111") =>  operation <= "0111";
				when ("1000") =>  operation <= "1000";
				when ("1001") =>  operation <= "1001";
				when ("1010") =>  operation <= "1010";
				when ("1011") =>  operation <= "1011";
				when ("1100") =>  operation <= "1100";
				when ("1101") =>  operation <= "1101";
				when ("1110") =>  operation <= "1110";
				when others =>    operation <= "1111";
			end case;
		end if;
	end process;

end Behavioral;

