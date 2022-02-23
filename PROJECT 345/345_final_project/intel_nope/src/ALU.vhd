/* 
The ALU is a combination of the r3 and 4 instruction types, the output is
determined based on the instruction in the execution stage P>L register.
*/ 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	

entity ALU is port(
	rs1,rs2,rs3,rd: in std_logic_vector(127 downto 0);
	ALUop: in std_logic_vector(3 downto 0);
	Rtype : in std_logic;
	ALUout: out std_logic_vector(127 downto 0));
end ALU;

architecture Rfunctions of ALU is  
signal r4_out: std_logic_vector(127 downto 0);
signal r3_out: std_logic_vector(127 downto 0);
begin										  
	R3ALU: entity r3_alu port map (
			rs1 => rs1,
			rs2 => rs2,
			rd => rd,
			r3op => ALUop,
			r3_result => r3_out);
	R4ALU: entity r4_alu port map (
			rs1 => rs1,
			rs2 => rs2,
			rs3 => rs3,
			r4op => ALUop(1 downto 0),
			r4_result => r4_out);		   
	
	rtype_mux: process(rs1,rs2,rs3,rd,ALUop,Rtype,r3_out,r4_out)
	begin
		if Rtype = '0' then
			ALUout <= r4_out;
		else
			ALUout <= r3_out;		
		end if;
	end process;
	end;
	
		
		