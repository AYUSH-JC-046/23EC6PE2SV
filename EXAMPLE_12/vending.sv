// ----------------------------------------------------------------------------------
// File        : vending.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-08
// Module      : vending
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Vending Machine designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module vending (
    input  logic clk,
    input  logic rst,
    input  logic [4:0] coin,
    output logic dispense
);

    typedef enum logic [1:0] {IDLE, HAS5, HAS10} state_t;
    state_t state;

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            dispense <= 0;
        end 
        else begin
            dispense <= 0; // default

            case (state)
                IDLE: begin
                    if (coin == 5)      state <= HAS5;
                    else if (coin == 10) state <= HAS10;
                end

                HAS5: begin
                    if (coin == 10) begin
                        dispense <= 1;
                        state <= IDLE;
                    end
                    else if (coin == 5)
                        state <= HAS10;
                end

                HAS10: begin
                    if (coin == 5) begin
                        dispense <= 1;
                        state <= IDLE;
                    end
                    else if (coin == 10) begin
                        dispense <= 1; // extra change ignored
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

endmodule
