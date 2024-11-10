module memory (
    input wire clk,
    input wire MemRead,          // Control signal for memory read
    input wire MemWrite,         // Control signal for memory write
    input wire [7:0] address,    // Memory address
    input wire [7:0] data_in,    // Data to write to memory
    output reg [7:0] data_out    // Data read from memory
);
    reg [7:0] mem [0:255];       // 256 bytes of memory

    always @(posedge clk) begin
        if (MemWrite) begin
            mem[address] <= data_in; // Write data to memory if MemWrite is high
        end
        if (MemRead) begin
            data_out <= mem[address]; // Read data from memory if MemRead is high
        end
    end
endmodule