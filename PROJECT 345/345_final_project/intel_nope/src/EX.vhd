/*
This block is a representation of the entire execution stage. It is done as structural design and will function
based on the ID/EX pipeline register.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EX is port( 
	regSrc, rtype, regwrite, rdimm :in std_logic;
	aluop : in std_logic_vector(3 downto 0);
	rs3,rs2,rs1,rd :in std_logic_vector(127 downto 0);
	result :out std_logic_vector(127 downto 0);
	inst : in std_logic_vector(24 downto 0));
end EX;

architecture execution of EX is
signal alu_rdin : std_logic_vector(127 downto 0);
signal li_out, alu_out : std_logic_vector(127 downto 0);

begin
	load_imm: entity load_imm port map (
			imm => inst(20 downto 5),
			li => inst(23 downto 21),
			rd => rd,
			li_result => li_out );
	ALU: entity ALU port map(
		rs1 => rs1,
		rs2	=> rs2,
		rs3	=> rs3,
		rd =>  alu_rdin,
		ALUop => aluop,
		Rtype => rtype,
		ALUout => alu_out);
	chooseALUrd: process(rdimm, rd, inst)
	begin
		if rdimm= '1' then
			alu_rdin <= std_logic_vector(to_unsigned(0,123))& inst(14 downto 10);
			--alu_rdin(3 downto 0) <= inst(14 downto 10);
		else
			alu_rdin <= rd;
		end if;
	end process;
	
	choose_result: process(alu_out, li_out, regsrc)
	begin
		if regsrc = '0' then
			result <= alu_out;
		else
			result <= li_out;
		end if;
		end process;
	
		
	
			
end;


	
	