//------------------------------------------------------------------------------
// File        : mux2to1.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-01-25
// Module      : mux2to1
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : 2to1 MUX used for basic functional coverage example.
//------------------------------------------------------------------------------

module mux2to1 (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  logic       sel,
    output logic [7:0] y
);
    assign y = sel ? b : a;
endmodule
