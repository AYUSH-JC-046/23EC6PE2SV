//------------------------------------------------------------------------------
// File        : atm.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-02
// Module      : atm
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : ATM controller design with enum logic
//------------------------------------------------------------------------------

module atm (
  atm_inter.DUT intf
);

  typedef enum logic [1:0] {
    IDLE,
    CHECK_PIN,
    CHECK_BAL,
    DISPENSE
  } state_t;

  state_t state, next_state;

  // State register
  always_ff @(posedge intf.clk or negedge intf.reset_n) begin
    if (!intf.reset_n)
      state <= IDLE;
    else
      state <= next_state;
  end

  // Next-state logic
  always_comb begin
    next_state = state;
    case (state)
      IDLE:
        if (intf.card_inserted)
          next_state = CHECK_PIN;

      CHECK_PIN:
        if (intf.pin_correct)
          next_state = CHECK_BAL;
        else
          next_state = IDLE;

      CHECK_BAL:
        if (intf.balance_ok)
          next_state = DISPENSE;
        else
          next_state = IDLE;

      DISPENSE:
        next_state = IDLE;
    endcase
  end

  // Output logic
  assign intf.dispense_cash = (state == DISPENSE);

 
  // Assertions


  // Cash dispensed only if pin_correct & balance_ok were true
  property dispense_only_if_valid;
    @(posedge intf.clk)
    intf.dispense_cash |-> (intf.pin_correct && intf.balance_ok);
  endproperty

  assert property (dispense_only_if_valid)
    else $error("Cash dispensed without valid PIN and balance");

  // Return to IDLE after DISPENSE
  property return_to_idle;
    @(posedge intf.clk)
    state == DISPENSE |=> state == IDLE;
  endproperty

  assert property (return_to_idle)
    else $error("FSM did not return to IDLE after DISPENSE");

endmodule

