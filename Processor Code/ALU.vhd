----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:17:36 03/15/2016 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
port ( a : in STD_LOGIC_VECTOR ( 31 downto 0 );
		b : in STD_LOGIC_VECTOR ( 31 downto 0 );
		result : out STD_LOGIC_VECTOR ( 31 downto 0 );
		flags : out STD_LOGIC_VECTOR ( 3 downto 0 );
		m_flag : in STD_LOGIC;
		operation : in STD_LOGIC_VECTOR ( 3 downto 0 );
		carry : in STD_LOGIC;
		enable : in STD_LOGIC
		);
end ALU;

architecture Behavioral of ALU is


begin

process(a,b, m_flag, operation, carry, enable) 

variable op1 : std_logic_vector ( 32 downto 0 ) := (others => '0');
variable op2 : std_logic_vector ( 32 downto 0 ) := (others => '0');
variable res : std_logic_vector ( 32 downto 0 ) := (others => '0');
variable temp1: std_logic_vector(31 downto 0):= (others => '0');
variable temp2: std_logic_vector(31 downto 0):= (others => '0');
variable temp : std_logic_vector(31 downto 0):= (others => '0');
variable mula : signed(31 downto 0);
variable mulb : signed(31 downto 0);
variable mulp : signed(63 downto 0);
variable Cn_1 : std_logic;
variable Cn : std_logic;


	begin
		
		op1(31 downto 0 ) := a(31 downto 0);
		op2 (31 downto 0 ) := b(31 downto 0);
		op1(32) := '0';
		op2(32) := '0';
		res := (others => '0');
		mula := signed(a);
		mulb := signed(b);
		temp1(30 downto 0) := a(30 downto 0);
		temp2(30 downto 0) := b(30 downto 0);
		temp1(31) := '0';
		temp2(31) := '0';
		Cn := '0';
		Cn_1 := '0';
	
		if(enable = '1') then
			if(m_flag = '1') then
				mulp:=mula*mulb;
				GEN: for i in 0 to 32 loop
				res(i) := mulp(i);
				end loop;
			else
				case(operation) is 
					when ( "0000" ) => res(31 downto 0 ) := a and b;
												temp := a and b;
					when ( "0001" ) => res(31 downto 0 ) := a xor b;
												temp := a xor b;
					when ( "0010" ) => res := op1 + not(op2) + 1;
												temp := temp1 + not(temp2) + 1;
					when ( "0011" ) => res := not(op1) + op2 + 1;
												temp := not(temp1) + temp2 + 1;
					when ( "0100" ) => res := op1 + op2;
												temp := temp1 + temp2;
					when ( "0101" ) => res := op1 + op2 + carry;
												temp := temp1 + temp2 + carry;
					when ( "0110" ) => res := op1 + not(op2) + carry;
												temp := temp1 + not(temp2) + carry;
					when ( "0111" ) => res := not(op1) + op2 + carry;
												temp := not(temp1) + temp2 + carry;
					when ( "1000" ) => res(31 downto 0 ) := a and b;
												temp := a and b;
					when ( "1001" ) => res(31 downto 0 ) := a xor b;
												temp := a xor b;
					when ( "1010" ) => res := op1 + not(op2) + 1;
												temp := temp1 + not(temp2) + 1;
					when ( "1011" ) => res := op1 + op2;
												temp := temp1 + temp2;
					when ( "1100" ) => res(31 downto 0 ) := a or b;
												temp := a or b;
					when ( "1101" ) => res := op2;
												temp := temp2;
					when ( "1110" ) => res(31 downto 0 ) := a and not(b);
												temp := a and not(b);
					when others => res := not(op2);
												temp := not(temp2);
				end case;
				
				Cn := res(32);
			end if;
		end if;
				
				Cn_1 := temp(31);
				flags(2) <= Cn xor Cn_1;
				if(res = "00000000000000000000000000000000" ) then
					flags(0) <= '1'; --Z
				else
					flags(0) <= '0';
				end if;
				
				if(res(32) = '1') then
					flags(3) <= '1'; --C
				else
					flags(3) <= '0';
				end if;
				
				if(res(31) = '1') then
					flags(1) <= '1'; --N
				else
					flags(1) <= '0';
				end if;
				
				result <= res(31 downto 0);
			
		end process;
		
end Behavioral;



