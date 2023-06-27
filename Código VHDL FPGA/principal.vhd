library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity principal is

	port
	(
		-- Input ports
		clk: in  std_logic;
		star: in std_logic;
		reset: in std_logic;
		mux: in std_logic;
		corriente: in std_logic;
		-- del teclado
		columnas: in std_logic_vector(3 downto 0); -- columnas 
		filas: out std_logic_vector(3 downto 0); -- filas
		cambio: in std_logic;
		boton: in std_logic;
		--
		-- Output ports
		led1 : buffer std_logic;
		led2 : buffer std_logic;
		led3 : buffer std_logic;
		led4 : buffer std_logic;
		led5 : buffer std_logic;
		led6 : buffer std_logic;
		t1 : buffer std_logic; 
		t2 : buffer std_logic;
		t3 : buffer std_logic; 
		t4 : buffer std_logic;
		t5 : buffer std_logic; 
		t6 : buffer std_logic;
		buzer : buffer std_logic;
		led : buffer std_logic;
		segmentos	: out std_logic_vector(6 downto 0) 
	);
		
end principal;

architecture muu of principal is 


	component primer
	port (
		-- Input ports
		c: in  std_logic;
		unid_seg : in  std_logic_vector (6 downto 0);
	   dec_seg : in std_logic_vector (6 downto 0);
	   unid_min : in std_logic_vector (6 downto 0);
	   dec_min : in std_logic_vector (6 downto 0);
	   unid_hora : in std_logic_vector (6 downto 0);
	   dec_hora : in std_logic_vector (6 downto 0);
		star: in std_logic;
		reset: in std_logic;
		mux: in std_logic;
		-- Output ports
		t1 : buffer std_logic; 
		t2 : buffer std_logic;
		t3 : buffer std_logic; 
		t4 : buffer std_logic;
		t5 : buffer std_logic; 
		t6 : buffer std_logic;
		buzer : buffer std_logic;
		segmentos	: out std_logic_vector(6 downto 0)
			 );
	end component;
	component teclado
	port (
		
	clk: in std_logic;
	c: in std_logic_vector(3 downto 0); -- columnas 
	
	f: out std_logic_vector(3 downto 0); -- filas 
	seg: out std_logic_vector(6 downto 0) );
	end component;
	signal tecla : std_logic_vector(6 downto 0) ;
	signal clk2:std_logic;
	signal clk3:std_logic;
	signal tr1,tr2,tr3,tr4,tr5,tr6: std_logic;
	signal buzer2 : std_logic;
	signal sed : std_logic_vector (6 downto 0);
	component div_frec
	port(
		-- Input ports
		clk: in  std_logic;
		Nciclos: in	integer;			-- número de ciclos para la frecuencia deseada
		
		-- Output ports
		f: out std_logic);
	end component;
	signal unid_seg : std_logic_vector (6 downto 0) := "1001100";
	signal dec_seg : std_logic_vector (6 downto 0):= "1001100" ;
	signal unid_min : std_logic_vector (6 downto 0) := "0000001";
	signal dec_min : std_logic_vector (6 downto 0):= "0000001";
	signal unid_hora : std_logic_vector (6 downto 0):= "0000001";
	signal dec_hora : std_logic_vector (6 downto 0):= "0000001";
	signal numero: Std_logic_vector (2 downto 0) := "000";
	signal clk4: std_logic;
begin 
clk2 <= clk;


funcion : teclado port map(clk,columnas,filas ,tecla);
 
dir : div_frec port map(clk,12500,clk4);
dir2 : div_frec port map(clk,25000000,clk3);

Process (clk3) begin
	if rising_edge(clk3) then
		if numero = "000" and boton = '0' then
		numero <= "001";
		led2 <= '0';
		elsif numero = "001" and boton = '0' then
		numero <= "010";
		led3 <= '0';
		elsif numero = "010" and boton = '0' then
		numero <= "011";
		led4 <= '0';
		elsif numero = "011" and boton = '0' then
		numero <= "100";
		led5 <= '0';
		elsif numero = "100" and boton = '0' then
		numero <= "101";
		led6 <= '0';
		elsif numero = "101" and boton = '0' then
		numero <= "000";
		led1 <= '0';
		else 
		led1 <= '1';
		led2 <= '1';
		led3 <= '1';
		led4 <= '1';
		led5 <= '1';
		led6 <= '1';
		
		end if;
	end if;
end process;

	process ( clk4, cambio) begin
		if cambio = '0' then 
			if rising_edge(clk4) then
			if numero = "000" then
			unid_seg <= tecla;
--			led1 <='0';
			elsif numero = "001" then
			dec_seg <= tecla;
--			led2 <='0';
			elsif numero = "010" then
			unid_min <= tecla;
--			led3 <='0';
			elsif numero = "011" then
			dec_min <= tecla;
--			led4 <='0';
			elsif numero = "100" then
			unid_hora <= tecla;
	--		led5 <='0';
			elsif numero = "101" then
			dec_hora <= tecla;
		--	led6 <='0';
			else
--				led1 <= '1';
--				led2 <= '1';
--				led3 <= '1';
--				led4 <= '1';
--				led5 <= '1';
--				led6 <= '1';
			end if;
			else
			
			end if;
		end if; 		 
	end process;
contad : primer port map (clk2,unid_seg,dec_seg, unid_min, dec_min, unid_hora, dec_hora, star,reset,mux,tr1,tr2,tr3,tr4,tr5,tr6,buzer2,sed); 
	process ( clk,clk2,cambio) begin
		if rising_edge(clk) then 
			if cambio = '0' then
			
			t1 <= '0'; t2 <= '1';
			t3 <= '1'; t4 <= '1';
			t5 <= '1'; t6 <= '1';
			segmentos <= tecla;
			else
			t1 <= tr1; t2 <= tr2;
			t3 <= tr3; t4 <= tr4;
			t5 <= tr5; t6 <= tr6;
			segmentos <= sed;
			buzer <= buzer2;
			led <= buzer2;
			end if;
		end if; 		 
	end process;

	
	

end muu;