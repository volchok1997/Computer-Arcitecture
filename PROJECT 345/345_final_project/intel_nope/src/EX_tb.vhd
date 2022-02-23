/*
	This is the testBench for the execution stage block, only 2 instructions were tested.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;			   

entity EX_tb is
end EX_tb;

architecture tb_architecture of EX_tb is

signal regSrc, rtype, regwrite, rdimm : std_logic;
signal aluop : std_logic_vector(3 downto 0);
signal rs3,rs2,rs1,rd : std_logic_vector(127 downto 0);
signal result :std_logic_vector(127 downto 0);
signal inst :std_logic_vector(24 downto 0);

begin
	EXstage: entity EX port map( 
	regSrc =>regSrc,
	rtype =>rtype,
	regwrite =>regwrite,
	rdimm => rdimm,
	aluop => aluop, 
	rs3 =>rs3,
	rs2 =>rs2,
	rs1 =>rs1,
	rd =>rd, 
	result =>result, 
	inst =>inst);
	
	p1: process
	begin
		regsrc<= '1';
		aluop<= "1111";
		rtype <='1';
		regwrite <= '1';
		rdimm<='0';
		inst<="0001000000000000111110100";
		rs3 <=std_logic_vector(to_unsigned(8,128));
		rs2 <=std_logic_vector(to_unsigned(8,128));
		rs1 <=std_logic_vector(to_unsigned(8,128));
		rd <=std_logic_vector(to_unsigned(8,128));
		wait for 20ns;
		regsrc<= '0';
		aluop<= "0011";
		rtype <='1';
		regwrite <= '1';
		rdimm<='0';
		inst<="1100000011001010010000110";
		rs3 <=std_logic_vector(to_unsigned(8,128));
		rs2 <=std_logic_vector(to_unsigned(4,128));
		rs1 <=std_logic_vector(to_unsigned(3,128));
		rd <=std_logic_vector(to_unsigned(8,128));
		wait for 20ns;
		regsrc<= '0';
		aluop<= "0100";
		rtype <='0';
		regwrite <= '1';
		rdimm<='0';
		inst<="1000000011111100000100101";
		rs3 <=std_logic_vector(to_unsigned(3,128));
		rs2 <=std_logic_vector(to_unsigned(2,128));
		rs1 <=std_logic_vector(to_unsigned(1,128));
		rd <=std_logic_vector(to_unsigned(8,128));
		wait for 20ns;
		wait;
	end process;
	
end;

