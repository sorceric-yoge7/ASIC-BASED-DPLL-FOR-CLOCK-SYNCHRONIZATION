module Digital_Loop_filter (
    input wire clk,                 // System clock
    input wire up,                  // UP signal
    input wire down,                // DOWN signal
    output reg [15:0] control_out   // Control output for DCO
);
    reg signed [15:0] proportional, integral, derivative;
    reg [15:0] prev_error;
    
    // Initialization (optional, but helps avoid issues)
    initial begin
        proportional = 0;
        integral = 0;
        derivative = 0;
        prev_error = 0;
    end

    always @(posedge clk) begin  // Use clk explicitly for synchronous operation
        // Compute proportional, integral, and derivative components
        proportional = (up ? 1 : 0) - (down ? 1 : 0);  // Proportional signal
        integral = integral + proportional;              // Integral component
        derivative = proportional - prev_error;          // Derivative component

        // Control output calculation (combining the components)
        control_out = (proportional << 1) + (integral >> 1) + (derivative >> 2);

        // Store the current proportional value for the next cycle
        prev_error = proportional;
    end
endmodule
