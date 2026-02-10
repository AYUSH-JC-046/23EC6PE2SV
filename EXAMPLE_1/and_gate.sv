//------------------------------------------------------------------------------
// File        : and_gate.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-01-24
// Module      : and_gate
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : 2‑input AND gate used for basic functional coverage example.
//------------------------------------------------------------------------------

module and_gate (
    input  logic a,
    input  logic b,
    output logic y
);
    assign y = a & b;
endmodule
