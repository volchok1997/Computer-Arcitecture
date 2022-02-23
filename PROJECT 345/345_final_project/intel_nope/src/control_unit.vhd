/*
contrl unit.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is port(
	inst :in std_logic_vector(24 downto 0);
	regSrc, rtype, regwrite, rdimm :out std_logic;
	aluop : out std_logic_vector(3 downto 0));
end control_unit;

architecture ctr of control_unit is 
begin
	p1: process(inst)
	begin
		regSrc <= not(inst(24));
		if inst(24 downto 23) = "11" then
			rtype<='1';	
			aluop<= inst(18 downto 15);
		else
			rtype<='0';
			aluop<= "00" & inst(21 downto 20);
		end if;
		if 	(inst(24 downto 23) = "11") and (inst(18 downto 15)= "0111") then
			rdimm<='1';
		else
			rdimm<='0';
		end if;
		if 	(inst(24 downto 23) = "11") and (inst(18 downto 15)= "0000") then
			regwrite<='0';
		else
			regwrite<='1';
		end if;
	end process;
	end;
	
		