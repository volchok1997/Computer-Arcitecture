/*
This block represents the Pipeline register between the ID stage and the EX stage.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_ex is port(
	EregSrc, Ertype, Eregwrite, Erdimm:out std_logic;
	Ealuop: out std_logic_vector(3 downto 0);
	Ers3,Ers2,Ers1,Erd:out std_logic_vector(127 downto 0);
	Einst: out std_logic_vector(24 downto 0);
	clk ,rst: in std_logic;
	IregSrc, Irtype, Iregwrite, Irdimm  :in std_logic;
	Ialuop : in std_logic_vector(3 downto 0); 
	Irs3,Irs2,Irs1,Ird:in std_logic_vector(127 downto 0);
	Iinst : in std_logic_vector(24 downto 0));
end	id_ex;

architecture plr of id_ex is
begin 
	pl:process(clk)
	begin 
	if rising_edge(clk) then
		EregSrc <= IregSrc;
		Ertype <= Irtype;
		Eregwrite<= Iregwrite;
		Erdimm <= Irdimm;
		Ealuop <= Ialuop;
		Ers3<=Irs3;Ers2<=Irs2;Ers1<=Irs1;Erd<=Ird;
		Einst <= Iinst;
		if rst='1' then
			EregSrc <= '0';
			Ertype <='0';
			Eregwrite<='0';
			Erdimm <= '0';
			Ealuop <= "0000";
			Ers3<=std_logic_vector(to_unsigned(0,128));
			Ers2<=std_logic_vector(to_unsigned(0,128));
			Ers1<=std_logic_vector(to_unsigned(0,128));
			Erd<=std_logic_vector(to_unsigned(0,128));
			Einst <= std_logic_vector(to_unsigned(0,25));
		end if;
	end if;		   
end process;
end;

	