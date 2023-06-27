library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ffJK is

	port
	(
		-- Input ports
		J,K: in  std_logic;
		rst: in std_logic;
		clk: in	std_logic;

		-- Output ports
		Q	: out std_logic);
	
end ffJK;


architecture memoria of ffJK is

	signal qin,qout: std_logic;
	signal JK  		: std_logic_vector(1 downto 0);

begin

	JK <= J & K;

	process(clk,rst)

	begin
		
		if rst = '0' then 
			qout <= '0';
		elsif rising_edge(clk) then
			qout <= qin;
		end if;
		
	end process;
	
	with JK select
				 qin <= qout		when "00",
						  '0' 		when "01",
						  '1' 		when "10",
						  not qout	when others;

	Q <= qout;

end memoria;
