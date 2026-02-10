//------------------------------------------------------------------------------
// File        : alu_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-01-27
// Module      : alu_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for ALU. 
//------------------------------------------------------------------------------

module tb;

    logic   [7:0] a, b, y;
    opcode_e      op;

    // DUT instance
    alu dut (.*);

    // Coverage: ALU operations
    covergroup cg_alu;
        cp_op : coverpoint op;   // Tracks ADD, SUB, AND, OR
    endgroup

    cg_alu cg = new();

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        repeat (50) begin
            a  = $urandom();
            b  = $urandom();
            op = opcode_e'($urandom_range(0, 3)); // Random enum

            #5;
            cg.sample();
        end

        $display("Coverage: %0.2f%%", cg.get_inst_coverage());
        $finish;
    end

endmodule
