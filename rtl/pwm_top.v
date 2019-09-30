module pwm_top (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        enable,
    input  wire [7:0]  duty_a,
    input  wire [7:0]  duty_b,
    input  wire [7:0]  dead_time,
    input  wire [3:0]  freq_sel,
    output wire        pwm_a_h,
    output wire        pwm_a_l,
    output wire        pwm_b_h,
    output wire        pwm_b_l
);

endmodule
