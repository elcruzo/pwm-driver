module pwm_channel (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       enable,
    input  wire [7:0] duty,
    output reg        pwm_out
);

    assign pwm_out = 1'b0;

endmodule
