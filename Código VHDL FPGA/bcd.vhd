library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dec_BCD is

PORT(
        num_bin: in  std_logic_vector(7 downto 0);
		  k0_bcd:  out std_logic_vector(3 downto 0);
		  k1_bcd:  out std_logic_vector(3 downto 0);
		  k2_bcd:  out std_logic_vector(3 downto 0);
        num_bcd: out std_logic_vector(10 downto 0)
    );
	
end dec_BCD;

architecture code of dec_BCD is

begin

    proceso_bcd : process(num_bin)
        variable z: STD_LOGIC_VECTOR(18 downto 0);
    begin
        -- Inicialización de datos en cero.
        z := (others => '0');
        -- Se realizan los primeros tres corrimientos.
        z(9 downto 2) := num_bin;
        for i in 0 to 5 loop
            -- Unidades (4 bits).
            if z(11 downto 8) > 4 then
                z(11 downto 8) := z(11 downto 8) + 3;
					 --k0_bcd<=z(12 downto 9);
            end if;
            -- Decenas (4 bits).
            if z(15 downto 12) > 4 then
                z(15 downto 12) := z(15 downto 12) + 3;
					 --k1_bcd<=z(16 downto 13);
            end if;
            -- Centenas (3 bits).
            if z(18 downto 16) > 4 then
                z(18 downto 16) := z(18 downto 16) + 3;
					 --k2_bcd<=z(19 downto 17);
            end if;
            -- Corrimiento a la izquierda.
            z(18 downto 1) := z(17 downto 0);
        end loop;
        -- Pasando datos de variable Z, correspondiente a BCD.
        num_bcd <= z(18 downto 8);
		  k0_bcd<=z(11 downto 8);
		  k2_bcd<="0" & z(18 downto 16);
		  k1_bcd<=z(15 downto 12);
    end process;
	
end code;
