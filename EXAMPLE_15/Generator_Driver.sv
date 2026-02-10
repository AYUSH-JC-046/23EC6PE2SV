// ----------------------------------------------------------------------------------
// File        : Generator_Driver.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-08
// Module      : tb_generator_driver
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for Generator Driver. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
class Packet;
    rand bit [7:0] val;
endclass


module tb;

    mailbox #(Packet) mbx = new();

    bit [7:0] val_samp;

   
    covergroup pkt_cg;
        cp_val : coverpoint val_samp {
            bins low  = {[0:85]};
            bins mid  = {[86:170]};
            bins high = {[171:255]};
        }
    endgroup

    pkt_cg cg_inst = new();


    task generator();
        Packet p;
        repeat (5) begin
            p = new();
            p.randomize();
            mbx.put(p);   // Put into mailbox
            #5;
        end
    endtask

 
    task driver();
        Packet p;
        repeat (5) begin
            mbx.get(p);   // Get from mailbox
            val_samp = p.val;   // sample for coverage
            $display("Driver got : %0d", p.val);
            cg_inst.sample();
            #5;
        end
    endtask

  
    initial begin
        fork
            generator();
            driver();
        join

        $display("\n========== MAILBOX COVERAGE ==========");
        $display("Total Coverage = %0.2f %%", cg_inst.get_coverage());
        $display("======================================\n");

        #10;
        $finish;
    end

   
    initial begin
        $dumpfile("mailbox.vcd");
        $dumpvars(0, tb);
    end

endmodule
