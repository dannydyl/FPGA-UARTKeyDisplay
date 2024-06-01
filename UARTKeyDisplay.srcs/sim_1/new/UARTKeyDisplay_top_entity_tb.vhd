library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity UARTKeyDisplay_tb is
-- Testbench has no ports
end UARTKeyDisplay_tb;

architecture Behavioral of UARTKeyDisplay_tb is

    -- Signals to connect to the DUT (Device Under Test)
    signal clk_tb : std_logic := '0';
    signal UART_serial_in_tb : std_logic := '0';
    signal LED_busy_tb : std_logic;
    signal an_tb : std_logic_vector(3 downto 0);
    signal seg_display_tb : std_logic_vector(6 downto 0);
    
    -- Clock period
    constant clk_period : time := 10 ns;

    -- DUT component declaration
--    component UARTKeyDisplay_top_entity
--    port(
--        clk : in std_logic;
--        UART_serial_in : in std_logic;
--        LED_busy : out std_logic;
--        an : out std_logic_vector(3 downto 0);
--        seg_display : out std_logic_vector(6 downto 0)
--    );
--    end component;

begin
    -- Instantiate the DUT
    DUT: entity UARTKeyDisplay_top_entity
    port map(
        clk => clk_tb,
        UART_serial_in => UART_serial_in_tb,
        LED_busy => LED_busy_tb,
        an => an_tb,
        seg_display => seg_display_tb
    );


 -- Clock process
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        UART_serial_in_tb <= '1'; 
        wait for clk_period * 10417;
        
        -- Apply UART serial data
        UART_serial_in_tb <= '0'; -- Start bit
        wait for clk_period * 10417;
        
        -- Transmit 8-bit data (e.g., 0x41 = 01000001)
        UART_serial_in_tb <= '1'; -- Bit 0
        wait for clk_period * 10417;
        UART_serial_in_tb <= '0'; -- Bit 1
        wait for clk_period * 10417;
        UART_serial_in_tb <= '0'; -- Bit 2
        wait for clk_period * 10417;
        UART_serial_in_tb <= '0'; -- Bit 3
        wait for clk_period * 10417;
        UART_serial_in_tb <= '0'; -- Bit 4
        wait for clk_period * 10417;
        UART_serial_in_tb <= '0'; -- Bit 5
        wait for clk_period * 10417;
        UART_serial_in_tb <= '1'; -- Bit 6
        wait for clk_period * 10417;
        UART_serial_in_tb <= '0'; -- Bit 7
        wait for clk_period * 10417;
        
        UART_serial_in_tb <= '1'; -- Stop bit
        wait for clk_period * 10417;

        -- Set UART serial input to '0' for 10 seconds
        UART_serial_in_tb <= '1';
        wait for 10 sec;

        -- End of test
        wait;
    end process;
    
    
end Behavioral;
