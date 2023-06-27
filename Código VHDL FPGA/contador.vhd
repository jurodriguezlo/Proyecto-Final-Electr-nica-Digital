library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador is

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
		
end contador;


architecture cont of contador is
	
	signal Nciclos2: integer := 156250;
	signal Nciclos3: integer := 125000;
	signal freq1: std_logic;
	signal freq2: std_logic;
	signal freq3: std_logic;
	
	
	component div_frec
		port(
			-- Input ports
			clk: in  std_logic;
			Nciclos: in	integer;			-- número de ciclos para la frecuencia deseada
			
			-- Output ports
			f: out std_logic);
	end component;
	
	component antirebote
	port(
		-- Input ports
		clk: in  std_logic;
		btn_entrada: in std_logic;			
		
		-- Output ports
		btn_salida: out std_logic);
		end component;
	
	signal star1: std_logic;
	signal reset1: std_logic;
		
	component ffjk
	port
	(
		-- Input ports
		J,K: in  std_logic;
		rst: in std_logic;
		clk: in	std_logic;

		-- Output ports
		Q	: out std_logic);
		end component;
		
		signal q0:std_logic;
		signal q1:std_logic;
		signal q2:std_logic;
		signal q3:std_logic;
		signal q4:std_logic;
      signal q5:std_logic;
		signal jk2: std_logic;
		signal jk3: std_logic;
		signal jk4: std_logic;
		signal jk5: std_logic;
		
		--codificador bcd
		signal num : std_logic_vector (7 downto 0);
		
		component dec_BCD
		PORT(
        num_bin: in  STD_LOGIC_VECTOR(7 downto 0);
		  k0_bcd:  out std_logic_vector(3 downto 0);
		  k1_bcd:  out std_logic_vector(3 downto 0);
		  k2_bcd:  out std_logic_vector(3 downto 0);
        num_bcd: out STD_LOGIC_VECTOR(10 downto 0)
    );
	 end component;
	 
	signal k0_bcd:  std_logic_vector(3 downto 0);
	signal  k1_bcd:  std_logic_vector(3 downto 0);
	signal	k2_bcd: std_logic_vector(3 downto 0);
   signal   num_bcd: STD_LOGIC_VECTOR(10 downto 0);
	
	--multiplexor
	
	component BCD_seg
	port
	(
		-- Input ports
		bcd: in  std_logic_vector (3 downto 0);
		

		-- Output ports
		siete: out std_logic_vector (6 downto 0));
	end component;
	
--	signal unidades: std_logic_vector(6 downto 0);
--	signal decenas: std_logic_vector(6 downto 0);	
	signal cont : std_logic :='0';
	signal boton : std_logic :='1';
	signal algo: std_logic :='0';
begin

	-- frecuencias requeridas
	Cfreq1 : div_frec port map ( clk, Nciclos1, freq1); --frecuencia de 1Hz para el contador
	Cfreq2 : div_frec port map ( clk, Nciclos2, freq2); --frecuencia de 160Hz para para anti rebote
	--anti rebote
	anti : antirebote port map (freq2,star,star1 ); -- antirebote boton inicio
	ante : antirebote port map (freq2,reset,reset1); --antirebote boton reset
	-- star
	
	boton <= not star1;
--	process(freq1, star1) 
--	begin
--	
--		if rising_edge(freq1) then 
--		
--			if star1 = '0' then
--				boton <= not boton;
--			else
--				algo <= not algo;
--			end if;
--		end if;
--		
--	end process;

	
    --contador
	 ffQ0 : ffjk port map ('1','1',reset1,not freq1 ,q0); --primer flip flop jk=1
	 ffQ1 : ffjk port map (q0,q0,reset1,not freq1,q1); -- ff1 : j y k = q0
	 jk2 <= q0 and q1 and (not (q3 and q4 and q5));
	 ffQ2 : ffjk port map (jk2,jk2,reset1,not freq1,q2);-- ff2 : jk = q0 q1q3'q4'q5'
	 jk3 <= q0 and q1 and (q2 or (q3 and q4 and q5));
	 ffQ3 : ffjk port map (jk3,jk3,reset1,not freq1,q3);-- ff3 : jk = q0q1(q2+q3q4q5)
	 jk4 <= q0 and q1 and q3 and (q2 or (q4 and q5));
	 ffQ4 : ffjk port map (jk4,jk4,reset1,not freq1,q4);-- ff4 : jk = q0q1q3(q2+q4q5)
	 jk5 <= q0 and q1 and q3 and q4 and (q2 or q5);
	 ffQ5 : ffjk port map (jk5,jk5,reset1,not freq1,q5);-- ff5 : jk = q0q1q3q4(q2+q5)
		
	 --codificador decimal BCD
	 num(0) <= q0; num(1) <= q1;	 num(2) <= q2;	 num(3) <= q3;
	 num(4) <= q4;	num(5) <= q5;   num(6) <= '0'; num(7) <= '0';
	 code1 : dec_BCD port map (num,k0_bcd,k1_bcd,k2_bcd, num_bcd); 
	 
	 
	 -- BCD - 7 segmentos
	 uni : BCD_seg port map (k0_bcd,unidades );
	dec : BCD_seg port map (k1_bcd,decenas );
	
	-- multiplexa tierras
--	
--	process(freq3,t1,t2) 
--	begin
--	
--		
--		if rising_edge(freq3) then 
--		
--			if cont = '0' then
--				t1 <= '0';
--				t2 <= '1';
--				segmentos <= unidades;
--				cont <= '1';
--			else
--				t1 <= '1';
--				t2 <= '0';
--				segmentos <= decenas;
--				cont <= '0'; 
--			end if;
--		end if;
--		
--		
--	end process;
	
end cont;