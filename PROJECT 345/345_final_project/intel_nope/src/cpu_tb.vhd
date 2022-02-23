/*
This is an testbench for the entire processor, it only takes a clock and a reset and will function only with
	the instructions.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;	
use ieee.std_logic_textio.all;
use work.log_values_pkg.all ;

entity cpu_tb is  
end cpu_tb;
 
architecture test_instructions of cpu_tb is
signal clk: std_logic:='0';
signal rst: std_logic; 
signal tst: std_logic_vector(3 downto 0):="1111"; 
file file_RESULTS : text;
begin
	openfile:process
	begin
		file_open(file_RESULTS, "C:\\My_Designs\\345_final_project\\log.txt", write_mode);
		wait;
	end process;
	
	uut: entity cpu port map(
		clk=>clk,
		rst=>rst);
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
		wait for 20ns;
		rst<='0';
		wait;
	end process;
	wrt:process(clk)
	variable v_ILINE     : line;
    variable v_OLINE     : line;
    variable v_SPACE     : character;
	begin
		--file_open(file_RESULTS, "C:\\My_Designs\\345_final_project\\log.txt", write_mode);  
		
		if rising_edge(clk) then
		write(v_OLINE,"PC: "&integer'image(pc_log)& "   Instructions in stages:   IF:" &to_string(if_inst)
			& "    ID: "& to_string(id_inst) & "    EX: " & to_string(ex_inst), right,1);
		writeline(file_RESULTS, v_OLINE); 
		for i in 31 downto 0 loop
			write(v_OLINE,"register " &integer'image(i) &" :0x"& to_hstring(reg_log(i)), right,1);	
		writeline(file_RESULTS, v_OLINE);
		end loop;
		end if;
	end process;
	
		
end;