//------------------------------------------------------------------------------
// File        : counter_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-01-31
// Module      : counter_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for counter. 
//------------------------------------------------------------------------------

module counter_tb;

    logic       clk = 0;
    logic       rst;
    logic [3:0] count;

    // DUT instance
    counter dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Coverage: counter behavior
    covergroup cg_count @(posedge clk);
        cp_val : coverpoint count {
            bins zero = {4'd0};
            bins max  = {4'd15};
            bins roll = (4'd15 => 4'd0); // rollover check
        }
    endgroup

    cg_count cg = new();

  	initial begin
        $dumpfile("counter_tb.vcd");
      $dumpvars(0, counter_tb);
    end
  
   initial begin
    rst = 1;
    #20;
    rst = 0;

    repeat (40) @(posedge clk);

    $display("Coverage = %0.2f%%", cg.get_inst_coverage());
    $finish;
end
  
endmodule
