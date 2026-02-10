//------------------------------------------------------------------------------
// File        : dff_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-01-29
// Module      : dff_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for DFF. 
//------------------------------------------------------------------------------

class packet;
    rand bit d, rst;

   
    constraint c1 {
        rst dist {0 := 90, 1 := 10};
    }
endclass


module tb;

    logic clk = 0;
    logic rst, d, q;

    // DUT instance
    dff dut (.*);

    // Clock generation
    always #5 clk = ~clk;

   
    covergroup cg @(posedge clk);
        cross_rst_d : cross rst, d;
    endgroup

    cg      cinst = new();
    packet pkt   = new();

    
    initial begin
        $dumpfile("dff_tb.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        repeat (100) begin
            pkt.randomize();
            rst <= pkt.rst;
            d   <= pkt.d;
            @(posedge clk);
        end

        $display("Coverage: %0.2f%%", cinst.get_inst_coverage());
        $finish;
    end

endmodule
