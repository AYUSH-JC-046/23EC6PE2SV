//------------------------------------------------------------------------------
// File        : mux_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-01-25
// Module      : mux_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Simple testbench for mux2to1. 
//------------------------------------------------------------------------------

class Transaction;
    rand bit [7:0] a, b;
    rand bit       sel;
endclass


module mux_tb;

    logic [7:0] a, b, y;
    logic       sel;

    // DUT instance
    mux2to1 dut (.*);

    // Coverage
    covergroup cg_mux;
        cp_sel : coverpoint sel;
    endgroup

    cg_mux      cg = new();
    Transaction tr = new();


    initial begin
        $dumpfile("mux_tb.vcd");   
      $dumpvars(0, mux_tb);         
    end

    initial begin
        repeat (20) begin
            tr.randomize();        
            a   = tr.a;
            b   = tr.b;
            sel = tr.sel;

            #5;
            cg.sample();

            // Self-check
            if (y !== (sel ? b : a))
                $error("Mismatch!");
        end

        $display("Coverage = %0.2f%%", cg.get_inst_coverage());
        $finish;
    end

endmodule

