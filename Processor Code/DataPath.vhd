----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:38 03/15/2016 
-- Design Name: 
-- Module Name:    DataPath - Behavioral 
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

entity DataPath is
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

end DataPath;

architecture Behavioral of DataPath is

component ALU is
port ( a : in STD_LOGIC_VECTOR ( 31 downto 0 );
		b : in STD_LOGIC_VECTOR ( 31 downto 0 );
		result : out STD_LOGIC_VECTOR ( 31 downto 0 );
		flags : out STD_LOGIC_VECTOR ( 3 downto 0 );
		m_flag : in STD_LOGIC;
		operation : in STD_LOGIC_VECTOR ( 3 downto 0 );
		carry : in STD_LOGIC;
		enable : in STD_LOGIC
		);
end component;

component MUX is
port( input1 : in STD_LOGIC_VECTOR(31 downto 0);
input2 : in STD_LOGIC_VECTOR(31 downto 0);
output : out STD_LOGIC_VECTOR(31 downto 0);
sig : in STD_LOGIC);
end component;
 
component MUX_4 is
port( input1 : in STD_LOGIC_VECTOR(3 downto 0);
input2 : in STD_LOGIC_VECTOR(3 downto 0);
output : out STD_LOGIC_VECTOR(3 downto 0);
sig : in STD_LOGIC); 
end component;

component Reg is
port( clk:in std_logic;
		read_write_enable:in STD_LOGIC;
		input:in STD_LOGIC_VECTOR(31 downto 0);
		output:out STD_LOGIC_VECTOR(31 downto 0)
		);
end component;		

component MUX_clk is
port( clk : in STD_LOGIC;
input1 : in STD_LOGIC_VECTOR(31 downto 0);
input2 : in STD_LOGIC_VECTOR(31 downto 0);
output : out STD_LOGIC_VECTOR(31 downto 0);
sig : in STD_LOGIC);
end component;


component Data_memory is
port( clk:in std_logic;
address: in std_logic_vector(31 downto 0);
writen: in std_logic;
readen: in std_logic;
enable: in std_logic;
datai: in std_logic_vector(31 downto 0);
datao : out std_logic_vector(31 downto 0)
);
end component;

component Ins_memory is
port( clk:in std_logic;
address: in std_logic_vector(31 downto 0);
enable: in std_logic;
datao : out std_logic_vector(31 downto 0)
);
end component;   

component PC is
port(
		enable: in std_logic;
		data:in std_logic_vector(31 downto 0);
		out1:out std_logic_vector(31 downto 0);
		out2:out std_logic_vector(31 downto 0);
		clk:in std_logic;
		offset:in std_logic_vector(23 downto 0)
		);
end component;

component Rotater is
port( input: in std_logic_vector(7 downto 0);
output: out std_logic_vector(31 downto 0);
enable :in std_logic;
rot_amount : in std_logic_vector(3 downto 0)
);
end component;

component Shifter is
port( input:in STD_LOGIC_VECTOR(31 downto 0);
		shift_type:in STD_LOGIC_VECTOR(1 downto 0);
		shift_amount:in STD_LOGIC_VECTOR(4 downto 0);
		output:out STD_LOGIC_VECTOR (31 downto 0);
		enable:in STD_LOGIC
		);
end component;
 
component register_file is
Port( clk:in std_logic;
		enable:in STD_LOGIC;
		wenable:in STD_LOGIC;
		reada1:in STD_LOGIC_VECTOR(3 downto 0);
		reada2:in STD_LOGIC_VECTOR(3 downto 0);
		writea:in STD_LOGIC_VECTOR(3 downto 0);
		data:in STD_LOGIC_VECTOR(31 downto 0);
		out1:out STD_LOGIC_VECTOR(31 downto 0);
		out2:out STD_LOGIC_VECTOR(31 downto 0)
		);
end component;

