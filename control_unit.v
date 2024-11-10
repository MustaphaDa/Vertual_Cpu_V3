module ControlUnit (
    input [7:0] instruction, // Input instruction
    output reg [7:0] ALUOp,  
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    output reg Branch,
    output reg Jump,
    output reg [7:0] address // Assuming address is an 8-bit output
);
    wire [7:0] opcode; // Assuming 3-bit opcode based on your case statements

    // Extract the opcode from the instruction (adjust as needed)
    assign opcode = instruction[2:0]; // Assuming lower 3 bits are opcode

    always @(*) begin
        // Default values
        ALUOp = 4'b0000; // Change to 4 bits
        MemRead = 0;
        MemWrite = 0;
        RegWrite = 0;
        Branch = 0;
        Jump = 0;
        address = 8'b00000000; // Default address

        case (opcode)
            3'b000: begin // AND operation
                ALUOp = 4'b0000;  
                RegWrite = 1;
            end
            3'b001: begin // OR operation
                ALUOp = 4'b0001;  
                RegWrite = 1;
            end
            3'b010: begin // ADD operation
                ALUOp = 4'b0010;  
                RegWrite = 1;
            end
            3'b011: begin // SUB operation
                ALUOp = 4'b0011;  
                RegWrite = 1;
            end
            3'b100: begin // LD operation
                MemRead = 1;
                RegWrite = 1;
            end
            3'b101: begin // STORE operation
                MemWrite = 1;
                address = 8'b00000001; // Example, assume address is given
            end
            3'b110: begin // JMP operation
                Jump = 1;
            end
            default: begin
                ALUOp = 4'b0000;
                $display("Control Unit: Invalid operation");
            end
        endcase
    end
endmodule
