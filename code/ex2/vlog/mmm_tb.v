`timescale 1ns/1ns

// Testbench for MMM.
//
module mmm_tb;

// Local parameters
//
localparam integer N = 32;
localparam integer CLK_PULSE_WIDTH = 1;
localparam integer CLK_PERIOD = 2*CLK_PULSE_WIDTH;

// DUT Inputs
//
reg clk = 0;
reg rn = 1;
reg start = 0;
reg [N-1:0] a = 0;
reg [N-1:0] b = 0;
reg [N-1:0] n = 0;

// DUT Outputs
//
wire ready;
wire [N-1:0] y;

// Internal nets
reg [1:0] test_no = 0;

// Generate clk;
//
initial clk = 1'b1;
always #CLK_PULSE_WIDTH clk=~clk;

// DUT
//
mmm #(
   .N(N)
) u_dut (
   .clk(clk),
   .rn(rn),
   .start(start),
   .a(a),
   .b(b),
   .n(n),
   .ready(ready),
   .y(y)
);

// Testing
//
initial begin
   // Reset DUT
   rn <= 1'b0;
   #CLK_PERIOD;
   rn <= 1'b1;

   #(5*CLK_PERIOD);

   Test 1, Expected value: y = 32'h93817349
   //
   // Stimulus
   test_no <= test_no + 1;
   a <= 32'h01234567;
   b <= 32'h89abcdef;
   n <= 32'h93849ca7;
   start <= 1'b1;
   ready <= 1'b1;
   #CLK_PERIOD;
   start <= 1'b0;
   //
   // Check result
   wait(ready);
   #(CLK_PERIOD);
   $display("Test %D done. Actual: 0x%H, expected: 0x%H", test_no, y, 32'h93817349);

   // Test 2, Expected value: y = 32'h6551c2cd
   //
   // Stimulus
   test_no <= test_no + 1;
   a <= 32'h00112233;
   b <= 32'h44556677;
   n <= 32'h93849ca7;
   start <= 1'b1;
   #CLK_PERIOD;
   start <= 1'b0;
   ready <= 1'b1;
   //
   // Check result
   wait(ready);
   #(CLK_PERIOD);
   $display("Test %D done. Actual: 0x%H, expected: 0x%H", test_no, y, 32'h6551c2cd);

   // Halt simulation
   //
   #(4*CLK_PERIOD);
   $stop;
end


endmodule