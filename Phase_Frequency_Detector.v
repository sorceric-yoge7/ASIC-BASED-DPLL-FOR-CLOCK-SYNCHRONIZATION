module Phase_Frequency_Detector (
    input wire clk_ref,   // Reference clock
    input wire clk_fb,    // Feedback clock
    output reg up,        // Increment signal
    output reg down       // Decrement signal
);
    always @(*) begin
        up   = (clk_ref && !clk_fb);
        down = (clk_fb && !clk_ref);
    end
endmodule
