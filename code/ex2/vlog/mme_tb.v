`timescale 1ns/1ns

// Testbench for MME.
module mme_tb;

// Local parameters
localparam integer N = 32;
localparam integer CLK_PULSE_WIDTH = 1;
localparam integer CLK_PERIOD = 2*CLK_PULSE_WIDTH;

// DUT Inputs
reg clk = 0;
reg rn = 1;
reg start = 0;
reg [N-1:0] m = 0;
reg [N-1:0] e = 0;
reg [N-1:0] n = 0;
reg [N-1:0] k = 0;

// DUT Outputs
wire ready;
wire [N-1:0] y;

// Internal nets
reg [1:0] test_no = 0;

// Generate clk
initial clk = 1'b1;
always #CLK_PULSE_WIDTH clk=~clk;

// DUT
mme #(
    .N(N)
) u_dut (
    .clk(clk),
    .rn(rn),
    .start(start),
    .m(m),
    .e(e),
    .n(n),
    .k(k),
    .ready(ready),
    .y(y)
);

// Testing
initial begin
    // Reset DUT
    rn <= 1'b0;
    #CLK_PERIOD;
    rn <= 1'b1;

    #(5*CLK_PERIOD);

    // Test 1, Expected value: y = 32'h31a9137c
    // Stimulus
    test_no <= test_no + 1;
    m <= 32'h01234567;
    e <= 32'h89abcdef;
    n <= 32'h93849ca7;
    k <= 32'h8c8d9129;
    start <= 1'b1;
    #CLK_PERIOD;
    start <= 1'b0;
    // Check result
    #(32*CLK_PERIOD);
    $display("Test %d done. Actual: 0x%H, expected: 0x%H", test_no, y, 32'h31a9137c);

    // Test 2, Expected value: y = 32'h2490d130
    // Stimulus
    test_no <= test_no + 1;
    m <= 32'h00112233;
    e <= 32'h44556677;
    n <= 32'h93849ca7;
    k <= 32'h8c8d9129;
    start <= 1'b1;
    #CLK_PERIOD;
    start <= 1'b0;
    // Check result
    #(32*CLK_PERIOD);
    $display("Test %d done. Actual: 0x%H, expected: 0x%H", test_no, y, 32'h2490d130);

    // Halt simulation
    #(4*CLK_PERIOD);
    $stop;
end

endmodule
