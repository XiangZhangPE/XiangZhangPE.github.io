library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.ALL;


entity control_unit is
    generic(DACWidth: integer := 8;
			CounterWidth: integer:= 8);
    
    port(reset, clk, PWR: in std_logic;
		SWPeriod: in std_logic_vector(CounterWidth-1 downto 0);
		SGNSWON: out std_logic;
		SGNSWOFF: in std_logic;
		PhSelect: out std_logic_vector(1 downto 0);
		DACV,DACI: out std_logic_vector(DACWidth-1 downto 0);
		CompV: in std_logic);
end control_unit;

architecture algorithm of control_unit is
    type state_type is (state_on, state_off, state_idle);
    signal state: state_type;
    signal SGNcompV: std_logic:='0';
        
begin
    process(clk)
    begin
        if rising_edge(clk) then
            SGNCompV<=CompV;
        end if;
    end process;
    
    process(clk,reset)
        Variable VarSGNSWON :std_logic:='0';
        Variable VarDACV :std_logic_vector(DACWidth-1 downto 0):=B"00000000";
        Variable VarDACI :std_logic_vector(DACWidth-1 downto 0):=B"00000000";
        Variable TrasientFlag :std_logic:='0';
        Variable delt_Ipk,delt_Vlow :std_logic_vector(DACWidth-1 downto 0):=B"00000000";
        Variable VarPhSelect:std_logic_vector(1 downto 0):=B"00";
    begin
    if rising_edge(clk) then
		if reset = '1' then state <= state_idle;
        else
            case state is
                when state_idle =>
                    if PWR = '1' then 
                        state <= state_on;
                    else state <= state_idle;
                    end if;
                when state_on =>
                    if rising_edge(SGNSWOFF) 
                        then if TrasientFlag='1' then 
                                VarDACV := VarDACV+delt_Vlow;
                                VarDACI := VarDACI+delt_Ipk;
                                TrasientFlag := '0';
                            end if;
                        state <= state_off;
                    end if;
                when state_off =>
                    if rising_edge(SGNCompV)AND(SWPeriod<B"01011111") then  --SWPeriod<95
                            TrasientFlag := '1'; 
                            TrasientFlag := '1';
                            state <= state_on;
                    else
                        if rising_edge(SGNCompV)AND(SWPeriod>B"01101001") then --SWPeriod>105
                            TrasientFlag := '1';
                            state <= state_on;
                        else
                          if rising_edge(SGNCompV)AND(SWPeriod>="01011111")AND(SWPeriod<=B"01101001") then
                                TrasientFlag := '0';
                                delt_Vlow:= B"00000000";
                                delt_Ipk:= B"00000000";
                                VarDACV:=B"00000000";
                                state <= state_on;
                            end if;
                        end if;
                    end if;
            end case;                    
          SGNSWON <= VarSGNSWON;
          PhSelect <= VarPhSelect;
          DACV <= VarDACV;
          DACI <= VarDACI;          
        end if;
    end if;
    end process;
end algorithm;

