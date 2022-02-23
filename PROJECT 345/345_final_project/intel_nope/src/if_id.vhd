/*
This is the pipeline register between the IF stage and the ID stage.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.log_values_pkg.all ;

entity if_id is port(
	--IregSrc, Irtype, Iregwrite, Irdimm  :out std_logic;
	--Ialuop : out std_logic_vector(3 downto 0); 
	--Irs3,Irs2,Irs1,Ird:out std_logic_vector(127 downto 0);
	Iinst : out std_logic_vector(24 downto 0);
	--regSrc, rtype, regwrite, rdimm :in std_logic;
	--aluop : in std_logic_vector(3 downto 0);
	--rs3,rs2,rs1,rd :in std_logic_vector(127 downto 0);
	--result :out std_logic_vector(127 downto 0);
	inst : in std_logic_vector(24 downto 0);
	clk,rst : in std_logic);		
end if_id;

architecture plr of if_id is
begin
	pl:process(clk)
	begin
		if rising_edge(clk) then
			Iinst <= inst;
			if rst = '1' then
				Iinst <= std_logic_vector(to_unsigned(0,25)); 
			end if;
			
		--IregSrc <= regSrc;
		--Irtype <= rtype;
		--Iregwrite <= regwrite;
		--Irdimm <= rdimm;
		--Ialuop <= aluop;
		--Irs3 <= rs3;
		--Irs2 <= rs2;
		--Irs1 <= rs1;
		--Ird	<= rd;
		end if;
	end process;
	
	
end;

		
		