module mme #(
    parameter integer N = 32
) (
    input wire clk,
    input wire rn,
    input wire start,
    input wire [N-1:0] m,
    input wire [N-1:0] e,
    input wire [N-1:0] n,
    input wire [N-1:0] k,
    output reg ready,
    output reg [N-1:0] y
);

    // State definitions
    parameter IDLE = 2'b00;
    parameter CALC = 2'b01;
    parameter DONE = 2'b10;

    reg [1:0] state;
    reg [N-1:0] base;
    reg [N-1:0] exponent;
    reg [N-1:0] modulus;
    reg [N-1:0] result;
    reg [N-1:0] key;

    always @(posedge clk or negedge rn) begin
        if (!rn) begin
            state <= IDLE;
            ready <= 0;
            y <= 0;
            base <= 0;
            exponent <= 0;
            modulus <= 0;
            result <= 0;
            key <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        base <= m % n;  // Initialize base to m % n
                        exponent <= e;  // Initialize exponent to e
                        modulus <= n;   // Initialize modulus to n
                        key <= k;       // Initialize key (not used in this context)
                        result <= 1;    // Initialize result to 1
                        ready <= 0;
                        state <= CALC;
                    end
                end

                CALC: begin
                    if (exponent != 0) begin
                        if (exponent[0] == 1'b1) begin
                            result <= (result * base) % modulus; // Multiply result by base and reduce modulo n
                        end
                        base <= (base * base) % modulus; // Square the base and reduce modulo n
                        exponent <= exponent >> 1; // Shift exponent to the right
                    end else begin
                        y <= result; // Assign final result to output y
                        ready <= 1; // Set ready signal to 1
                        state <= DONE;
                    end
                end

                DONE: begin
                    ready <= 1;
                    // Stay in DONE state until reset
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
