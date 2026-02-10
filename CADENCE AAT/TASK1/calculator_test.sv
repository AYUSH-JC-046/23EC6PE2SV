//------------------------------------------------------------------------------
// File        : calculator_test.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-02
// Module      : calculator_test
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Simple calculator design with enum logic
//------------------------------------------------------------------------------
typedef enum logic [2:0] {
  ADD = 3'b000,
  SUB = 3'b001,
  MUL = 3'b010,
  XOR = 3'b011
} opcode_t;

class calc_trans;

  rand logic [7:0] a;
  rand logic [7:0] b;
  rand opcode_t opcode;

  constraint mul_weight {
    opcode dist {
      ADD := 25,
      SUB := 25,
      MUL := 20,
      XOR := 30
    };
  }

endclass


module calculator_test (calculator_inter intf);   

  calc_trans tr;

  covergroup cg;
    coverpoint intf.opcode {
      bins add = {ADD};
      bins sub = {SUB};
      bins mul = {MUL};
      bins xor1 = {XOR};
    }
  endgroup

  cg cov = new();

 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, calculator_top);
  end

  initial begin
    tr = new();

    repeat (100) begin
      tr.randomize();

      intf.a      = tr.a;
      intf.b      = tr.b;
      intf.opcode = tr.opcode;

      #5;
      cov.sample();
    end

    $display("Coverage = %.2f %%", cov.get_coverage());
    $finish;
  end

endmodule

