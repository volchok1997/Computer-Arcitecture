/*
Testbench for the ID_EX stages. 
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_ex_datapath_tb is  
end id_ex_datapath_tb;

architecture test_instructions of id_ex_datapath_tb is
signal clk: std_logic:='0';
signal rst: std_logic;
signal Inst : std_logic_vector(24 downto 0);
begin
	uut: entity id_ex_datapath port map(
		clk=>clk,
		rst=>rst,
		Inst=>Inst);
	clock: process 
	begin
		wait for 10ns;
		if clk = '0' then
			clk<='1';
		else
			clk<='0';
		end if;
	end process;
	
	test:process 
	begin
		rst<='1';
		Inst <="1100000000000000000000000";--no
		wait for 20ns;
		rst<='0';
		wait for 10ns;
		Inst <="1100000000000000000000000";--nop
		wait for 20ns;
		Inst <="1100000000000000000000000";--nop
		wait for 20ns;
		Inst <="1100000000000000000000000";--nop
		wait for 20ns;
		Inst <="1100000000000000000000000";--nop
		wait for 20ns;
		Inst <="1100000000000000000000000";--nop
		wait for 20ns;
		Inst <="1100000000000000000000000";--nop
		wait for 20ns;
		Inst <="0001000000000000011000110";--"li 6 1 6"
		wait for 20ns;
		Inst <="0000000000000000111000101";--li 5 0 14
		wait for 20ns;
		Inst <="0010000000000000111100110";--"li 6 2 15"
		wait for 20ns;
		Inst <="1100000011001010011000111";--or 5 6 7
		wait;
	end process;
		
end;
	

