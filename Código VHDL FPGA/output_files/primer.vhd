library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Primer is

	port
	(
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
		
end primer;


architecture proyec of primer is

component contador
		port
	(
		-- Input ports
		clk: in  std_logic;
		star: in std_logic;
		reset: in std_logic;
	   Nciclos1: in integer;
	-- Output ports
		--t1 : buffer std_logic; 
		--t2 : buffer std_logic;
		unidades : out std_logic_vector(6 downto 0);
		decenas : out std_logic_vector(6 downto 0) );
		--segmentos	: out std_logic_vector(6 downto 0) );
		
	end component;
	signal unidades1	: std_logic_vector(6 downto 0);
	signal decenas1	: std_logic_vector(6 downto 0);
	signal unidades2	: std_logic_vector(6 downto 0);
	signal decenas2	: std_logic_vector(6 downto 0);
	signal unidades3	: std_logic_vector(6 downto 0);
	signal decenas3	: std_logic_vector(6 downto 0);
	
	signal unidades4	: std_logic_vector(6 downto 0);
	signal decenas4	: std_logic_vector(6 downto 0);
	signal unidades5	: std_logic_vector(6 downto 0);
	signal decenas5	: std_logic_vector(6 downto 0);
	signal unidades6	: std_logic_vector(6 downto 0);
	signal decenas6	: std_logic_vector(6 downto 0);
	
	component div_frec
		port(
			-- Input ports
			clk: in  std_logic;
			Nciclos: in	integer;			-- número de ciclos para la frecuencia deseada
			
			-- Output ports
			f: out std_logic);
	end component;
	signal freq3 : Std_logic;
	signal cont : std_logic_vector(2 downto 0) :="000"; --manejo de if
	signal cont2 : std_logic_vector(2 downto 0) :="000"; --manejo de if
	signal clk: std_logic;
	signal clk2: std_logic;
	signal c2: std_logic;
begin
--( new clok

Process (c)
begin 
	if star ='0' then 
	clk <= c;
	else 
	cLK <= '1';
	end if;
end process;

--)
--bobada del cont de horas
Cfreq5 : div_frec port map (c,25000000, c2);

Process (c2)
begin 
	if star ='0' then 
	clk2 <= c2;
	else 
	cLK2 <= '1';
	end if;
end process;
--cntadores de corriente
		contseg : contador	port map (clk,star,reset,25000000,unidades1,decenas1); --contador de 60 segundos
		contmin : contador	port map (clk,star,reset,1500000000,unidades2,decenas2); --contador de 60 minutos
		conthora : contador	port map (clk2,star,reset,1800,unidades3,decenas3); --contador de 60 horas
		Cfreq3 : div_frec port map (c, 50000, freq3); --frecuencia para multiplexar
		--contadores de siempre
		contseg2 : contador	port map (c,'0','1',25000000,unidades4,decenas4); --contador de 60 segundos
		contmin2 : contador	port map (c,'0','1',1500000000,unidades5,decenas5); --contador de 60 minutos
		conthora2 : contador	port map (c2,'0','1',1800,unidades6,decenas6); --contador de 60 horas
		
		process(freq3) 
	begin
	
		
		if rising_edge(freq3) then 
		-- contador 0
			if mux='0' then
			
						if cont2 = "000" then
								t1 <= '0'; t2 <= '1';
								t3 <= '1'; t4 <= '1';
								t5 <= '1'; t6 <= '1';
								segmentos <= unidades4;
								cont2 <= "001";
							elsif cont2 = "001" then
								t1 <= '1'; t2 <= '0';
								t3 <= '1'; t4 <= '1';
								t5 <= '1'; t6 <= '1';
								segmentos <= decenas4;
								cont2 <= "010";
							elsif	cont2 = "010" then
								t1 <= '1'; t2 <= '1';
								t3 <= '0'; t4 <= '1';
								t5 <= '1'; t6 <= '1';
								segmentos <= unidades5;
								cont2 <= "011";
							elsif cont2 ="011" then
								t1 <= '1'; t2 <= '1';
								t3 <= '1'; t4 <= '0';
								t5 <= '1'; t6 <= '1';
								segmentos <= decenas5;
								cont2 <= "100";
							elsif	cont2 = "100" then
								t1 <= '1'; t2 <= '1';
								t3 <= '1'; t4 <= '1';
								t5 <= '0'; t6 <= '1';
								segmentos <= unidades6;
								cont2 <= "101";
							else	
								t1 <= '1'; t2 <= '1';
								t3 <= '1'; t4 <= '1';
								t5 <= '1'; t6 <= '0';
								segmentos <= decenas6;
								cont2 <= "000";
							end if;
		
		
		-- contador 1
					else		if cont = "000" then
								t1 <= '0'; t2 <= '1';
								t3 <= '1'; t4 <= '1';
								t5 <= '1'; t6 <= '1';
								segmentos <= unidades1;
								cont <= "001";
							elsif cont = "001" then
								t1 <= '1'; t2 <= '0';
								t3 <= '1'; t4 <= '1';
								t5 <= '1'; t6 <= '1';
								segmentos <= decenas1;
								cont <= "010";
							elsif	cont = "010" then
								t1 <= '1'; t2 <= '1';
								t3 <= '0'; t4 <= '1';
								t5 <= '1'; t6 <= '1';
								segmentos <= unidades2;
								cont <= "011";
							elsif cont ="011" then
								t1 <= '1'; t2 <= '1';
								t3 <= '1'; t4 <= '0';
								t5 <= '1'; t6 <= '1';
								segmentos <= decenas2;
								cont <= "100";
							elsif	cont = "100" then
								t1 <= '1'; t2 <= '1';
								t3 <= '1'; t4 <= '1';
								t5 <= '0'; t6 <= '1';
								segmentos <= unidades3;
								cont <= "101";
							else	
								t1 <= '1'; t2 <= '1';
								t3 <= '1'; t4 <= '1';
								t5 <= '1'; t6 <= '0';
								segmentos <= decenas3;
								cont <= "000";
							end if;
			end if;
		end if;
		
		
	end process;
	process(freq3) 
	begin
	
		if rising_edge(freq3) then 
		
			if unidades1 = unid_seg and decenas1 = dec_seg and unidades2 = unid_min and decenas2 = dec_min then
				buzer<='0';
			else
				buzer<='1';
			end if;
		end if;
			end process;
	--comparador para bocina:
	
	
	
end proyec;