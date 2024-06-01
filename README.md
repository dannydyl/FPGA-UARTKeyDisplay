# UARTKeyDisplay Project

## Overview

This project implements a UART-based 7-segment display controller using the Basys3 FPGA development board. The project was designed and implemented using Vivado Xilinx tools and Putty for UART communication. The system operates at a baud rate of 9600 and displays received data on a 7-segment display.

## Features

- **UART Receiver**: Captures serial data at a baud rate of 9600.
- **7-Segment Display Controller**: Decodes the received UART data and displays it on a 7-segment display.
- **Clock Divider**: Generates a 100 Hz signal from the 100 MHz system clock to multiplex the 7-segment display.
- **Modular Design**: Includes separate modules for UART reception, 7-segment display decoding, and top-level entity integration.
- **Testbenches**: Comprehensive testbenches for each module to ensure correct functionality.

## System Architecture

### UART Receiver

The UART receiver module captures serial data, verifies the start bit, reads the data bits, and checks for the stop bit. The data is then made available to the rest of the system. The receiver uses a state machine to manage its operation and includes a clock divider to handle the timing requirements for UART communication.

### 7-Segment Display Controller

The 7-segment display controller module converts 4-bit binary values into 7-segment display signals. It supports all hexadecimal digits (0-9, A-F) and uses a lookup table to determine the appropriate segment outputs.

### Clock Divider

A clock divider module reduces the 100 MHz system clock to a 100 Hz clock signal. This slower clock is used to multiplex the 7-segment display, switching between the digits to create a stable display output.

### Top-Level Entity

The top-level entity integrates the UART receiver and the 7-segment display controller. It manages the multiplexing of the 7-segment display using the divided clock signal and routes the decoded UART data to the appropriate display segments.

## Implementation Details

1. **UART Receiver**:
    - Operates at a baud rate of 9600.
    - Double-registers incoming data to handle metastability.
    - Uses a state machine to detect start and stop bits and read data bits.

2. **7-Segment Display Controller**:
    - Converts 4-bit binary values to 7-segment display outputs.
    - Supports hexadecimal digit decoding.

3. **Clock Divider**:
    - Divides the 100 MHz system clock to 100 Hz.
    - Ensures stable multiplexing of the 7-segment display.

4. **Top-Level Integration**:
    - Combines UART receiver and display controller.
    - Manages display multiplexing with a 100 Hz clock signal.

## Testing

Comprehensive testbenches were developed for each module to verify their functionality. The testbenches simulate the behavior of each module and ensure correct operation under various conditions.

## Demonstration Video

A demonstration video of the project in action has been uploaded to YouTube. You can view the video here: [YouTube Link]

## Tools Used

- **Vivado Xilinx Tools**: For design and implementation.
- **Putty**: For UART communication and testing.
- **Basys3 FPGA Development Board**: The target hardware platform for the project.

## Contact

For any questions or further information, please contact [Your Name] at [Your Email].

---

This project was a great opportunity to explore FPGA design, UART communication, and display control. Thank you for checking out my work!
