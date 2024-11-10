# Define opcode mappings and fields for each instruction type
OPCODES = {
    "AND": "0000",   # ALUOp = 8'b0000; RegWrite = 1
    "OR": "0001",    # ALUOp = 8'b0001; RegWrite = 1
    "ADD": "0010",   # ALUOp = 8'b0010; RegWrite = 1
    "SUB": "0011",   # ALUOp = 8'b0011; RegWrite = 1
    "LD": "0100",    # MemRead = 1; RegWrite = 1
    "STORE": "0101", # MemWrite = 1
    "JMP": "0110"    # Jump = 1
}

# Function to convert an instruction line into binary machine code
def assemble_line(line):
    parts = line.strip().split()
    if len(parts) < 1:
        return None
    
    # Extract opcode and operands
    instr = parts[0].upper()  # Opcode (e.g., "ADD", "LD")
    operands = parts[1:] if len(parts) > 1 else []

    # Look up opcode binary encoding
    opcode_binary = OPCODES.get(instr)
    if not opcode_binary:
        print(f"Control Unit: Invalid operation '{instr}'")
        return "00000000"  # Default binary for invalid operation

    # Assume registers are represented as R0, R1, etc., with a 4-bit encoding (for simplicity)
    # Example: Register "R1" -> "0001"
    operand_binaries = []
    for operand in operands:
        if operand.startswith("R"):
            # Convert register number to binary
            reg_num = int(operand[1:])
            operand_binaries.append(f"{reg_num:04b}")
        else:
            # Convert immediate values or addresses to binary (assume 4-bit values for simplicity)
            operand_binaries.append(f"{int(operand):04b}")

    # Construct binary instruction, appending operands if any
    instruction = opcode_binary + ''.join(operand_binaries).ljust(8, '0')  # Pad to 8 bits if necessary
    return instruction

# Main assembler function to process each line of code
def assemble_program(assembly_code):
    binary_program = []
    for line in assembly_code:
        binary_instruction = assemble_line(line)
        if binary_instruction:
            binary_program.append(binary_instruction)
    return binary_program

# Save the machine code to a .mem file
def save_to_mem_file(binary_program, filename):
    with open(filename, "w") as file:
        for i, instruction in enumerate(binary_program):
            # Each instruction should be written on a new line
            file.write(f"@{i*4}\n")  # Address (assuming 4-byte instructions)
            file.write(f"{instruction}\n")  # Machine code

# Example usage
assembly_code = [
    "LD R1 10",       # Load the value 5 into register R1
    "LD R2 10",       # Load the value 10 into register R2
    "ADD R3 R1 R2"    # Add the values in R1 and R2, store result in R3
]

binary_program = assemble_program(assembly_code)

# Print binary program to console for verification
print("Binary program:")
for binary_instruction in binary_program:
    print(binary_instruction)

# Save the machine code to a memory file that can be used in the Verilog testbench
save_to_mem_file(binary_program, "program.mem")
