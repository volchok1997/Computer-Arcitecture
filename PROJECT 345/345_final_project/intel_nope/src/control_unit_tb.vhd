/*
Testbench for control unit.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;			   

entity control_unit_tb is
end control_unit_tb;

architecture clt_tb of control_unit_tb is
signal inst : std_logic_vector(24 downto 0);
signal regSrc, rtype, regwrite, rdimm : std_logic;
signal aluop :  std_logic_vector(3 downto 0);
begin
	uut:entity control_unit port map(
		inst=> inst,
		regSrc=> regSrc,
		rtype=> rtype,
		regwrite=> regwrite,		
		rdimm =>rdimm,
		aluop =>aluop);
		
	tb: process
	begin
		inst <= "0001000000000010000000011";
		wait for 20ns;
		inst <= "1000000011111100000100101";
		wait for 20ns;
		inst <= "1100000011001010010000110";	 
		wait for 20ns;
		inst <= "1100000111001010010000110";
		wait for 20ns;
		inst <= "1100000000001010010000110";
		wait;
	end process;
	end;
	