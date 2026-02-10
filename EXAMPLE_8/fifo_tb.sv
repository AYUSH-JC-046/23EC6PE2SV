//------------------------------------------------------------------------------
// File        : fifo_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-02
// Module      : fifo_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for fifo. 
//------------------------------------------------------------------------------

module fifo_tb;
  bit clk = 0;
  always #5 clk = ~clk;
  
  fifo_if vif(clk);
  
  fifo dut(
    .clk(clk), 
    .wr(vif.wr), 
    .rd(vif.rd), 
    .din(vif.din), 
    .full(vif.full), 
    .empty(vif.empty)
  );
  
  covergroup cg_fifo @(posedge clk);
    cross_wr_full: cross vif.wr, vif.full;
  endgroup

  cg_fifo cg; 
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, fifo_tb);
    
   
    cg = new(); 
    
    vif.wr = 0; vif.rd = 0;
    @(posedge clk);         

    vif.wr = 1; 
    repeat(18) @(posedge clk); 
    
    vif.wr = 0;
    
    repeat(5) @(posedge clk); 
    
    $display("Coverage: %0.2f %%", cg.get_inst_coverage());
    $finish;
  end
endmodule
