module mmm #(
   parameter integer N = 32
) (
   input wire [N-1:0] a,
   input wire [N-1:0] b,
   input wire [N-1:0] n,
   output reg [N-1:0] y
);

reg [N:0] s [0:N];  
reg [N-1:0] q;      

integer i;

// begin loop
always @(*) begin
   s[0] = 0;
   for (i = 0; i < N; i = i + 1) begin
      // modify the code according to task 1 (b)
      s[i + 1] = (s[i] + ((a[i] ? {1'b0, b} : 0) + ((s[i] + (a[i] ? b : 0)) & 1 ? {1'b0, n} : 0))) >> 1;
      q[i] = (s[i] + (a[i] ? b : 0)) & 1;
   end
   if (s[N] >= n)
      y = s[N] - n;
   else
      y = s[N];
end

endmodule
