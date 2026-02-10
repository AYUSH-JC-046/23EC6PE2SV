//------------------------------------------------------------------------------
// File        : arbiter.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-03
// Module      : arbiter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Priority arbiter verified using an immediate assertion to ensure
//               at most one grant is asserted at any clock cycle.
//------------------------------------------------------------------------------

module arbiter (
    input  logic       clk,
    input  logic       rst,
    input  logic [3:0] req,
    output logic [3:0] gnt
);

    always_ff @(posedge clk) begin
        if (rst)
            gnt <= 4'b0000;
        else if (req[0])
            gnt <= 4'b0001;
        else if (req[1])
            gnt <= 4'b0010;
        else if (req[2])
            gnt <= 4'b0100;
        else if (req[3])
            gnt <= 4'b1000;
        else
            gnt <= 4'b0000;
    end

endmodule
