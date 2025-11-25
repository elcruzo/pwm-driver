`timescale 1ns/1ps

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

    // 100MHz clock (10ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    // Waveform dump for viewing
    initial begin
        $dumpfile("pwm_channel_tb.vcd");
        $dumpvars(0, pwm_channel_tb);
    end

    // Test sequence
    initial begin
        // Initialize
        rst_n     = 0;
        enable    = 0;
        duty      = 0;
        dead_time = 8'd4;  // 4 clock cycles dead time
        
        // Release reset
        #100;
        rst_n = 1;
        #100;

        // Test 50% duty cycle
        enable = 1;
        duty   = 8'd128;
        #50000;

        // Test 25% duty cycle
        duty = 8'd64;
        #50000;

        // Test 75% duty cycle
        duty = 8'd192;
        #50000;

        // Test 100% duty cycle
        duty = 8'd255;
        #50000;

        // Test 0% duty cycle
        duty = 8'd0;
        #50000;

        // Test enable/disable
        enable = 0;
        #10000;

        $finish;
    end

    // Monitor for shoot-through (both outputs high simultaneously)
    always @(posedge clk) begin
        if (pwm_h && pwm_l) begin
            $display("ERROR: Shoot-through detected at time %t", $time);
        end
    end

endmodule
