`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.12.2024 10:47:49
// Design Name: 
// Module Name: Top_level_design
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


module ASIC_DPLL(

    input wire clk_ref,            // Reference clock
    input wire clk,                // System clock
    output wire clk_out,           // Output synchronized clock
    output wire lock_status        // Lock status
);
    wire up, down;                 // Signals from PFD
    wire [15:0] loop_control;      // Filtered control signal
    wire [15:0] adaptive_control;  // Adaptive control signal

    // Instantiate Phase Frequency Detector
    Phase_Frequency_Detector PFD (
        .clk_ref(clk_ref),
        .clk_fb(clk_out),
        .up(up),
        .down(down)
    );

    // Instantiate Loop Filter
    Digital_Loop_filter LF (
        .up(up),
        .down(down),
        .control_out(loop_control)
    );

    // Instantiate Adaptive Bandwidth Controller
    Adaptive_bandwidth_control ABC (
        .lock_status(lock_status),
        .control_in(loop_control),
        .control_out(adaptive_control)
    );

    // Instantiate DCO
    DCO dco (
        .control(adaptive_control),
        .clk(clk),
        .clk_out(clk_out)
    );

    // Instantiate Lock Detector
    Lock_Detector LD (
        .clk_ref(clk_ref),
        .clk_fb(clk_out),
        .lock(lock_status)
    );
endmodule

