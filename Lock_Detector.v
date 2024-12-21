module Lock_Detector(
    input wire clk_ref,   // Reference clock
    input wire clk_fb,    // Feedback clock
    output reg lock       // Lock status
);
    reg [7:0] phase_diff;
    reg [3:0] stable_count;
    reg prev_clk_ref, prev_clk_fb;

    // Initialize values
    initial begin
        prev_clk_ref = 0;
        prev_clk_fb = 0;
        stable_count = 0;
        lock = 0;
    end

    always @(posedge clk_ref) begin
        // Detect edge of both clocks to calculate phase difference
        if (prev_clk_ref == 1'b0 && clk_ref == 1'b1 && prev_clk_fb == clk_fb) begin
            // Both clocks are in sync
            stable_count <= stable_count + 1;
        end else begin
            // Reset the stable count if clocks are not in sync
            stable_count <= 0;
        end

        // Lock condition: if stable count reaches a threshold (8 in this case)
        if (stable_count >= 8) begin
            lock <= 1'b1;
        end else begin
            lock <= 1'b0;
        end

        // Store the previous clock values for edge detection
        prev_clk_ref <= clk_ref;
        prev_clk_fb <= clk_fb;
    end
endmodule
