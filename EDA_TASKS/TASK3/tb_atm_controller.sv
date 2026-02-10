//------------------------------------------------------------------------------
// File        : tb_atm_controller.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-07
// Module      : tb_atm_controller
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Test bench for ATM Controller design with enum 
//------------------------------------------------------------------------------

module tb_atm_controller;

    logic clk;
    logic rst_n;

    logic card_inserted;
    logic pin_correct;
    logic balance_ok;

    logic dispense_cash;

    // DUT
    atm_controller dut (
        .clk(clk),
        .rst_n(rst_n),
        .card_inserted(card_inserted),
        .pin_correct(pin_correct),
        .balance_ok(balance_ok),
        .dispense_cash(dispense_cash)
    );

    // Clock: 10ns
    always #5 clk = ~clk;

    // ASSERTIONS 
    // Cash dispensed ONLY if pin_correct and balance_ok
    property dispense_only_if_valid;
        @(posedge clk)
        dispense_cash |-> (pin_correct && balance_ok);
    endproperty

    assert_dispense_valid: assert property (dispense_only_if_valid)
        else $error("ASSERTION FAILED: dispense without valid pin/balance");

    // After dispense, machine returns to IDLE
    property return_to_idle;
        @(posedge clk)
        dispense_cash |=> (dut.state == dut.IDLE);
    endproperty

    assert_return_idle: assert property (return_to_idle)
        else $error("ASSERTION FAILED: did not return to IDLE");

    
    // FUNCTIONAL COVERAGE
 
    covergroup atm_cg @(posedge clk);

        // State coverage
        state_cp : coverpoint dut.state {
            bins idle       = {dut.IDLE};
            bins check_pin  = {dut.CHECK_PIN};
            bins check_bal  = {dut.CHECK_BAL};
            bins dispense   = {dut.DISPENSE};
        }

        // Successful transaction
        success_path : coverpoint dispense_cash {
            bins dispensed = {1};
        }

    endgroup

    atm_cg cg;

    
    // TEST SEQUENCE
   
    initial begin
        
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_atm_controller);

        clk = 0;
        rst_n = 0;

        card_inserted = 0;
        pin_correct   = 0;
        balance_ok    = 0;

        cg = new();

        // Reset
        #12;
        rst_n = 1;

        //Successful withdrawal
        @(posedge clk);
        card_inserted = 1;

        @(posedge clk);
        card_inserted = 0;
        pin_correct   = 1;

        @(posedge clk);
        pin_correct = 0;
        balance_ok  = 1;

        @(posedge clk);
        balance_ok = 0;

        // Wrong PIN 
        @(posedge clk);
        card_inserted = 1;

        @(posedge clk);
        card_inserted = 0;
        pin_correct   = 0;

        // Insufficient balance
        @(posedge clk);
        card_inserted = 1;

        @(posedge clk);
        card_inserted = 0;
        pin_correct   = 1;

        @(posedge clk);
        pin_correct = 0;
        balance_ok  = 0;

        // Sample coverage for a few cycles
        repeat (5) begin
            @(posedge clk);
            cg.sample();
        end

        $display("Simulation finished");
        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
