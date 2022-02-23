/*
block connecting the IF and EX stages.
*/
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.log_values_pkg.all ;
entity id_ex_datapath is port(
	clk, rst : in std_logic;
	Inst : in std_logic_vector(24 downto 0));
end id_ex_datapath;

architecture datapath of id_ex_datapath is 
signal IDinst,Einst : std_logic_vector(24 downto 0); 
signal IRSrc, IRT, IRW, IRID,ERSrc,ERT,ERW,ERID : std_logic;
signal IALUOP,EALUOP : std_logic_vector(3 downto 0);
signal rr3,rr2,rr1,rrd,FF3,FF2,FF1,FFD,Er3, Er2, Er1, Erd, result : std_logic_vector(127 downto 0);

begin 
	if_id: entity if_id port map(
		inst=>Inst,
		Iinst=>IDinst,
		rst=>rst,
		clk=>clk);
		
	control_unit: entity control_unit port map(
		inst=>IDinst,
		regSrc=> IRSrc,
		rtype=>	IRT,
		regwrite=> IRW,
		rdimm=>	IRID,
		aluop=>	IALUOP);
		
	register_file: entity register_file port map(
		r3 =>IDinst(19 downto 15),
		r2 =>IDinst(14 downto 10),
		r1 =>IDinst(9 downto 5),
		rdn =>IDinst(4 downto 0),
		rw => Einst(4 downto 0), 
		WriteData => result,
		rst=> rst, 	  
		clk	=>clk,
		rs3	=>rr3,
		rs2=> rr2,
		rs1=> rr1,
		rd=>  rrd,
		regwrite=> ERW);
		
	forward_unit: entity forward_unit port map(
		rs3=>rr3,
		rs2=>rr2,
		rs1=>rr1,
		rd=>rrd,
		E_regwrite =>ERW,
		f3=>FF3,
		f2=>FF2,
		f1=>FF1,
		fd=>FFD,
		result=>result,
		IDinst=>IDinst,
		EXinst=>Einst);
	
	id_ex: entity id_ex port map(
		IregSrc=>IRSrc,
		Irtype=>IRT,
		Iregwrite=>IRW,
		Irdimm=>IRID,
		Ialuop=>IALUOP,
		Irs3=>FF3,
		Irs2=>FF2,
		Irs1=>FF1,
		Ird=>FFD,
		Iinst=>IDinst,
		clk=>clk,
		EregSrc=>ERSrc,
		Ertype=>ERT,
		Eregwrite=>ERW,
		Erdimm=>ERID,
		Ealuop=>EALUOP,
		Ers3=>Er3,
		Ers2=>Er2,
		Ers1=>Er1,
		Erd=> Erd,
		rst=>rst,
		Einst=>Einst);
	EX: entity EX port map(
		regSrc =>ERSrc,
		rtype =>ERT,
		regwrite =>ERW,
		rdimm => ERID,
		aluop => EALUOP, 
		rs3 =>Er3,
		rs2 =>Er2,
		rs1 =>Er1,
		rd =>Erd, 
		result =>result, 
		inst =>Einst);
	rec_pl:process(clk)
	begin
		if rising_edge(clk) then
			if_inst<=Inst;
			id_inst<=IDinst;
			ex_inst<=Einst;
		end if;
	end process;
	
		
end;

