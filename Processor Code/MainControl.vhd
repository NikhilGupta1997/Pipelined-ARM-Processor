----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:51:07 03/15/2016 
-- Design Name: 
-- Module Name:    MainControl - Behavioral 
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

entity MainControl is
port(instruction: in STD_LOGIC_VECTOR(7 downto 0);
		check_mul: in STD_LOGIC_VECTOR(3 downto 0);
		p:in STD_LOGIC;
		mul_flag:out STD_LOGIC;
		Rot_en:out STD_LOGIC; 
		Shift_en:out STD_LOGIC;  
		Rsrc:out STD_LOGIC;
		RW:out STD_LOGIC;
		Asrc:out STD_LOGIC;
		MW:out STD_LOGIC;
		MR:out STD_LOGIC;
		M2R:out STD_LOGIC;
		Psrc:out STD_LOGIC;
		Fset:out STD_LOGIC;
		special:out STD_LOGIC);
end MainControl;

architecture Behavioral of MainControl is

begin

process(check_mul, p, instruction)
begin
	mul_flag <= '0';
	Rot_en <= '0';
	Shift_en <= '0';
	special <= '0';
	if(instruction(7) = '0' and instruction(6) = '0') then
		Rsrc <= '0';
		Asrc <= instruction(5);
		MW <= '0';
		MR <= '0';
		Psrc <= '0';
		M2R <= '0';
		if(instruction(5 downto 2) = "0000" and check_mul = "1001" and instruction(0)= '0') then -- mul 
			mul_flag <= '1';
			Fset <= '0';
			RW <= p;
		elsif(instruction(5 downto 2) = "0000" and check_mul = "1001" and instruction(0) = '1') then -- muls
			mul_flag <= '1';
			Fset <= p;
			RW <= p;
		elsif(instruction(4) = '0' and instruction(0) = '0') then
			RW <= p;
			Fset <= '0';
			Rot_en <= '0';
			Shift_en <= '1';
		elsif(instruction(4) = '0' and instruction(0) = '1') then
		   RW <= p;
			Fset <= p;
			Rot_en <= '1';
			Shift_en <= '0';
		elsif(instruction(3) = '1' and instruction(0) = '0') then
		   RW <= p;
			Fset <= '0';
			Rot_en <= '0';
			Shift_en <= '1';
		elsif(instruction(3) = '1' and instruction(0) = '1') then
		   RW <= p;
			Fset <= p;
			Rot_en <= '1';
			Shift_en <= '0';
		elsif(instruction(4) = '1' and instruction(3) = '0') then -- cmp
		   RW <= '0';
			Fset <= p;
			Rot_en <= '0';
			Shift_en <= '0';
		end if;
	elsif(instruction(7) = '0' and instruction(6) = '1') then
		Rsrc <= '1';
		Asrc <= '1';
		Fset <= '0';
		Psrc <= '0';
		M2R <= '1';
		if(instruction(0) = '0') then -- str
			RW <= '0';
			MW <= p;
			MR <= '0';
			special <= '1';
		elsif(instruction(0) = '1') then -- ldr
			RW <= p;
			MW <= '0';
			MR <= '1';
		end if;
	elsif(instruction(7) = '1' and instruction(6) = '0') then --branch
		Rsrc <= '0';
		Asrc <= '0';
		Fset <= '0';
		Psrc <= p;
		M2R <= '0';
		RW <= '0';
		MW <= '0';
		MR <= '0';
	end if;
end process;
end Behavioral;

