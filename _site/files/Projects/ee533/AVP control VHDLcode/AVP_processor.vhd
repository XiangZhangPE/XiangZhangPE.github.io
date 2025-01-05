library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity processor is 
 	generic(CounterWidth: integer:= 8;
 	        DACWidth: integer:= 8;
			SWPeriod_norm: std_logic_vector:=B"00110100"
			);

	port(reset:IN std_logic;
		CLK: IN std_logic;
		PWR: IN std_logic;
		CompV: IN std_logic;
		CompI1, CompI2, CompI3: IN std_logic;
		PWM0H,PWM0L,PWM1H,PWM1L,PWM2H,PWM2L: out std_logic;
		DACI: OUT std_logic_vector(CounterWidth-1 downto 0);
		DACV: OUT std_logic_vector(CounterWidth-1 downto 0)
		);
end processor;

architecture structural of processor is
    component control_unit is
        generic(DACWidth: integer := 8;
			CounterWidth: integer:= 8);
        port(reset, clk, PWR: in std_logic;
		  SWPeriod: in std_logic_vector(CounterWidth-1 downto 0);
		  SGNSWON: out std_logic;
		  SGNSWOFF: in std_logic;
		  PhSelect: out std_logic_vector(1 downto 0);
		  DACV,DACI: out std_logic_vector(DACWidth-1 downto 0);
		  CompV: in std_logic);
	end component;
	
	component DPWM is 
	port(SGNSWON, CompI1, CompI2, CompI3: in std_logic;
	    CLK: in std_logic;
		PhSelect: in std_logic_vector(1 downto 0);
		SGNSWOFF: out std_logic;
		SWCLK: out std_logic;
		PWM0H,PWM0L,PWM1H,PWM1L,PWM2H,PWM2L: out std_logic);
    END component;
    
    component period_calculator is 
	generic(CounterWidth: integer:= 8;
			SWPeriod_norm: std_logic_vector:=B"00110100");

	port(reset:IN std_logic;
		CLK: IN std_logic;
        SWCLK:IN std_logic;
        SWPeriod: OUT std_logic_vector(CounterWidth-1 downto 0));
    END component;
	
-- COMPONENT declarations (control_unit & DPWM & Period_Calculator)
signal	SWCLK, SGNSWON, SGNSWOFF: std_logic;
signal  PhSelect: std_logic_vector(2 downto 0);
signal	SWPeriod: std_logic_vector(CounterWidth-1 downto 0);

Begin
    --U0: entity control_unit(algorithm)
    U0: control_unit
        generic map (DACWidth => DACWidth, CounterWidth => CounterWidth)
	    port map(reset=>reset,CLK=>CLK,PWR=>PWR,
	    SWPeriod=>SWPeriod,
	    SGNSWON=>SGNSWON,SGNSWOFF=>SGNSWOFF,PhSelect=>PhSelect,
		DACI=>DACI,DACV=>DACV,CompV=>CompV);
    
    --U1: entity DPWM(structural)
    U1: DPWM
        port map(SGNSWON=>SGNSWON,SGNSWOFF=>SGNSWOFF,PhSelect=>PhSelect,
        CLK=>CLK,SWCLK=>SWCLK,
        CompI1=>CompI1, CompI2=>CompI2, CompI3=>CompI3,
        PWM0H=>PWM0H,PWM0L=>PWM0L,PWM1H=>PWM1H,PWM1L=>PWM1L,PWM2H=>PWM2H,PWM2L=>PWM2L);

    --U2: entity period_calculator(behavioral)
    U2: period_calculator
        generic map (CounterWidth => CounterWidth)
        port map(reset=>reset,CLK=>CLK,SWCLK=>SWCLK,SWPeriod=>SWPeriod);
end structural;
