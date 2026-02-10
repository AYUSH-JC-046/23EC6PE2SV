//------------------------------------------------------------------------------
// File        : counter.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-01-31
// Module      : counter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : 4-bit synchronous counter verification 
//               detection using functional coverage and waveform dumping.
//------------------------------------------------------------------------------

module counter (
    input  logic       clk,
    input  logic       rst,
    output logic [3:0] count
);

    always_ff @(posedge clk) begin
        if (rst)
            count <= 4'b0000;
        else
            count <= count + 1'b1;
    end

endmodule
