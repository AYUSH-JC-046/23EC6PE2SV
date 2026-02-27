program clock_test (clock_interface.TB intf);

    // Functional Coverage

    covergroup clock_cg @(posedge intf.clk);


        // Seconds Coverpoint
        seconds_cp : coverpoint intf.seconds {
            bins sec_vals[]   = {[0:59]};
            bins sec_rollover = (59 => 0);
        }

        // Minutes Coverpoint
        minutes_cp : coverpoint intf.minutes {
            bins min_vals[]   = {[0:59]};
            bins min_rollover = (59 => 0);
        }


        // Cross Coverage (ONLY value bins)

       cross seconds_cp, minutes_cp {

            ignore_bins ignore_sec_roll =
                binsof(seconds_cp.sec_rollover);

            ignore_bins ignore_min_roll =
                binsof(minutes_cp.min_rollover);
        }

    endgroup

    clock_cg cg;

    initial begin
        cg = new();

   
        // Initial Reset
        intf.reset = 1;
        repeat (3) @(posedge intf.clk);
        intf.reset = 0;


        // Run enough cycles
        // 3600 required for full state space
        repeat (5000) @(posedge intf.clk);

   
        // Second Reset
        intf.reset = 1;
        @(posedge intf.clk);
        intf.reset = 0;

        // Run again
        repeat (5000) @(posedge intf.clk);

        // Extra cycles to ensure last transitions sampled
        repeat (10) @(posedge intf.clk);

        $display("Simulation Completed Successfully");
        $finish;
    end

endprogram



