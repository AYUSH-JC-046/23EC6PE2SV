// ----------------------------------------------------------------------------------
// File        : Polymorphism.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-08
// Module      : tb_oop
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for OOP Polymorphism. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage.
// ----------------------------------------------------------------------------------
class Packet;
    rand bit [7:0] data;

    virtual function void print();
        $display("Normal : %h", data);
    endfunction
endclass


class BadPacket extends Packet;

    virtual function void print();
        $display("ERROR  : %h", data);
    endfunction
endclass


module tb_oop;

    Packet    p;
    BadPacket bad;

    bit [7:0] data_samp;

 
    covergroup pkt_cg;
        cp_data : coverpoint data_samp {
            bins low  = {[0:85]};
            bins mid  = {[86:170]};
            bins high = {[171:255]};
        }
    endgroup

    pkt_cg cg_inst = new();


    initial begin
        bad = new();
        p   = bad;        

        repeat (10) begin
            p.randomize();
            data_samp = p.data;   
            p.print();
            cg_inst.sample();
            #5;
        end

        $display("\n========== PACKET COVERAGE ==========");
        $display("Total Coverage = %0.2f %%", cg_inst.get_coverage());
        $display("=====================================\n");

        #10;
        $finish;
    end

    initial begin
        $dumpfile("packet.vcd");
        $dumpvars(0, tb_oop);
    end

endmodule
