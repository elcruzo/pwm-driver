\`timescale 1ns/1ps

module pwm_channel_tb;

    reg        clk;
    reg        rst_n;
    reg        enable;
    reg [7:0]  duty;
    reg [7:0]  dead_time;
    wire       pwm_h;
    wire       pwm_l;

    pwm_channel dut (
        .clk      (clk),
        .rst_n    (rst_n),
        .enable   (enable),
        .duty     (duty),
        .dead_time(dead_time),
        .pwm_h    (pwm_h),
        .pwm_l    (pwm_l)
    );

    initial clk = 0;
    always #5 clk = ~clk;

endmodule
