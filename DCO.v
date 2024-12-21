module DCO (
    input wire [15:0] control, // Frequency control word
    input wire clk,            // System clock
    output reg clk_out         // Generated clock
);
    reg [31:0] phase_accumulator;

    always @(posedge clk) begin
        phase_accumulator <= phase_accumulator + control;
        clk_out <= phase_accumulator[31]; // MSB as output clock
    end
endmodule
