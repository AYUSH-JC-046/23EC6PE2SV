//------------------------------------------------------------------------------
// File        : priority_enc_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-01-25
// Module      : priority_enc_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for priority encoder. 
//------------------------------------------------------------------------------

module priority_enc_tb;

    logic [3:0] in;
    logic [1:0] out;
    logic       valid;

    // DUT instance
    priority_enc dut (.*);

    // Coverage: input patterns
    covergroup cg_enc;
        cp_in : coverpoint in {
            bins b0     = {4'b0001}; // 1
            bins b1     = {4'b0010}; // 2
            bins b2     = {4'b0100}; // 4
            bins b3     = {4'b1000}; // 8
            bins others = default;
        }
    endgroup

    cg_enc cg = new();

    initial begin
        $dumpfile("priority_enc_tb.vcd");
        $dumpvars(0, priority_enc_tb);
    end

    initial begin
        repeat (50) begin
            in = $urandom_range(0, 15);
            #5;
            cg.sample();
        end

        $display("Coverage: %0.2f%%", cg.get_inst_coverage());
        $finish;
    end

endmodule

