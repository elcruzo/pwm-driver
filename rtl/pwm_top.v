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

    reg [15:0] prescale;
    wire       pwm_clk;

    // Frequency selection (assuming 100MHz input clock)
    // freq_sel -> PWM frequency
    // 0 -> 1kHz,  1 -> 2kHz,  2 -> 4kHz
    // 3 -> 8kHz,  4 -> 16kHz, 5 -> 32kHz, 6 -> 64kHz
    always @(*) begin
        case (freq_sel)
            4'd0:    prescale = 16'd390;   // ~1kHz
            4'd1:    prescale = 16'd195;   // ~2kHz
            4'd2:    prescale = 16'd97;    // ~4kHz
            4'd3:    prescale = 16'd48;    // ~8kHz
            4'd4:    prescale = 16'd24;    // ~16kHz
            4'd5:    prescale = 16'd12;    // ~32kHz
            4'd6:    prescale = 16'd6;     // ~64kHz
            default: prescale = 16'd97;    // default 4kHz
        endcase
    end

    // Clock prescaler
    prescaler u_pre (
        .clk  (clk),
        .rst_n(rst_n),
        .div  (prescale),
        .tick (pwm_clk)
    );

    // Channel A - dual output with dead time
    pwm_channel u_ch_a (
        .clk      (pwm_clk),
        .rst_n    (rst_n),
        .enable   (enable),
        .duty     (duty_a),
        .dead_time(dead_time),
        .pwm_h    (pwm_a_h),
        .pwm_l    (pwm_a_l)
    );

    // Channel B - dual output with dead time
    pwm_channel u_ch_b (
        .clk      (pwm_clk),
        .rst_n    (rst_n),
        .enable   (enable),
        .duty     (duty_b),
        .dead_time(dead_time),
        .pwm_h    (pwm_b_h),
        .pwm_l    (pwm_b_l)
    );

endmodule
