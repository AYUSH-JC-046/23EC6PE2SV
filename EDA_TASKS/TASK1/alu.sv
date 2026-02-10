//------------------------------------------------------------------------------
// File        : alu.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-06
// Module      : alu
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : 32 bit alu design with enum
//------------------------------------------------------------------------------


module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [1:0]  opcode,
    output logic [31:0] result
);

    always_comb begin
        case (opcode)
            2'b00: result = a + b;   // ADD
            2'b01: result = a - b;   // SUB
            2'b10: result = a * b;   // MUL
            2'b11: result = a ^ b;   // XOR
            default: result = 32'h0;
        endcase
    end

endmodule
