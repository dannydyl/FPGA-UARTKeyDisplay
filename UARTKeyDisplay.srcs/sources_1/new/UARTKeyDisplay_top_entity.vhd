----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2024 04:20:17 PM
-- Design Name: 
-- Module Name: UARTKeyDisplay_top_entity - Behavioral
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
use work.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UARTKeyDisplay_top_entity is
    port(
        clk : in std_logic; -- local clock 100MHz
        UART_serial_in : in std_logic;
        LED_busy : out std_logic; -- LED indicator for UART RX
        an : out std_logic_vector(3 downto 0); -- anode for 7 seg display
        seg_display : out std_logic_vector(6 downto 0)
        );
        
end UARTKeyDisplay_top_entity;

architecture Behavioral of UARTKeyDisplay_top_entity is

signal uart_to_7seg_data : std_logic_vector(7 downto 0);
signal seg_data_0 : std_logic_vector(6 downto 0);
signal seg_data_1 : std_logic_vector(6 downto 0);
signal anode_select : std_logic := '0'; -- select between anode0 and anode1
signal counter : integer := 0; -- Counter for clock division
constant DIVISOR : integer := 500000; -- 100 MHz / 100 Hz / 2 (toggle) = 500000
begin
    UART_Receiver : entity UART_RX
    generic map(g_CLKS_PER_BIT => 10417 ) -- clock cycles per bit
    port map (
        i_Clk => clk,
        i_RX_Serial => UART_serial_in,
        o_RX_DV => LED_busy,
        o_RX_Byte => uart_to_7seg_data
        );
        
        -- for anode0, show the first 3 downto 0 index bits from uart
        anode0_Display_7_seg : entity hex_seven
        port map(
            hex => uart_to_7seg_data(3 downto 0),
            seg_drive => seg_data_0
            );
        
        -- for anode1, show the next 7 downto 4 index bits from uart    
        anode1_Display_7_seg : entity hex_seven
        port map(
            hex => uart_to_7seg_data(7 downto 4),
            seg_drive => seg_data_1
            );
            
    -- Clock divider process for anode_select
    process(clk)
    begin
        if rising_edge(clk) then
            if counter = DIVISOR - 1 then
                counter <= 0;
                anode_select <= not anode_select;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    -- Anode control and segment drive logic
    process(anode_select, seg_data_0, seg_data_1)
    begin
        if anode_select = '0' then
            an <= "1110"; -- Activate anode0 (assuming common anode)
            seg_display <= seg_data_0; -- Least significant hex digit
        else
            an <= "1101"; -- Activate anode1 (assuming common anode)
            seg_display <= seg_data_1; -- Most significant hex digit
        end if;
    end process;

end Behavioral;
