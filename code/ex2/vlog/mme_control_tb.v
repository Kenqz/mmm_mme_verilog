`timescale 1ns/1ns

module mme_control_tb;

    // Local parameters
    localparam integer N = 32;
    localparam integer CLK_PERIOD = 10;

    // DUT Inputs
    reg clk = 0;
    reg rst = 0;
    reg start = 0;
    reg ready_MMM = 0;
    reg [N-1:0] c_MMM = 0;
    reg [N-1:0] e_log = 0;

    // DUT Outputs
    wire ready_out;
    wire start_MMM;
    wire [N-1:0] a_MMM;
    wire [N-1:0] b_MMM;

    // Generate clk
    always #(CLK_PERIOD / 2) clk = ~clk;

    // DUT
    mme_control #(
        .N(N)
    ) u_dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .ready_MMM(ready_MMM),
        .c_MMM(c_MMM),
        .e_log(e_log),
        .ready_out(ready_out),
        .start_MMM(start_MMM),
        .a_MMM(a_MMM),
        .b_MMM(b_MMM)
    );

    // Test sequence
    initial begin
        // dumpfile for GTKWave
        $dumpfile("mme_control_tb.vcd");
        $dumpvars(0, mme_control_tb);


        rst <= 1;
        #(2 * CLK_PERIOD);
        rst <= 0;

        
        #(5 * CLK_PERIOD);

        // Test 1
        e_log <= 32'h12345678;
        start <= 1;
        #(CLK_PERIOD);
        start <= 0;
        
        // Provide ready_MMM signal and c_MMM value after start_MMM is set
        #(10 * CLK_PERIOD);
        ready_MMM <= 1;
        c_MMM <= 32'h87654321;
        #(CLK_PERIOD);
        ready_MMM <= 0;
        #(10 * CLK_PERIOD);

        // Test 2
        e_log <= 32'h9abcdef0;
        start <= 1;
        #(CLK_PERIOD);
        start <= 0;

        #(10 * CLK_PERIOD);
        ready_MMM <= 1;
        c_MMM <= 32'h0fedcba9;
        #(CLK_PERIOD);
        ready_MMM <= 0;
        #(10 * CLK_PERIOD);

        // End simulation
        #(10 * CLK_PERIOD);
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("At time %t: start=%b, ready_out=%b, start_MMM=%b, a_MMM=0x%H, b_MMM=0x%H, e_log=0x%H, r_reg=0x%H, state=%b",
                 $time, start, ready_out, start_MMM, a_MMM, b_MMM, e_log, u_dut.r_reg, u_dut.state);
    end

endmodule
