// Sequential Montgomery Modular Multiplication.
// One iteration in the MMM algorithm is executed per clock cycle.
//
module mmm #(
   parameter integer N = 32
) (
   input wire clk,
   input wire rn,
   input wire start,
   input wire [N-1:0] a,
   input wire [N-1:0] b,
   input wire [N-1:0] n,
   output wire ready,
   output wire [N-1:0] y
);

// Internal nets
//
wire active;
reg [N-1:0] a_reg;
reg [N-1:0] b_reg;
reg [N:0] s_reg;
wire [N:0] mmm_s_ns;

// Control unit for active and ready signal
//
mmm_control #(
   .N(N)
) u_ctrl (
   .clk(clk),
   .rn(rn),
   .start(start),
   .active(active),
   .ready(ready)
);

// Computes the result of a single iteration in the MMM algorithm
//
mmm_iteration #(
   .N(N)
) u_it (
   .a(a_reg),
   .b(b_reg),
   .n(n),
   .s_ps(s_reg),
   .s_ns(mmm_s_ns),
   .y(y)
);

// Control for a_reg
//
always @(posedge clk, negedge rn) begin
   if (!rn) a_reg <= 0;
   else if (start) a_reg <= a;
   else if (active) a_reg <= a_reg >> 1;
end

// Control for b_reg
//
always @(posedge clk, negedge rn) begin
   if (!rn) b_reg <= 0;
   else if (start) b_reg <= b;
end

// Control for s_reg
//
always @(posedge clk, negedge rn) begin
   if (!rn) s_reg <= 0;
   else if (start) s_reg <= 0;
   else if (active) s_reg <= mmm_s_ns;
end

endmodule