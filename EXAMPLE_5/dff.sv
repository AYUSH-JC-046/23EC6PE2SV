//------------------------------------------------------------------------------
// File        : dff.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-01-29
// Module      : dff
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : D flip-flop verification using constrained random stimulus
//               and cross functional coverage with waveform dumping.
//------------------------------------------------------------------------------

module dff (
    input  logic clk,
    input  logic rst,
    input  logic d,
    output logic q
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule
