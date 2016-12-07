--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:36:46 03/16/2016
-- Design Name:   
-- Module Name:   C:/Users/HP/Desktop/Assignment 3/Compute_Architecture3/Datatest.vhd
-- Project Name:  Compute_Architecture3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DataPath
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Datatest IS
END Datatest;
 
ARCHITECTURE behavior OF Datatest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataPath
    PORT(
         Instruct : OUT  std_logic_vector(31 downto 0);
         clka : IN  std_logic;
         alu_flags : OUT  std_logic_vector(3 downto 0);
         alu_mul : IN  std_logic;
         alu_operation : IN  std_logic_vector(3 downto 0);
         alu_carry : IN  std_logic;
         alu_enable : IN  std_logic;
         data_wen : IN  std_logic;
         data_en : IN  std_logic;
         data_ren : IN  std_logic;
         Ins_en : IN  std_logic;
         RW_en : IN  std_logic;
         PC_en : IN  std_logic;
         Rot_en : IN  std_logic;
         Shift_en : IN  std_logic;
         Reg_file_en : IN  std_logic;
         Reg_file_wen : IN  std_logic;
         Rsrc : IN  std_logic;
         Asrc : IN  std_logic;
         M2R : IN  std_logic;
         Psrc : IN  std_logic;
         Imm : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clka : std_logic := '0';
   signal alu_mul : std_logic := '0';
   signal alu_operation : std_logic_vector(3 downto 0) := "1101";
   signal alu_carry : std_logic := '0';
   signal alu_enable : std_logic := '1';
   signal data_wen : std_logic := '1';
   signal data_en : std_logic := '1';
   signal data_ren : std_logic := '1';
   signal Ins_en : std_logic := '1';
   signal RW_en : std_logic := '1';
   signal PC_en : std_logic := '1';
   signal Rot_en : std_logic := '0';
   signal Shift_en : std_logic := '0';
   signal Reg_file_en : std_logic := '1';
   signal Reg_file_wen : std_logic := '1';
   signal Rsrc : std_logic := '0';
   signal Asrc : std_logic := '1';
   signal M2R : std_logic := '0';
   signal Psrc : std_logic := '0';
   signal Imm : std_logic := '0';

 	--Outputs
   signal Instruct : std_logic_vector(31 downto 0);
   signal alu_flags : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clka_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataPath PORT MAP (
          Instruct => Instruct,
          clka => clka,
          alu_flags => alu_flags,
          alu_mul => alu_mul,
          alu_operation => alu_operation,
          alu_carry => alu_carry,
          alu_enable => alu_enable,
          data_wen => data_wen,
          data_en => data_en,
          data_ren => data_ren,
          Ins_en => Ins_en,
          RW_en => RW_en,
          PC_en => PC_en,
          Rot_en => Rot_en,
          Shift_en => Shift_en,
          Reg_file_en => Reg_file_en,
          Reg_file_wen => Reg_file_wen,
          Rsrc => Rsrc,
          Asrc => Asrc,
          M2R => M2R,
          Psrc => Psrc,
          Imm => Imm
        );

   -- Clock process definitions
   clka_process :process
   begin
		clka <= '0';
		wait for clka_period/2;
		clka <= '1';
		wait for clka_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clka_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
