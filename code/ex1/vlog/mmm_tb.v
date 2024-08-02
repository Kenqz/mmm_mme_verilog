`timescale 1ns/1ns

module mmm_tb;

// Local parameters
//
localparam integer N = 32;

// DUT Inputs
//
reg [N-1:0] a = 0;
reg [N-1:0] b = 0;
reg [N-1:0] n = 0;

// DUT Outputs
//
wire [N-1:0] y;

// Internal nets
//
reg [1:0] test_no = 0;


// DUT
//
mmm #(
   .N(N)
) u_dut (
   .a(a),
   .b(b),
   .n(n),
   .y(y)
);

// Testing
//
initial begin
   // Test 1, Expected value: y = 32'h93817349
   
   //GTKWave dumpfile
   $dumpfile("mmm_tb.vcd"); // Waveform dump file
   $dumpvars(0, mmm_tb);    
   test_no <= test_no + 1;
   a <= 32'h01234567;
   b <= 32'h89abcdef;
   n <= 32'h93849ca7;

   #1;
   $display("Test %D done. Actual: 0x%H, expected: 0x%H", test_no, y, 32'h93817349);

   // Test 2, Expected value: y = 32'h6551c2cd
   //
   test_no <= test_no + 1;
   a <= 32'h00112233;
   b <= 32'h44556677;
   n <= 32'h93849ca7;

   #1;
   $display("Test %D done. Actual: 0x%H, expected: 0x%H", test_no, y, 32'h6551c2cd);

   // Halt simulation
   //
   $stop;
end

endmodule