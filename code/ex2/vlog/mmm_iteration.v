// Single combinational iteration in the MMM algorithm.
//
module mmm_iteration #(
   parameter integer N = 32
) (
   input wire [N-1:0] a,
   input wire [N-1:0] b,
   input wire [N-1:0] n,
   input wire [N:0] s_ps,
   output wire [N:0] s_ns,
   output wire [N-1:0] y
);

// Internal nets
//
wire [N+1:0] p;
wire q;
wire [N+1:0] t;
wire [N:0] d;

// Single MMM Iteration
//
assign p = (s_ps + a[0]*b) % 2;
assign q = p[0];
assign t = (s_ps + q*n + a[0]*b) / 2;
assign d = ((s_ps >= n) ? (s_ps - n) : s_ps);

// Assign outputs
//
assign s_ns = t[N:0];
assign y = d[N-1:0];

endmodule