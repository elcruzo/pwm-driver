module prescaler (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [15:0] div,
    output reg         tick
);

    reg [15:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 16'd0;
            tick    <= 1'b0;
        end else begin
            if (counter >= div - 1) begin
                counter <= 16'd0;
                tick    <= 1'b1;
            end else begin
                counter <= counter + 1'b1;
                tick    <= 1'b0;
            end
        end
    end

endmodule
// prescaler for pwm frequency
// tick output for pwm channels
