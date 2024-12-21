module Adaptive_bandwidth_control (
    input wire lock_status,       // Lock signal
    input wire [15:0] control_in, // Control input from loop filter
    output reg [15:0] control_out // Output to DCO
);
    always @(*) begin
        if (lock_status)
            control_out = control_in >> 1; // Reduce bandwidth for fine-tuning
        else
            control_out = control_in << 1; // Increase bandwidth for faster acquisition
    end
endmodule
