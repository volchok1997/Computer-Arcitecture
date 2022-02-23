/*
forwarding unit.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forward_unit is port(
	IDinst,EXinst :in std_logic_vector(24 downto 0);
	E_regwrite :in std_logic;
	result : in std_logic_vector(127 downto 0);
	rs1,rs2,rs3,rd : in std_logic_vector(127 downto 0);
	f1,f2,f3,fd : out std_logic_vector(127 downto 0));
end forward_unit;

architecture forward of forward_unit is
begin
	choose:process(IDinst,EXinst,E_regwrite,rs1,rs2,rs3,rd,f1,f2,f3,fd,result )
	variable shlhi : integer:=0;
	begin
		if (E_regwrite = '1') and (IDinst(19 downto 15) = EXinst(4 downto 0))then --IDrs3==EXrd
			f3<=result;
		else
			f3<=rs3;
		end if;
		if (E_regwrite = '1') and (IDinst(14 downto 10) = EXinst(4 downto 0))then --IDrs2==EXrd
			f2<=result;
		else
			f2<=rs2;
		end if;
		if ((E_regwrite = '1') and (IDinst(9 downto 5) = EXinst(4 downto 0)))then --IDrs1==EXrd
			f1<=result;
		else
			f1<=rs1;
		end if;
		if (E_regwrite = '1') and (IDinst(4 downto 0) = EXinst(4 downto 0))then --IDrs2==EXrd
			fd<=result;
		else
			fd<=rd;
		end if;
		end process;
		end;
		