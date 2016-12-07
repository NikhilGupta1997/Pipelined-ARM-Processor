----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:23:24 03/15/2016 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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

entity Controller is
port( Instruction:in STD_LOGIC_VECTOR(31 downto 0);
		clk:in STD_LOGIC;
		flagout:out STD_LOGIC;
		-- ALU
		alu_flags:in STD_LOGIC_VECTOR(3 downto 0);
		alu_mul:out STD_LOGIC;
		alu_operation:out STD_LOGIC_VECTOR(3 downto 0);
		alu_carry:out STD_LOGIC;
		alu_enable:out STD_LOGIC;

		--Data Memory
		data_wen:out STD_LOGIC;
		data_en:out STD_LOGIC;
		data_ren:out STD_LOGIC;

		--Instruction Memory
		Ins_en:out STD_LOGIC;

		--PC
		RW_en:out STD_LOGIC;
		PC_en:out STD_LOGIC;

		--Rotator/Shifter
		Rot_en:out STD_LOGIC; 
		Shift_en:out STD_LOGIC;  
		
		--Register File
		Reg_file_en:out STD_LOGIC;
		Reg_file_wen:out STD_LOGIC;

		-- MUX
		Rsrc:out STD_LOGIC;
		Asrc:out STD_LOGIC;
		M2R:out STD_LOGIC;
		Psrc:out STD_LOGIC;
		Imm:out STD_LOGIC);
		
end Controller;

architecture Behavioral of Controller is
component Actrl is
port( instruction: in STD_LOGIC_VECTOR ( 5 downto 0);
		operation: out STD_LOGIC_VECTOR ( 3 downto 0)
		);
end component;

component Bctrl is
port( instruction:in STD_LOGIC_VECTOR(3 downto 0);
		flags:in STD_LOGIC_VECTOR(3 downto 0); -- C,V,N,Z
		P:out STD_LOGIC);
end component;

component MainControl is
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
		Fset:out STD_LOGIC);
end component;

signal INSTR1:std_logic_vector(7 downto 0):= (others => '0');
signal INSTR2:std_logic_vector(3 downto 0):= (others => '0');
signal INSTR3:std_logic_vector(5 downto 0):= (others => '0');
signal INSTR4:std_logic_vector(3 downto 0):= (others => '0');
signal B_Out:std_logic;

begin
INSTR1<=Instruction(27 downto 20);
INSTR2<=Instruction(7 downto 4);
INSTR3<=Instruction(26 downto 21);
INSTR4<=Instruction(31 downto 28);
Imm<=Instruction(26);
alu_enable <= '1';
data_en <= '1'; 
PC_en <= '1';
Ins_en <= '1';
RW_en <= '1';
alu_carry <= '1';
Reg_file_en <= '1';

Main_Control : MainControl port map
(instruction => INSTR1,
		check_mul => INSTR2,
		p => B_Out,
		mul_flag =>alu_mul,
		Rot_en => Rot_en,
		Shift_en => Shift_en,
		Rsrc =>Rsrc,
		RW => Reg_file_wen,
		Asrc =>Asrc,
		MW => data_wen,
		MR => data_ren,
		M2R =>M2R,
		Psrc =>Psrc,
		Fset => flagout
		);


A_control : Actrl port map
( instruction => INSTR3,
	operation => alu_operation
		);

B_control : Bctrl port map
( instruction => INSTR4,
	flags => alu_flags,
		P => B_Out
	);

end Behavioral;

