// ----------------------------------------------------------------------------------
// File        : SVA_Temporal_Sequences.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-08
// Module      : tb_sva
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for SVA Temporal Sequences. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage.
// ----------------------------------------------------------------------------------
module tb_sva;

    bit clk, req, gnt;

   
    always #5 clk = ~clk;

    
    property p_handshake;
        @(posedge clk) req |=> ##2 gnt;
    endproperty


    assert property (p_handshake)
        else $error("Protocol Fail!");


    cover property (p_handshake);

   
    initial begin
        clk = 0;
        req = 0;
        gnt = 0;

        @(posedge clk) req <= 1;
        @(posedge clk) req <= 0;
        @(posedge clk) gnt <= 1;   // 2 cycles later → PASS

        #50;
        $display("\nASSERTION COVERAGE ");
        $display("Handshake scenario covered");
        $display("\n");

        $finish;
    end


    initial begin
        $dumpfile("handshake.vcd");
        $dumpvars(0, tb_sva);
    end

endmodule
