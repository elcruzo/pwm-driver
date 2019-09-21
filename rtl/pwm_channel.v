module pwm_channel (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       enable,
    input  wire [7:0] duty,
    input  wire [7:0] dead_time,
    output reg        pwm_h,
    output reg        pwm_l
);

    reg [7:0] counter;
    reg       pwm_raw;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            counter <= 8'd0;
        else
            counter <= counter + 1'b1;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pwm_raw <= 1'b0;
        else if (enable)
            pwm_raw <= (counter < duty);
        else
            pwm_raw <= 1'b0;
    end

    assign pwm_h = pwm_raw;
    assign pwm_l = ~pwm_raw & enable;

endmodule
