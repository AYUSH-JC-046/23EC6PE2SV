//------------------------------------------------------------------------------
// File        : fsm_101_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-02
// Module      : fsm_101_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for fsm to detect 101 sequence. 
//------------------------------------------------------------------------------

module fsm_101_tb;

    logic clk = 0;
    logic rst;
    logic in;
    logic out;

    // DUT instance
    fsm_101 dut (.*);
  
    always #5 clk = ~clk;

    // White-box functional coverage on internal state
    covergroup cg_fsm @(posedge clk);
        cp_state : coverpoint dut.state;
    endgroup

    cg_fsm cg = new();

    //VCD generation
    initial begin
        $dumpfile("fsm_101_tb.vcd");
        $dumpvars(0, fsm_101_tb);
    end

    // Stimulus
    initial begin
        rst = 1;
        in  = 0;
        #12;
        rst = 0;

        repeat (20) begin
            in = $urandom_range(0, 1);
            @(posedge clk);
            cg.sample();
        end

        $display("Coverage: %0.2f%%", cg.get_inst_coverage());
        $finish;
    end

endmodule
