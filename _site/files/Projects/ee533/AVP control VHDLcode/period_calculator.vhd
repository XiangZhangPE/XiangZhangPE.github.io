----------------------------------------------------------------------------------
-- Company: queensu
-- Engineer: xiang zhang
-- 
-- Create Date: 2022/02/13 15:53:54
-- Design Name: 
-- Module Name: 
-- Project Name: 
-- Target Devices: xc7z010clg400-1
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
-------------------------------------
--- Period Calculator for the Chip
-------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity period_calculator is 
	generic(CounterWidth: integer:= 8;
			SWPeriod_norm: std_logic_vector:=B"00110100");

	port(reset:IN std_logic;
		CLK: IN std_logic;
        SWCLK:IN std_logic;
        SWPeriod: OUT std_logic_vector(CounterWidth-1 downto 0));
END period_calculator;

architecture behavioral OF period_calculator IS
    begin 
        process (clk,reset,SWCLK)
			variable counter :std_logic_vector(CounterWidth-1 downto 0);
			variable counter_last :std_logic_vector(CounterWidth-1 downto 0);
            begin
            if reset='1'then
            counter:=(others=>'0');
			counter_last:=SWPeriod_norm;
            SWPeriod<=SWPeriod_norm;

            else
                if rising_edge(SWCLK) then 
						counter_last:=counter;
						counter:=(others=>'0');
				else
                    if rising_edge(clk) then
                            counter:=counter+1;
                    end if;
					SWPeriod <= counter_last;
				end if;
			end if;
    END PROCESS;
END behavioral;

