--Author : Omer

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity vending_machine is
	
	port( 	
		clk 		: in std_logic ;
		rst 		: in std_logic ;
		para_girisi 	: in std_logic ;
		para_miktar 	: in std_logic_vector(4 downto 0) ;
		  
		para_ustu_hazir : out std_logic ;
		urun_hazir      : out std_logic 

	    );

end entity;

architecture arch of vending_machine is

type states is (IDLE,PARA_GIRIS,URUN_TESLIM,PARA_USTU);
signal state : states;


--Process Signal

signal toplam_para 	: std_logic_vector(4 downto 0);
signal eksik_para_flag 	: std_logic;
signal fiyat 		: std_logic_vector(4 downto 0) := "01010";

begin

	fiyat <= "01010" ;

	process(rst,clk)
	begin

		if (rst='1') then
			state 		<= IDLE ;
			toplam_para 	<= (others => '0');
			para_ustu_hazir <= '0';
			urun_hazir      <= '0';
			eksik_para_flag <= '0';
		elsif(rising_edge(clk)) then
			case state is
				when IDLE =>
					-- Reset process parameters/outputs
					toplam_para 	<= (others => '0');
					para_ustu_hazir <= '0';
					urun_hazir      <= '0';
					eksik_para_flag <= '0';
					if(para_girisi = '1') then
						state 		<= PARA_GIRIS ;
						toplam_para 	<= toplam_para + para_miktar ;
			
					else
						state <= IDLE ;
					
					end if;			
				when PARA_GIRIS =>
					if(para_girisi = '1') then
						state 		<= PARA_GIRIS ;
						toplam_para 	<= toplam_para + para_miktar ;
					else
						if (toplam_para >= fiyat) then
							state <= URUN_TESLIM ;											
						else	
							state <= PARA_USTU ;		
							eksik_para_flag <= '1';
						end if;
					end if;

				
				when URUN_TESLIM =>
					toplam_para 	<= toplam_para - fiyat ;
					urun_hazir  	<= '1' ;
					state 		<= PARA_USTU ;
				
				when PARA_USTU =>
					eksik_para_flag <= '0' ;
					if (toplam_para /= "00000") then
						toplam_para 	<= toplam_para - "00001" ;
						para_ustu_hazir <= '1' ;
						state 		<= PARA_USTU ;
					else
						state 		<= IDLE;
						para_ustu_hazir <= '0' ;
					
					end if;
						
				when others =>
					state 		<= IDLE ;
					toplam_para 	<= (others => '0');
					para_ustu_hazir <= '0';
					urun_hazir      <= '0';
					eksik_para_flag <= '0';	

			end case;
		end if;
	end process;
end architecture;
