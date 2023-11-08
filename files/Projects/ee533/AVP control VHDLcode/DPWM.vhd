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
entity DPWM is 
	port(SGNSWON, CompI1, CompI2, CompI3: in std_logic;
		PhSelect: in std_logic_vector(1 downto 0);
		SGNSWOFF: out std_logic;
		SWCLK: out std_logic;
		PWM0H,PWM0L,PWM1H,PWM1L,PWM2H,PWM2L: out std_logic);
END DPWM;

architecture structural OF DPWM IS
	signal Dset0,Dset1,Dset2,Drest0,Drest1,Drest2: std_logic;
	-- insert COMPONENT declarations
	begin
	SR0: entity SR_latch(sequential)
	port map(Dset0 => Dset, Drest0 => Drest,
	PWM0H => DQ, PWM0L => not DQ);
	
	SR1: entity SR_latch(sequential)
	port map(Dset1 => Dset, Drest1 => Drest,
	PWM1H => DQ, PWM1L => not DQ);
	
	SR2: entity SR_latch(sequential)
	port map(Dset2 => Dset, Drest2 => Drest,
	PWM2H => DQ, PWM2L => not DQ);
	
	DFF0: entity D_FlipFlop(sequential)
	port map(clk => clk, CompI1 => D, Drest0=> Q);
	
	DFF1: entity D_FlipFlop(sequential)
	port map(clk => clk, CompI2 => D, Drest1=> Q);
	
	DFF2: entity D_FlipFlop(sequential)
	port map(clk => clk, CompI3 => D, Drest2=> Q);
	
	MUX0: entity MUX_3to1(dataflow)
	port map(PhSelect => MUXsel, Dset0 =>out0, Dset1 =>out1, Dset2 =>out1);
	
	SWCLK <= PWM0H;
	SGNSWOFF <= (Drest0 or Drest1 or Drest2);
	
end structural;

