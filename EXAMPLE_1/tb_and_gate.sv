//------------------------------------------------------------------------------
// File        : tb_and_gate.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-01-24
// Module      : tb_and_gate
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for and_gate. Randomizes inputs and uses a
//               covergroup to measure input combination coverage.
//------------------------------------------------------------------------------

module tb_and_gate;

  logic a, b, y;

  and_gate dut (
    .a (a),
    .b (b),
    .y (y)
  );

  covergroup cg_and;
    cp_a    : coverpoint a;
    cp_b    : coverpoint b;
    cross_ab: cross cp_a, cp_b;
  endgroup

  cg_and cg = new();

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_and_gate);
  end

  initial begin
    repeat (20) begin
      a = $urandom_range(0, 1);
      b = $urandom_range(0, 1);
      #5;
      cg.sample();
    end

    $display("Final coverage = %0.2f%%", cg.get_inst_coverage());
    $finish;
  end

endmodule

