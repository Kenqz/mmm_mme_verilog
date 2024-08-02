module mme_control #(
    parameter integer N = 32
) (
    input wire clk,
    input wire rst,
    input wire start,
    input wire ready_MMM,
    input wire [N-1:0] c_MMM,
    input wire [N-1:0] e_log,
    output reg ready_out,
    output reg start_MMM,
    output reg [N-1:0] a_MMM,
    output reg [N-1:0] b_MMM
);

    parameter IDLE = 2'b00;
    parameter SUBSTEP_0 = 2'b01;
    parameter SUBSTEP_1 = 2'b10;

    reg [N-1:0] cnt;
    reg [1:0] state;
    reg [N-1:0] m_reg;
    reg [N-1:0] r_reg;
    reg [N-1:0] e_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= 0;
            state <= IDLE;
            ready_out <= 0;
            start_MMM <= 0;
            m_reg <= 0; // If m_reg needs to be initialized to a specific value, set it here.
            r_reg <= 1;
            e_reg <= 0;
            a_MMM <= 0;
            b_MMM <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        e_reg <= e_log;
                        cnt <= 0;
                        ready_out <= 0;
                        start_MMM <= 0;
                        m_reg <= c_MMM; // Initializing m_reg with input value
                        state <= SUBSTEP_0;
                    end
                end

                SUBSTEP_0: begin
                    if (cnt < N) begin
                        if (cnt == 0) begin
                            a_MMM <= r_reg;
                            b_MMM <= m_reg;
                        end else begin
                            a_MMM <= r_reg;
                            b_MMM <= e_reg[0] ? m_reg : r_reg;
                        end
                        start_MMM <= 1;
                        state <= SUBSTEP_1;
                    end else begin
                        ready_out <= 1;
                        state <= IDLE;
                    end
                end

                SUBSTEP_1: begin
                    if (ready_MMM) begin
                        start_MMM <= 0;
                        if (e_reg[0]) begin
                            r_reg <= c_MMM;
                        end
                        e_reg <= e_reg >> 1;
                        cnt <= cnt + 1;
                        state <= SUBSTEP_0;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
