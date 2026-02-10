//------------------------------------------------------------------------------
// File        : tb_digital_clock.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-06
// Module      : tb_digital_clock
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Test bench Digital clock design 
//------------------------------------------------------------------------------


module tb_digital_clock;

    logic clk;
    logic rst_n;
    logic [5:0] sec;
    logic [5:0] min;

    // DUT
    digital_clock dut (
        .clk(clk),
        .rst_n(rst_n),
        .sec(sec),
        .min(min)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

 
    // COVERAGE WITH TRANSITION BINS

    covergroup clock_cg @(posedge clk);

        // 1. Verify second wraps: 59 -> 0
        sec_wrap_cp : coverpoint sec {
            bins sec_wrap = (59 => 0);
        }

        // 2. Verify minute increments by +1
        min_inc_cp : coverpoint min {
            bins min_inc = ( [0:58] => [1:59] );
        }

        // 3. Ensure min increments WHEN sec wraps
        sec_wrap_min_inc : cross sec_wrap_cp, min_inc_cp;

    endgroup

    clock_cg cg;

    // TEST SEQUENCE

    initial begin
        
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_digital_clock);

        clk = 0;
        rst_n = 0;

        cg = new();

        // Apply reset
        #12;
        rst_n = 1;

    
        repeat (130) begin
            @(posedge clk);
            cg.sample();
        end

        $display("Simulation finished");
        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
