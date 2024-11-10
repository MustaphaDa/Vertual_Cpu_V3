# CPU Simulation with Verilog and Python Assembler

This project simulates a simple CPU with basic instructions like `AND`, `OR`, `ADD`, `SUB`, `LD`, `STORE`, and `JMP`. It uses Verilog for the hardware description and Python for assembling assembly code into machine code. The Verilog-based CPU is tested by loading machine code from an assembled file and simulating the CPU's behavior. The simulation results are captured in a waveform file, which can be viewed using the GTKWave viewer.

## Features

- **Assembly to Machine Code**: The `assembler.py` script converts assembly language instructions into binary machine code.
- **CPU Design**: The Verilog code defines a simple CPU with an ALU, control unit, and memory, capable of executing basic operations.
- **Simulation**: The CPU's operation is simulated using `iverilog` for compilation and `vvp` for execution.
- **Waveform Viewer**: Simulation results are dumped into a `.vcd` file for visualization in GTKWave.

## Prerequisites

- Python 3.x
- Verilog tools:
  - `iverilog` for compiling Verilog code
  - `vvp` for running the simulation
  - `gtkwave` for viewing the waveform
- Make (optional, for automating the process)

## Installation

1. **Install Verilog Tools**:
   - On Ubuntu/Debian:
     ```bash
     sudo apt-get install iverilog gtkwave
     ```
   - On macOS (using Homebrew):
     ```bash
     brew install iverilog gtkwave
     ```

2. **Install Python 3**:
   - Ensure Python 3 and `pip` are installed. If not, install Python 3 from [python.org](https://www.python.org/).

3. **Clone the repository** (or create the files manually):
   ```bash
   git clone <repository_url>
   cd <repository_folder>
