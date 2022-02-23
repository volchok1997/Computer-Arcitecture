/*
	This is the instruction buffer, it reads all the instructions fro the input file.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use std.textio.all;
use work.log_values_pkg.all ;

entity instruction_buffer is port(
	clk,rst: in std_logic;
	inst : out std_logic_vector(24 downto 0));
end instruction_buffer;

architecture get_that_code of instruction_buffer is
signal pc : integer:=0;
type memory is array(31 downto 0) of std_logic_vector(24 downto 0);
signal instruction_mem : memory;
begin	
	rd: process
		variable line_v : line;
		variable i : integer:=0;
	    file read_file : text; 
		variable slv_v : std_logic_vector(24 downto 0);
	begin
		file_open(read_file, "C:\\My_Designs\\345_final_project\\machine.txt", read_mode);
		while not endfile(read_file) loop
	      readline(read_file, line_v);
	      read(line_v, slv_v); 
		  instruction_mem(i)<=slv_v;
		  i:=i+1;
		  --wait for 1ns;
	    end loop;
    	file_close(read_file);
	wait;
	end process;
	fetch:process(clk,rst)
	begin
		
		inst<=instruction_mem(pc);
		if rising_edge(clk) then
			pc<=pc+1;
			if(rst='1') then
				pc<=0;
			end if;
			if(pc=31) then
				pc<=0;
			end if;
		end if;
		
	end process; 
	pc_rd:process(clk)
	begin
		pc_log <=pc;
		end process;
end;

