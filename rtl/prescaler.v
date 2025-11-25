module prescaler (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [15:0] div,
    output reg         tick
);

    reg [15:0] counter;

    // Clock divider - generates tick pulse at configurable frequency
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 16'd0;
            tick    <= 1'b0;
        end else begin
            if (counter >= div - 16'd1) begin
                counter <= 16'd0;
                tick    <= 1'b1;
            end else begin
                counter <= counter + 16'd1;
                tick    <= 1'b0;
            end
        end
    end

endmodule
