//------------------------------------------------------------------------------
// File        : traffic.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-03
// Module      : traffic
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Traffic light controller verification demonstrating sequence
//               coverage for correct RED → GREEN → YELLOW → RED cycling.
//------------------------------------------------------------------------------

typedef enum logic [1:0] { RED, GREEN, YELLOW } light_t;

module traffic (
    input  logic   clk,
    input  logic   rst,
    output light_t color
);

    always_ff @(posedge clk) begin
        if (rst)
            color <= RED;
        else begin
            case (color)
                RED    : color <= GREEN;
                GREEN  : color <= YELLOW;
                YELLOW : color <= RED;
            endcase
        end
    end

endmodule
