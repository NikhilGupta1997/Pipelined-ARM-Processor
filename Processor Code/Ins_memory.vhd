----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:22:23 03/15/2016 
-- Design Name: 
-- Module Name:    Ins_memory - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ins_memory is
port( clk:in std_logic;
address: in std_logic_vector(31 downto 0);
enable: in std_logic;
datao : out std_logic_vector(31 downto 0)
);
end Ins_memory;

architecture Behavioral of Ins_memory is
type mem is array(511 downto 0) of std_logic_vector (31 downto 0);
signal Instruction_Memory: mem:= (others => (others => '0'));

begin

process(clk, address, enable)
	begin
		--Instruction_Memory(1) <= "11100011101000000000000000001010";
		--Instruction_Memory(2) <= "11100011101000000001000000000101";
		--Instruction_Memory(3) <= x"E0802001";
		--Instruction_Memory(4) <= x"E0403001";
		--Instruction_Memory(5) <= x"E0214090";
		--Instruction_Memory(6) <= "11100101100000000001000000000010";
		--Instruction_Memory(7) <= "11100101100100000111000000000010";
		--Instruction_Memory(8) <= x"E1570001";
		--Instruction_Memory(9) <= x"00878001";
		--Instruction_Memory(10) <= x"E1510000";
		--Instruction_Memory(11) <= x"00819000";
		--Instruction_Memory(13) <= x"1041A000";
		
		--Instruction_Memory(12) <= x"1A000007";
		Instruction_Memory(1) <= x"E3A00003"; 
		Instruction_Memory(2) <= x"E3A01000";
		Instruction_Memory(3) <= x"E5810000";
		Instruction_Memory(4) <= x"E3A0000A";
		Instruction_Memory(5) <= x"E5810004";
		Instruction_Memory(6) <= x"E3A00006";
		Instruction_Memory(7) <= x"E5810008";
		Instruction_Memory(8) <= x"E3A00008";
		Instruction_Memory(9) <= x"E581000C";
		Instruction_Memory(10) <= x"E3A00001";
		Instruction_Memory(11) <= x"E5810010";
		Instruction_Memory(12) <= x"E3A01004";
		Instruction_Memory(13) <= x"E3510010"; --start
		Instruction_Memory(14) <= x"CA000010"; -- to done --
		
		Instruction_Memory(15) <= x"00000000";		
		Instruction_Memory(16) <= x"E1A02001";
		Instruction_Memory(17) <= x"E3520000"; --startinner
		Instruction_Memory(18) <= x"DA00000A"; -- to done innner --
		
		Instruction_Memory(19) <= x"00000000"; 
		Instruction_Memory(20) <= x"E5925000";
		Instruction_Memory(21) <= x"E5126004";
		Instruction_Memory(22) <= x"E1550006";
		Instruction_Memory(23) <= x"AA000002"; -- to skip --
		
		Instruction_Memory(24) <= x"00000000"; 		
		Instruction_Memory(25) <= x"E5826000";
		Instruction_Memory(26) <= x"E5025004";
		Instruction_Memory(27) <= x"E2422004"; --skip
		Instruction_Memory(28) <= x"EAFFFFF3"; -- to startinner --
		
		Instruction_Memory(29) <= x"00000000"; 
		Instruction_Memory(30) <= x"E2811004"; -- done inner
		Instruction_Memory(31) <= x"EAFFFFEC"; -- to start

	

		if(falling_edge(clk)) then
			
			if(enable = '1') then
			datao <= Instruction_Memory((conv_integer(address)mod 512));
			else
			datao <= Instruction_Memory((conv_integer(address)mod 512));
			end if;
		end if;
	end process;
end Behavioral;


