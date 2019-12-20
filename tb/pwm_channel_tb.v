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

    initial begin
        rst_n     = 0;
        enable    = 0;
        duty      = 0;
        dead_time = 8'd4;
        #100;
        rst_n = 1;
        #100;

        enable = 1;
        duty   = 8'd128;
        #50000;

        duty = 8'd64;
        #50000;

        duty = 8'd192;
        #50000;

        enable = 0;
        #10000;

        \$finish;
    end

endmodule

// waveform output
        // test 100% duty
