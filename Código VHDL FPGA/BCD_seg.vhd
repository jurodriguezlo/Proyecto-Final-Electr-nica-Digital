library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BCD_seg is

	port
	(
		
		-- Input ports
		bcd: in  std_logic_vector (3 downto 0);
		

		-- Output ports
		siete: out std_logic_vector (6 downto 0));
	
end BCD_seg;

architecture seleccion of BCD_seg is

begin

	process (bcd)
	begin
	
	if bcd = "0000" then siete <= "0000001";
   elsif bcd = "0001" then siete <= "1001111";
	elsif bcd = "0010" then siete <= "0010010";
	elsif bcd = "0011" then siete <= "0000110";
	elsif bcd = "0100" then siete <= "1001100";
	elsif bcd = "0101" then siete <= "0100100";
	elsif bcd = "0110" then siete <= "0100000";
	elsif bcd = "0111" then siete <= "0001111";
	elsif bcd = "1000" then siete <= "0000000";
	elsif bcd = "1001" then siete <= "0000100";
	end if;
	end process;

end seleccion;
