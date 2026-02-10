//------------------------------------------------------------------------------
// File        : fsm_101.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-02
// Module      : fsm_101
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : FSM verification example demonstrating white-box functional
//               coverage on internal state transitions with waveform dumping.
//------------------------------------------------------------------------------

module fsm_101 (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic out
);

    typedef enum logic [1:0] { S0, S1, S2 } state_t;
    state_t state, next;

    // State register
    always_ff @(posedge clk)
        state <= rst ? S0 : next;

    always_comb begin
        out  = 1'b0;
        next = state;

        case (state)
            S0: if (in) next = S1;
            S1: if (!in) next = S2;
                else     next = S1;
            S2: begin
                    if (in) begin
                        out  = 1'b1;   // detected 101
                        next = S1;
                    end else
                        next = S0;
                end
        endcase
    end

endmodule
