//------------------------------------------------------------------------------
// File        : priority_enc.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-01-25
// Module      : priority_enc
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Priority encoder used as a basic example to demonstrate
//               functional coverage using covergroups in SystemVerilog.
//------------------------------------------------------------------------------

module priority_enc (
    input  logic [3:0] in,
    output logic [1:0] out,
    output logic       valid
);

    always_comb begin
        valid = 1'b1;

        if (in[3])
            out = 2'b11;
        else if (in[2])
            out = 2'b10;
        else if (in[1])
            out = 2'b01;
        else if (in[0])
            out = 2'b00;
        else begin
            out   = 2'b00;
            valid = 1'b0;
        end
    end

endmodule

