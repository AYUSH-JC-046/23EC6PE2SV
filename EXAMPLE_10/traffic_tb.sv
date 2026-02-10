//------------------------------------------------------------------------------
// File        : traffic_tb.sv
// Author      : Ayush JC / 1BM23EC046
// Created     : 2026-02-03
// Module      : traffic_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for traffic lights controller. 
//------------------------------------------------------------------------------

module traffic_tb;

    logic clk = 0;
    logic rst;
    light_t color;

    // DUT instance
    traffic dut (.*);

    always #5 clk = ~clk;

    // Coverage: traffic light sequence
    covergroup cg_light @(posedge clk);
        cp_c : coverpoint color {
            bins cycle = (RED => GREEN => YELLOW => RED);
        }
    endgroup

    cg_light cg = new();

    initial begin
        $dumpfile("traffic_tb.vcd");
        $dumpvars(0, traffic_tb);
    end

    // Stimulus
    initial begin
        rst = 1;
        #12;
        rst = 0;

        repeat (10) @(posedge clk);

        $display("Coverage: %0.2f%%", cg.get_inst_coverage());
        $finish;
    end

endmodule
