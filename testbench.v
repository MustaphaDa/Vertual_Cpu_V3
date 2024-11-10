module testbench;
    reg clk;                    
    reg reset;                  
    reg [7:0] instruction;     
    reg [7:0] data_in_a;       
    reg [7:0] data_in_b;       
    wire [7:0] result;        
    wire zero, carry, negative;

    // Instantiate CPU
    CPU my_cpu (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .data_in_a(data_in_a), 
        .data_in_b(data_in_b),
        .result(result),
        .zero(zero),
        .carry(carry),
        .negative(negative)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Generate VCD file for waveform viewing
    // Test sequence
    initial begin
    $dumpfile("cpu_wave.vcd"); // Name of the VCD file
    $dumpvars(0, testbench); // Dump all variables in the testbench scope

    reset = 1;
    instruction = 8'b0;
    data_in_a = 8'b1;
    data_in_b = 8'b1;
    
    #20; // Wait for 20 time units
    reset = 0; // Release reset
    #10; // Wait for 10 more time units

    // Example: Test ADD operation
    instruction = 8'b00000010; // ADD opcode
    data_in_a = 8'b00000101; // Operand A (5)
    data_in_b = 8'b00000011; // Operand B (3)
    #20; // Wait for the operation to complete

    $display("ADD Operation - Result: %b, Zero: %b, Carry: %b, Negative: %b", result, zero, carry, negative);

    // Stop simulation
    #10;
    $finish;
    end


    // Test sequence

    // Test sequence
    initial begin
        reset = 1;
        instruction = 8'b0;
        data_in_a = 8'b0;
        data_in_b = 8'b0;
        
        #20; // Wait for 20 time units
        reset = 0; // Release reset
        #10; // Wait for 10 more time units

        // Test AND operation
        instruction = 8'b00000000; // AND opcode
        data_in_a = 8'b11001100; // Operand A
        data_in_b = 8'b10101010; // Operand B
        #20; // Wait for operation to complete
        $display("AND Operation - Result: %b, Zero: %b, Carry: %b, Negative: %b", result, zero, carry, negative);

        // Test OR operation
        instruction = 8'b00000001; // OR opcode
        data_in_a = 8'b11001100; // Operand A
        data_in_b = 8'b10101010; // Operand B
        #20;
        $display("OR Operation - Result: %b, Zero: %b, Carry: %b, Negative: %b", result, zero, carry, negative);

        // Test ADD operation
        instruction = 8'b00000010; // ADD opcode
        data_in_a = 8'b00001111; // Operand A
        data_in_b = 8'b00000001; // Operand B
        #20;
        $display("ADD Operation - Result: %b, Zero: %b, Carry: %b, Negative: %b", result, zero, carry, negative);

        // Test SUB operation
        instruction = 8'b00000011; // SUB opcode
        data_in_a = 8'b00001111; // Operand A
        data_in_b = 8'b00000001; // Operand B
        #20;
        $display("SUB Operation - Result: %b, Zero: %b, Carry: %b, Negative: %b", result, zero, carry, negative);

        // Test LD operation (Memory Read)
        instruction = 8'b00000100; // LD opcode
        data_in_a = 8'b00000001; // Assume address 1
        #20; 
        $display("LD Operation - Result: %b, Zero: %b, Carry: %b, Negative: %b", result, zero, carry, negative);

        // Test STORE operation (Memory Write)
        instruction = 8'b00000101; // STORE opcode
        data_in_a = 8'b00000010; // Assume address 1
        data_in_b = 8'b11110000; // Data to store
        #20; 
        $display("STORE Operation - Memory written to address 1 with data: %b", data_in_b);

        // Test JMP operation (Jump)
        instruction = 8'b00000110; // JMP opcode
        #20; 
        $display("JMP Operation - Jump executed");

        // Finish the simulation
        #20; 
        $finish;
    end
endmodule
