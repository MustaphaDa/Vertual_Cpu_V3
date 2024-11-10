module CPU(
    input wire clk,
    input wire reset,
    input wire [7:0] instruction,
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output wire [7:0] result,
    output wire zero,
    output wire carry,
    output wire negative
);

// Internal control signals
wire [7:0] opcode;
wire mem_read, mem_write, reg_write, branch, jump;
wire [7:0] alu_result, address, mem_data;

// Register definitions
reg [7:0] regA = 8'b0;
reg [7:0] regB = 8'b0;

// Synchronous reset and register update
always @(posedge clk or posedge reset) begin
    if (reset) begin
        regA <= 8'b0;
        regB <= 8'b0;
    end else begin
        regA <= data_in_a;
        regB <= data_in_b;
    end
end

// Instantiate Control Unit
    ControlUnit CU (
        .instruction(instruction),
        .ALUOp(opcode),
        .MemRead(mem_read),
        .MemWrite(mem_write),
        .RegWrite(reg_write),
        .Branch(branch),
        .Jump(jump),
        .address(address)
    );

// ALU Module
Alu alu (
    .opcode(opcode),
    .A(regA),
    .B(regB),
    .Result(alu_result),
    .Zero(zero),
    .Carry(carry),
    .Negative(negative)
);

// Memory Module
memory mem (
    .clk(clk),
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .address(address),
    .data_in(regB),      // Data to write to memory
    .data_out(mem_data)  // Data read from memory
);

// Output assignment for the result
assign result = alu_result;

endmodule
