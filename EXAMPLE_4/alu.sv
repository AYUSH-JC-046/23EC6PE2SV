//------------------------------------------------------------------------------
// File        : alu.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-01-27
// Module      : alu
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple ALU verification example demonstrating enum-based operations 
//------------------------------------------------------------------------------

typedef enum bit [1:0] { ADD, SUB, AND, OR } opcode_e;

module alu (
    input  logic   [7:0] a,
    input  logic   [7:0] b,
    input  opcode_e      op,
    output logic   [7:0] y
);

    always_comb begin
        case (op)
            ADD: y = a + b;
            SUB: y = a - b;
            AND: y = a & b;
            OR : y = a | b;
            default: y = 8'h00;
        endcase
    end

endmodule
