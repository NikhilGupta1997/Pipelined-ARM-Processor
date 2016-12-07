----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:24:36 03/16/2016 
-- Design Name: 
-- Module Name:    Processor - Behavioral 
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

entity Processor is
port(clock:in STD_LOGIC);
end Processor;

architecture Behavioral of Processor is

component FLAGS is
port( flagin:in STD_LOGIC_VECTOR(3 downto 0);
		flagout:out STD_LOGIC_VECTOR(3 downto 0);
		Fset:in STD_LOGIC);
end component;

component DataPath is
port(
Instruct:out STD_LOGIC_VECTOR(31 downto 0);
clka:in STD_LOGIC;
-- ALU
alu_flags:out STD_LOGIC_VECTOR(3 downto 0);
alu_mul:in STD_LOGIC;
alu_operation:in STD_LOGIC_VECTOR(3 downto 0);
alu_carry:in STD_LOGIC;
alu_enable:in STD_LOGIC;

--Data Memory
data_wen:in STD_LOGIC;
data_en:in STD_LOGIC;
data_ren:in STD_LOGIC;

--Instruction Memory
Ins_en:in STD_LOGIC;

--PC
RW_en:in STD_LOGIC;
PC_en:in STD_LOGIC;

--Rotator
Rot_en:in STD_LOGIC;

--Shifter
Shift_en:in STD_LOGIC;

--Register File
Reg_file_en:in STD_LOGIC;
Reg_file_wen:in STD_LOGIC;

-- MUX
Rsrc:in STD_LOGIC;
Asrc:in STD_LOGIC;
M2R:in STD_LOGIC;
Psrc:in STD_LOGIC;
Imm:in STD_LOGIC);

end component;

component Controller is
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
		
end component;

signal alu_flags:STD_LOGIC_VECTOR(3 downto 0);
signal flgs:STD_LOGIC_VECTOR(3 downto 0);
signal flagset:STD_LOGIC;
signal mulflag:STD_LOGIC;
signal carry:STD_LOGIC;
signal alu_enable:STD_LOGIC;
signal datawen:STD_LOGIC;
signal dataen:STD_LOGIC;
signal dataren:STD_LOGIC;
signal INSen:STD_LOGIC;
signal RW_en:STD_LOGIC;
signal PC_en:STD_LOGIC;
signal Rsrc:STD_LOGIC;
signal Asrc:STD_LOGIC;
signal Psrc:STD_LOGIC;
signal M2R:STD_LOGIC;
signal Imm:STD_LOGIC;
signal Reg_file_en:STD_LOGIC;
signal Reg_file_wen:STD_LOGIC;
signal Rot_en:STD_LOGIC;
signal Shift_en:STD_LOGIC;
signal Instruct:STD_LOGIC_VECTOR(31 downto 0);
signal operation:STD_LOGIC_VECTOR(3 downto 0);

begin

INS_CONTROLLER : Controller port map
( 		Instruction => Instruct,
		clk => clock, 
		flagout => flagset,
		-- ALU
		alu_flags => flgs,
		alu_mul => mulflag,
		alu_operation => operation,
		alu_carry => carry, 
		alu_enable => alu_enable,

		--Data Memory
		data_wen => datawen,
		data_en => dataen,
		data_ren => dataren,

		--Instruction Memory
		Ins_en => INSen,

		--PC
		RW_en => RW_en,
		PC_en => PC_en,

		--Rotator
		Rot_en => Rot_en,

		--Shifter
		Shift_en => Shift_en,

		
		--Register File
		Reg_file_en => Reg_file_en,
		Reg_file_wen => Reg_file_wen,

		-- MUX
		Rsrc => Rsrc,
		Asrc => Asrc,
		M2R => M2R,
		Psrc => Psrc,
		Imm => Imm
	); 
		
FlagRegs : FLAGS port map
( flagin => alu_flags, 
		flagout => flgs,  
		Fset => flagset
	);


INS_DATAPATH : DataPath port map
(
Instruct => Instruct,
clka => clock,
-- ALU
alu_flags => alu_flags, 
alu_mul => mulflag,
alu_operation => operation,
alu_carry => carry,
alu_enable => alu_enable,

--Data Memory
data_wen => datawen,
data_en => dataen,
data_ren => dataren,

--Instruction Memory
Ins_en => INSen,

--PC
RW_en => RW_en,
PC_en => PC_en,

--Rotator
Rot_en => Rot_en,

--Shifter
Shift_en => Shift_en,

--Register File
Reg_file_en => Reg_file_en,
Reg_file_wen => Reg_file_wen,

-- MUX
Rsrc => Rsrc,
Asrc => Asrc,
M2R => M2R,
Psrc => Psrc,
Imm => Imm
);

end Behavioral;

