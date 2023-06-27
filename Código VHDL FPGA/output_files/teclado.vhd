library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity teclado is

	port
	(
		
	clk: in std_logic;
	c: in std_logic_vector(3 downto 0); -- columnas 
	
	f: out std_logic_vector(3 downto 0); -- filas 
	seg: out std_logic_vector(6 downto 0)
	);
		
end teclado;

architecture tecla of teclado is 

	component div_frec
	port (
			-- Input ports
			clk: in  std_logic;
			Nciclos: in	integer;			-- número de ciclos para la frecuencia deseada
			
			-- Output ports
			f: out std_logic);
	end component;

	component antirebote
	port (
			-- Input ports
			clk: in  std_logic;
			btn_entrada: in std_logic;			
			
			-- Output ports
			btn_salida: out std_logic);
	end component;

	component BCD_seg
	port (	
			-- Input ports
			bcd: in  std_logic_vector (3 downto 0);

			-- Output ports
			siete: out std_logic_vector (6 downto 0));
	end component;

	signal fr,far,b: std_logic; --frecuencias reducidas y bandera de guardado
	signal reg: std_logic_vector(3 downto 0):= "0001" ; --fila de registro de 3 a 0
	signal bcd, cl: std_logic_vector(3 downto 0); -- numero bcd, columna limpia  
	signal col_fil: std_logic_vector(7 downto 0); 
	
begin 

	df1: div_frec port map(clk, 10000, far);
	df2: div_frec port map(clk, 1250000, fr);
	
	ar: for i in 0 to 3 generate 
		antr: antirebote port map(far, c(i), cl(i));
	end generate; 
	
	process ( fr, b) begin
		
		-- registro  de dezplazamiento 
		
		if rising_edge(fr) then 
			reg <= reg(0) & reg(3 downto 1);
		end if; 
		
		--memoria 
		
		b <= cl(0) or cl(1) or cl(2) or cl(3); 

		if rising_edge(b) then 
		 col_fil <= c & reg;
		end if; 
	end process;
	
	-- seleccion 
	 
	with col_fil select 
	bcd <= "0000" when "01000001",
			"0001" when "10001000",
			"0010" when "01001000",
			"0011" when "00101000",
			"0100" when "10000100",
			"0101" when "01000100",
			"0110" when "00100100",
			"0111" when "10000010",
			"1000" when "01000010",
			"1001" when "00100010",
			"1010" when "00011000",
			"1011" when "00010100",
			"1100" when "00010010",
			"1101" when "10000001",
			"1110" when "00100001",
			"1111" when "00010001",
			bcd when others; 
			
	bcd_segr : BCD_seg port map (bcd,seg);
	
			
	f <= reg; 




end tecla;