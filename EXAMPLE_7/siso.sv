//------------------------------------------------------------------------------
// File        : siso.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-01-31
// Module      : siso
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Serial-In Serial-Out (SISO) shift register verification using
//               reference modeling and waveform dumping.
//------------------------------------------------------------------------------

module siso (
    input  logic clk,
    input  logic si,
    output logic so
);

    logic [3:0] q;

    assign so = q[3];

    always_ff @(posedge clk)
        q <= {q[2:0], si};

endmodule

