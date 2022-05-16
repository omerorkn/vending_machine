----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Omer
-- 
-- Create Date: 08.11.2020 21:23:00
-- Design Name: 
-- Module Name: tb_vending_machine - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_vending_machine is
--  Port ( );
end tb_vending_machine;

architecture Behavioral of tb_vending_machine is
component vending_machine is
	
	port( clk 		  : in std_logic ;
		  rst 		  : in std_logic ;
		  para_girisi : in std_logic ;
		  para_miktar : in std_logic_vector(4 downto 0) ;
		  
		  para_ustu_hazir   : out std_logic ;
		  urun_hazir        : out std_logic 

	    );
end component;

signal clk 		  		 :  std_logic ;
signal rst 		  		 :  std_logic ;
signal para_girisi  	 :  std_logic ;
signal para_miktar  	 :  std_logic_vector(4 downto 0) ;
 
signal para_ustu_hazir   :  std_logic ;
signal urun_hazir        :  std_logic ; 

constant clock_period : time := 20ns   ;

begin

clock_process: process
begin
	clk <= '0';
	wait for clock_period/2;
	clk <= '1';
    wait for clock_period/2;
	
end process;

uut: vending_machine port map(
	
	clk 		  	 => clk, 		  		
    rst 		  	 => rst, 		  		
    para_girisi  	 => para_girisi,  	
    para_miktar  	 => para_miktar,  	
					  
    para_ustu_hazir  => para_ustu_hazir,
    urun_hazir       => urun_hazir     

);

stim_proc : process
begin
rst <= '1';
para_girisi <= '0';
para_miktar <= (others => '0');
wait for 100ns ;
rst <= '0';
wait for clock_period*2;


--test1--

para_girisi <= '1';
para_miktar <= "00001";
wait for clock_period;
para_miktar <= "00101";
wait for clock_period;
para_miktar <= "01010";
wait for clock_period;
para_girisi <= '0';
wait for clock_period*15;

--test2--

para_girisi <= '1';
para_miktar <= "00001";
wait for clock_period;
para_miktar <= "00001";
wait for clock_period;
para_miktar <= "00101";
wait for clock_period;
para_girisi <= '0';
wait for clock_period*15;

--test3--

para_girisi <= '1';
para_miktar <= "00101";
wait for clock_period;
para_miktar <= "00001";
wait for clock_period;
para_miktar <= "00001";
wait for clock_period;
para_miktar <= "00101";
wait for clock_period;
para_girisi <= '0';
wait for clock_period*15;

--test4--

para_girisi <= '1';
para_miktar <= "01010";
wait for clock_period;
para_miktar <= "00101";
wait for clock_period;
para_girisi <= '0';
wait for clock_period*15;

wait;
end process;


end Behavioral;