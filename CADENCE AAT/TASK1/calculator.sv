//------------------------------------------------------------------------------
// File        : calculator.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-02
// Module      : calculator
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Simple calculator design with enum logic
//------------------------------------------------------------------------------

module calculator (
  input  logic [7:0] a,
  input  logic [7:0] b,
  input  logic [2:0] opcode,
  output logic [7:0] result
);

  typedef enum logic [2:0] {
    ADD = 3'b000,
    SUB = 3'b001,
    MUL = 3'b010,
    XOR = 3'b011
  } opcode_t;

  always_comb begin
    case(opcode)
      ADD: result = a + b;
      SUB: result = a - b;
      MUL: result = a * b;
      XOR: result = a ^ b;
      default: result = 8'h00;
    endcase
  end

endmodule

