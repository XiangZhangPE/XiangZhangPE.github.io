LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
USE ieee.std_logic_textio.all;

entity UTT_PeriodCalculator is
--  Port ( );
end UTT_PeriodCalculator;

architecture behavior of UTT_PeriodCalculator is
-- component declaration for the unit under test (uut)
    component PeriodCalculator is
		generic(CounterWidth: integer:= 8;
				SWPeriod_norm: std_logic_vector:=B"00110100");

		port(reset:IN std_logic;
			CLK: IN std_logic;
			SWCLK:IN std_logic;
			SWPeriod: OUT std_logic_vector(CounterWidth-1 downto 0));
    end component;

--declare inputs and initialize them to zero.
signal CLK : std_logic := '0';
signal reset : std_logic := '0';
signal SWCLK: std_logic :='0';

--declare outputs
signal SWPeriod: std_logic_vector(8-1 downto 0) := B"00110100";

-- define the period of clock here.
-- It's recommended to use CAPITAL letters to define constants.
constant CLK_PERIOD : time := 20 ns;

begin
    -- instantiate the unit under test (uut)
   UTT : PeriodCalculator port map (
            reset => reset, 
            CLK => CLK,
            SWCLK => SWCLK,
            SWPeriod => SWPeriod
        );      

   -- Clock process definitions( clock with 50% duty cycle is generated here.
   Clk_process :process
   begin
        CLK <= '0';
        wait for CLK_PERIOD/2;  --for half of clock period clk stays at '0'.
        CLK <= '1';
        wait for CLK_PERIOD/2;  --for next half of clock period clk stays at '1'.
   end process;
   
   -- Clock process definitions( clock with 50% duty cycle is generated here.
   SWClk_process :process
   begin
        SWCLK <= '1';
        wait for CLK_PERIOD*98*0.12/1;  --for half of clock period clk stays at '1'.
        SWCLK <= '0';
        wait for CLK_PERIOD*98*0.88/1;  --for next half of clock period clk stays at '0'.
   end process;
    
   -- Stimulus process, Apply inputs here.
  stim_proc: process
   begin        
        wait for CLK_PERIOD*10; --wait for 10 clock cycles.
        reset <='1';                    --then apply reset for 20 clock cycles.
                  --then apply reset for 20 clock cycles.
        wait for CLK_PERIOD*20;
        reset <='0';                    --then pull down reset for 20 clock cycles.
        wait for CLK_PERIOD*20;
        --reset <='1';               --then apply reset for one clock cycle.
        --wait for CLK_PERIOD;
        --reset <='0';               --pull down reset and let the counter run.
        wait;
  end process;

end;