/*
This is the entire processor placed together as a structural design.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu is port(
	clk, rst : in std_logic);
end cpu;

architecture omg_FINALLLLLYYYYY of cpu is
signal instructions : std_logic_vector(24 downto 0);
begin
	inst_buff: entity instruction_buffer port map(
		clk=>clk,
		rst=>rst,
		inst=>instructions); 
	datapath:entity id_ex_datapath port map(
		clk=>clk,
		rst=>rst,
		Inst=>instructions);
	
end;
	
		
		
		