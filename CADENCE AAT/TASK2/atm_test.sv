//------------------------------------------------------------------------------
// File        : atm_test.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-02
// Module      : atm_test
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : ATM controller design with enum logic
//------------------------------------------------------------------------------

module atm_test (
  atm_inter.TB intf
);

  // VCD file dumping (for waveform analysis)
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, atm_top);
  end

  initial begin
    // Default inputs
    intf.reset_n       = 0;
    intf.card_inserted = 0;
    intf.pin_correct   = 0;
    intf.balance_ok    = 0;

    // Reset the ATM system
    #10 intf.reset_n = 1;

    // ---- Case 1: Valid transaction ----
    intf.card_inserted = 1;  // Insert card
    intf.pin_correct   = 1;  // Correct PIN
    intf.balance_ok    = 1;  // Sufficient balance
    #20;  // Wait for transaction to complete

    // ---- Case 2: Invalid PIN ----
    intf.card_inserted = 1;  // Insert card
    intf.pin_correct   = 0;  // Incorrect PIN
    intf.balance_ok    = 1;  // Sufficient balance
    #20;  // Check that no cash is dispensed

    // ---- Case 3: Insufficient balance ----
    intf.card_inserted = 1;  // Insert card
    intf.pin_correct   = 1;  // Correct PIN
    intf.balance_ok    = 0;  // Insufficient balance
    #20;  // Check that no cash is dispensed

    // ---- Case 4: No card inserted (idle) ----
    intf.card_inserted = 0;  // No card inserted
    #20;  // FSM should stay in IDLE

    // ---- Case 5: Valid transaction after reset ----
    intf.reset_n = 0;        // Reset system
    #10 intf.reset_n = 1;    // Restart system
    intf.card_inserted = 1;  // Insert card
    intf.pin_correct   = 1;  // Correct PIN
    intf.balance_ok    = 1;  // Sufficient balance
    #20;  // Complete transaction and return to IDLE

    // ---- Case 6: Invalid transition (no card inserted) ----
    intf.card_inserted = 0;  // No card inserted
    #20;

    // ---- Case 7: Reset system and test again ----
    intf.reset_n = 0;        // Reset system
    #10 intf.reset_n = 1;    // Restart system
    intf.card_inserted = 1;  // Insert card
    intf.pin_correct   = 0;  // Incorrect PIN
    intf.balance_ok    = 1;  // Sufficient balance
    #20;

    $display("ATM test completed");
    $finish;
  end

endmodule

