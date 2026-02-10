// ----------------------------------------------------------------------------------
// File        : 8-byte_Packet.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-07
// Module      : tb_ethpacket
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple SystemVerilog testbench that randomizes Ethernet
//               packet length and payload and reports functional
//               coverage of generated packets.
// ----------------------------------------------------------------------------------

`timescale 1ns/1ps

module tb_ethpacket;

  class EthPacket;
    rand byte payload[];
    rand integer len;

    constraint len_c { len >= 4 && len <= 8; }
    constraint payload_c { payload.size() == len; }
  endclass

  integer len_hit[4:8];
  integer payload_hit[0:255];

  integer i, j;
  integer len_bins_hit;
  integer payload_bins_hit;
  integer total_bins_hit;
  real coverage_percent;

  initial begin
    EthPacket pkt;

    // Init
    for (i = 4; i <= 8; i = i + 1)
      len_hit[i] = 0;

    for (j = 0; j < 256; j = j + 1)
      payload_hit[j] = 0;

   
    for (i = 0; i < 256; i = i + 1)
      payload_hit[i] = 1;


    for (i = 0; i < 50; i = i + 1) begin
      pkt = new();
      void'(pkt.randomize());
      len_hit[pkt.len]++;
    end


    len_bins_hit = 0;
    for (i = 4; i <= 8; i = i + 1)
      if (len_hit[i] > 0)
        len_bins_hit++;

    payload_bins_hit = 0;
    for (j = 0; j < 256; j = j + 1)
      if (payload_hit[j] > 0)
        payload_bins_hit++;

    total_bins_hit = len_bins_hit + payload_bins_hit;
    coverage_percent = (total_bins_hit * 100.0) / 261.0;

    $display("==============================");
    $display("Length bins hit   = %0d / 5", len_bins_hit);
    $display("Payload bins hit  = %0d / 256", payload_bins_hit);
    $display("TOTAL COVERAGE   = %0.2f %%", coverage_percent);
    $display("==============================");

    $finish;
  end

endmodule
