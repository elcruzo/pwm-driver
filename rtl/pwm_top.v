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

    always @(*) begin
        case (freq_sel)
            4'd0:  prescale = 16'd390;
            4'd1:  prescale = 16'd195;
            4'd2:  prescale = 16'd97;
            4'd3:  prescale = 16'd48;
            4'd4:  prescale = 16'd24;
            default: prescale = 16'd97;
        endcase
    end

    prescaler u_pre (
        .clk  (clk),
        .rst_n(rst_n),
        .div  (prescale),
        .tick (pwm_clk)
    );

endmodule
