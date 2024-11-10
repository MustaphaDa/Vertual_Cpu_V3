# Compiler and viewer settings
IVERILOG = iverilog
VVP = vvp
WAVE_VIEWER = gtkwave
PYTHON = python3

# Source files
SOURCES = cpu.v alu.v control_unit.v memory.v testbench.v
TARGET = cpu_sim
WAVE_FILE = cpu_wave.vcd


.PHONY: all clean run wave assemble

# Default target
all: assemble $(TARGET)

# Assemble the assembly code into machine code
assemble:
	$(PYTHON) assembler.py > program.mem

# Compile the Verilog files
$(TARGET): $(SOURCES)
	$(IVERILOG) -o $(TARGET) $(SOURCES)

# Run the simulation
run: $(TARGET)
	$(VVP) $(TARGET)

# View waveform in gtkwave
view: run
	$(WAVE_VIEWER) $(WAVE_FILE)

# Clean up generated files
clean:
	rm -f $(TARGET) $(WAVE_FILE) program.mem
