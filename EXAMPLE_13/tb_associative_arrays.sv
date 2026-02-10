// ----------------------------------------------------------------------------------
// File        : tb_associative_arrays.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-08
// Module      : tb_associative_arrays
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for Associative Arrays. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
`timescale 1ns/1ps

module tb;

    int mem[int];
    int addr;


    covergroup mem_cg;
        cp_addr: coverpoint addr {
            bins low  = {[0:33333]};
            bins mid  = {[33334:66666]};
            bins high = {[66667:100000]};
        }

        cp_data: coverpoint mem[addr] {
            bins zero     = {0};
            bins non_zero = {[1:$]};
        }
    endgroup

    mem_cg cg_inst = new();

 
    initial begin
        $dumpfile("assoc_array.vcd");
        $dumpvars(0, tb_associative_arrays);
    end

    initial begin
        addr = 0;
        mem[addr] = 0;
        cg_inst.sample();
        #5;

        repeat (10) begin
            addr = $urandom_range(0, 100000);
            mem[addr] = $urandom();
            cg_inst.sample();
            #5;
        end

        foreach (mem[idx])
            $display("Addr: %0d  Data: %0h", idx, mem[idx]);

        $display("Total Coverage = %0.2f %%", cg_inst.get_coverage());

        #10;   
        $finish;
    end

endmodule
