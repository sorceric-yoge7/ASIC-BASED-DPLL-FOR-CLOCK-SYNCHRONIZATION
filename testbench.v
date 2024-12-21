`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.12.2024 11:32:38
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module tb_Lock_Detector;

    // Inputs
    reg clk_ref;
    reg clk_fb;

    // Outputs
    wire lock;

    // Instantiate the Lock_Detector module
    Lock_Detector uut (
        .clk_ref(clk_ref),
        .clk_fb(clk_fb),
        .lock(lock)
    );

    // Clock generation for clk_ref and clk_fb
    always begin
        #5 clk_ref = ~clk_ref;  // Toggle clk_ref every 5 ns (100 MHz clock)
    end

    always begin
        #7 clk_fb = ~clk_fb;  // Toggle clk_fb every 7 ns (approximately 85.7 MHz clock)
    end

    // Initial block to apply test vectors and monitor the output
    initial begin
        // Initialize inputs
        clk_ref = 0;
        clk_fb = 0;

        // Monitor output
        $monitor("Time: %0t | clk_ref: %b | clk_fb: %b | lock: %b", $time, clk_ref, clk_fb, lock);

        // Wait for a few clock cycles before applying different test cases
        #100;

        // Test case 1: Both clocks are in sync (clk_fb toggles at the same rate as clk_ref)
        $display("Test Case 1: Both clocks in sync");
        clk_fb = 0;  // Reset clk_fb to start
        #100;         // Wait for a few cycles to observe if lock goes high

        // Test case 2: Feedback clock out of sync (clk_fb runs at a different rate)
        $display("Test Case 2: Clocks out of sync");
        clk_fb = 0;  // Reset clk_fb
        #200;
        clk_fb = 1;  // Change clk_fb so it's out of sync with clk_ref
        #100;

        // Test case 3: Clocks back in sync after out of sync period
        $display("Test Case 3: Clocks back in sync");
        clk_fb = 0;  // Reset clk_fb to sync with clk_ref
        #100;

        // Finish simulation
        $finish;
    end

endmodule
