//------------------------------------------------------------------------------
// File        : siso_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-01-31
// Module      : siso_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for siso. 
//------------------------------------------------------------------------------

module siso_tb;

    logic clk = 0;
    logic si;
    logic so;

    // DUT instance
    siso dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Reference model
    logic [3:0] q_ref;

  
    covergroup cg_siso @(posedge clk);
        cp_si : coverpoint si;   // input toggles 0 and 1
        cp_so : coverpoint so;   // output toggles 0 and 1
        cross_si_so : cross cp_si, cp_so;
    endgroup

    cg_siso cg = new();

  
    initial begin
        $dumpfile("siso_tb.vcd");
        $dumpvars(0, siso_tb);
    end


    initial begin
        q_ref = 4'b0000;

        repeat (20) begin
            si = $urandom();
            q_ref = {q_ref[2:0], si};  
            @(posedge clk);
            #1;
            cg.sample();             
        end

        $display("Coverage = %0.2f%%", cg.get_inst_coverage());
        $finish;
    end

endmodule