signal reg_1:std_logic_vector(31 downto 0):= (others => '0'); -- value of register 1 out
signal reg_2:std_logic_vector(31 downto 0):= (others => '0'); -- value of register 2 out
signal Instruction:std_logic_vector(31 downto 0):= (others => '0'); -- Instruction from Instruction memory
signal MUX1_OUT:std_logic_vector(3 downto 0):= (others => '0'); -- output of MUX 1
signal MUX2_OUT:std_logic_vector(31 downto 0):= (others => '0'); -- output of MUX 2
signal MUX3_OUT:std_logic_vector(31 downto 0):= (others => '0'); -- output of MUX 3
signal MUX4_OUT:std_logic_vector(31 downto 0):= (others => '0'); -- output of MUX 4
signal PC_out1:std_logic_vector(31 downto 0):= (others => '0'); -- output of PC1
signal PC_out2:std_logic_vector(31 downto 0):= (others => '0'); -- output of PC2
signal alu_res:std_logic_vector(31 downto 0):= (others => '0'); -- output from ALU
signal data_out:std_logic_vector(31 downto 0):= (others => '0'); -- output from data memory
signal PC_val:std_logic_vector(31 downto 0):= (others => '0'); -- output from PC register
signal PC_update:std_logic_vector(31 downto 0):= (others => '0'); -- input to PC register
signal branch_offset:std_logic_vector(23 downto 0):= (others => '0'); -- offset amount for branch instruction
signal read_address1:std_logic_vector(3 downto 0):= (others => '0'); -- register file address read 1
signal read_address2_1:std_logic_vector(3 downto 0):= (others => '0'); -- register file address read 2.1
signal read_address2_2:std_logic_vector(3 downto 0):= (others => '0'); -- register file address read 2.2
signal write_address:std_logic_vector(3 downto 0):= (others => '0'); -- register file address write
signal const:std_logic_vector(31 downto 0):= (others => '0'); -- ALU input 2 (constant)
signal Rot_out:std_logic_vector(31 downto 0):= (others => '0'); -- output from Rotate
signal Shift_out:std_logic_vector(31 downto 0):= (others => '0'); -- output from Shift
signal Rot_in:std_logic_vector(7 downto 0):= (others => '0'); -- input to rotator 
signal Shift_type:std_logic_vector(1 downto 0):= (others => '0'); -- Type of Shift
signal Shift_amt:std_logic_vector(4 downto 0):= (others => '0'); -- Shift amount
signal Rot_amt:std_logic_vector(3 downto 0):= (others => '0'); -- Rotate amount

begin
branch_offset <= Instruction(23 downto 0);
read_address1 <= Instruction(19 downto 16);
read_address2_1 <= Instruction(3 downto 0);
read_address2_2 <= Instruction(15 downto 12);
write_address <= Instruction(15 downto 12);
Shift_type <= Instruction(6 downto 5);
Shift_amt <= Instruction(11 downto 7);
Rot_amt <= Instruction(11 downto 8);
Rot_in <= Instruction(7 downto 0);
const(31 downto 12) <= (others => '0');
const(11 downto 0) <= Instruction(11 downto 0);
Instruct <= Instruction;

ALUnit : ALU port map
(	a => reg_1, 
	b => MUX4_OUT, 
	result => alu_res,
	flags => alu_flags,
	m_flag => alu_mul,
	operation => alu_operation,
	carry => alu_carry,
	enable => alu_enable
);

Data_Mem : Data_memory port map
(clk => clka,
address => alu_res,
writen => data_wen,
readen => data_ren,
enable => data_en,
datai => reg_2,
datao => data_out
);

Rot : Rotater port map
( input => Rot_in,
output => Rot_out,
enable => Rot_en,
rot_amount => Rot_amt
);

Shift : Shifter port map
( 	input => MUX2_OUT,
	shift_type => Shift_type,
	shift_amount => Shift_amt,
	output => Shift_out,
	enable => Shift_en
	);


Instruction_Mem : Ins_memory port map
( clk => clka,
address => PC_update,
enable => Ins_en,
datao => Instruction
);

ProgramCounter : PC port map
(		enable => PC_en,
		data => PC_update,
		out1 => PC_out1, 
		out2 => PC_out2,
		clk => clka,
		offset => branch_offset
		);

Reg_file : register_file port map
( 		clk => clka,
		enable => Reg_file_en,
		wenable => Reg_file_wen,
		reada1 => read_address1,
		reada2 => MUX1_OUT,
		writea => write_address,
		data => MUX3_OUT,
		out1 => reg_1,
		out2 => reg_2
		);

--PC_reg : Reg port map
--	( clk => clka,
--		read_write_enable => RW_en,
--		input => PC_update,
--		output => PC_val
--		);

mux1 : MUX_4 port map
( input1 => read_address2_1,
input2 => read_address2_2,
output => MUX1_OUT,
sig => Rsrc
);

mux2 : MUX port map
( input1 => reg_2,
input2 => const,
output => MUX2_OUT,
sig => Asrc
);

mux3 : MUX port map
( input1 => alu_res,
input2 => data_out,
output => MUX3_OUT,
sig => M2R
);

mux4 : MUX port map
( input1 => Shift_out,
input2 => Rot_out,
output => MUX4_OUT,
sig => Imm
);

mux5 : MUX_clk port map
( clk => clka,
input1 => PC_out1,
input2 => PC_out2,
output => PC_update,
sig => Psrc
);

end Behavioral;
