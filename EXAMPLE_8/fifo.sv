//------------------------------------------------------------------------------
// File        : fifo.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-02
// Module      : fifo
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Simple FIFO verification using an interface and functional
//               coverage to observe write attempts when the FIFO is full.
//------------------------------------------------------------------------------

module fifo(
  input clk, wr, rd,
  input [7:0] din,
  output logic full, empty
);
  
  logic [4:0] cnt = 0;
  
  assign full = (cnt == 16);
  assign empty = (cnt == 0);
  
  always_ff @(posedge clk) begin
    if (wr && !full && !rd) 
      cnt <= cnt + 1;
    else if (rd && !empty && !wr) 
      cnt <= cnt - 1;
  end
endmodule

interface fifo_if(input clk);
  logic wr, rd, full, empty; 
  logic [7:0] din;
endinterface
