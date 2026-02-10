//------------------------------------------------------------------------------
// File        : arbiter_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-03
// Module      : arbiter_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for arbiter. 
//------------------------------------------------------------------------------

module arbiter_tb;

    logic clk = 0;
    logic rst;
    logic [3:0] req;
    logic [3:0] gnt;

    // DUT
    arbiter dut (.*);

   
    always #5 clk = ~clk;

    initial begin
        $dumpfile("arbiter_tb.vcd");
        $dumpvars(0, arbiter_tb);
    end

    covergroup cg @(posedge clk);

        cp_req : coverpoint req {
            bins none   = {4'b0000};
            bins r0     = {4'b0001};
            bins r1     = {4'b0010};
            bins r2     = {4'b0100};
            bins r3     = {4'b1000};
            bins multi  = {[4'b0011:4'b1111]};
        }

        cp_gnt : coverpoint gnt {
            bins none = {4'b0000};
            bins g0   = {4'b0001};
            bins g1   = {4'b0010};
            bins g2   = {4'b0100};
            bins g3   = {4'b1000};
        }

        cross_req_gnt : cross cp_req, cp_gnt;

    endgroup

    cg cg_inst = new();


    always @(posedge clk) begin
        assert ($onehot0(gnt))
        else $error("Protocol Violation: Multiple Grants!");
    end


    initial begin
        rst = 1;
        req = 4'b0000;
        #12;

        rst = 0;

        // No request
        req = 4'b0000; #20;

        // Single requests
        req = 4'b0001; #20;
        req = 4'b0010; #20;
        req = 4'b0100; #20;
        req = 4'b1000; #20;

        // Multiple requests
        req = 4'b0011; #20;
        req = 4'b0110; #20;
        req = 4'b1100; #20;
        req = 4'b1111; #20;
      
        $display("ARB Coverage = %0.2f%%", cg_inst.get_inst_coverage());

        $finish;
    end

endmodule
