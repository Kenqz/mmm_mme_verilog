/// Control module in a sequential MMM implementation.
//
module mmm_control #(
   parameter integer N = 32
) (
   input wire clk,
   input wire rn,
   input wire start,
   output wire active, // modify the output wire to match
   output wire ready
);

// Local parameters
//
localparam integer CNT_SIZE = $clog2(N);

// Internal nets
//
reg [CNT_SIZE-1:0] cnt;
wire done;
reg i_active;
reg i_ready;

// Define counter
//
always @(posedge clk, negedge rn) begin
   if (!rn) cnt <= 0;
   else if (start) cnt <= 0;
   else if (active) cnt <= cnt + 1;
end
//
assign done = (cnt == (N-1));

// Define active signal
//
always @(posedge clk, negedge rn) begin
   if (!rn) i_active <= 1'b0;
   else if (start) i_active <= 1'b1;
   else if (done) i_active <= 1'b0;
end
//
assign active = i_active;

// Define ready signal
always @(posedge clk, negedge rn) begin
   if (!rn) i_ready <= 1'b0;
   else i_ready <= done;
end
//
assign ready = i_ready;

endmodule
