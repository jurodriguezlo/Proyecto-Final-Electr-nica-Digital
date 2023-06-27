library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Multiplexor is

	port
	(
		
		-- Input ports
		mul1: in  std_logic_vector (3 downto 0);
		mul2: in  std_logic_vector (3 downto 0);
		sel: in	std_logic;

		-- Output ports
		spl: out std_logic_vector (3 downto 0));
	
end Multiplexor;

architecture seleccion of Multiplexor is

begin

	with sel select
		spl <= mul1 when '1',
				 mul2 when others;

end seleccion;
