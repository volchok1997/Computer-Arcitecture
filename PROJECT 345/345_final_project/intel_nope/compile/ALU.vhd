-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : intel_nope
-- Author      : ayman
-- Company     : stonybrook
--
-------------------------------------------------------------------------------
--
-- File        : E:\POJECT 345\345_final_project\intel_nope\compile\ALU.vhd
-- Generated   : Sun Apr 21 17:04:28 2019
-- From        : E:\POJECT 345\345_final_project\intel_nope\src\ALU.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity ALU is
  port(
       Rtype : in STD_LOGIC;
       ALUop : in STD_LOGIC_VECTOR(3 downto 0);
       rd : in STD_LOGIC_VECTOR(127 downto 0);
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       ALUout : out STD_LOGIC_VECTOR(127 downto 0)
  );
end ALU;

architecture Rfunctions of ALU is

---- Component declarations -----

component r3_alu
  port (
       r3op : in STD_LOGIC_VECTOR(3 downto 0);
       rd : in STD_LOGIC_VECTOR(127 downto 0);
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       r3_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;
component r4_alu
  port (
       r4op : in STD_LOGIC_VECTOR(1 downto 0);
       rs1 : in STD_LOGIC_VECTOR(127 downto 0);
       rs2 : in STD_LOGIC_VECTOR(127 downto 0);
       rs3 : in STD_LOGIC_VECTOR(127 downto 0);
       r4_result : out STD_LOGIC_VECTOR(127 downto 0)
  );
end component;

---- Signal declarations used on the diagram ----

signal r3_out : STD_LOGIC_VECTOR(127 downto 0);
signal r4_out : STD_LOGIC_VECTOR(127 downto 0);

begin

---- Processes ----

rtype_mux : process (rs1,rs2,rs3,rd,ALUop,Rtype,r3_out,r4_out)
                       begin
                         if Rtype = '0' then
                            ALUout <= r4_out;
                         else 
                            ALUout <= r3_out;
                         end if;
                       end process;
                      

----  Component instantiations  ----

R3ALU : r3_alu
  port map(
       r3_result => r3_out,
       r3op => ALUop,
       rd => rd,
       rs1 => rs1,
       rs2 => rs2
  );

R4ALU : r4_alu
  port map(
       r4op(0) => ALUop(0),
       r4op(1) => ALUop(1),
       r4_result => r4_out,
       rs1 => rs1,
       rs2 => rs2,
       rs3 => rs3
  );


end Rfunctions;
