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
    reg [7:0] dead_cnt;
    reg       pwm_h_pre;
    reg       pwm_l_pre;

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

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pwm_h_pre <= 1'b0;
            pwm_l_pre <= 1'b0;
            pwm_h     <= 1'b0;
            pwm_l     <= 1'b0;
            dead_cnt  <= 8'd0;
        end else begin
            pwm_h_pre <= pwm_raw;
            pwm_l_pre <= ~pwm_raw & enable;

            if (pwm_h_pre != pwm_raw || pwm_l_pre != (~pwm_raw & enable)) begin
                dead_cnt <= dead_time;
                pwm_h    <= 1'b0;
                pwm_l    <= 1'b0;
            end else if (dead_cnt > 0) begin
                dead_cnt <= dead_cnt - 1'b1;
                pwm_h    <= 1'b0;
                pwm_l    <= 1'b0;
            end else begin
                pwm_h <= pwm_h_pre;
                pwm_l <= pwm_l_pre;
            end
        end
    end

endmodule
