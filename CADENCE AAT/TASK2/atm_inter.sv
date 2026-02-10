interface atm_inter (input logic clk);

  logic reset_n;
  logic card_inserted;
  logic pin_correct;
  logic balance_ok;
  logic dispense_cash;

  modport DUT (
    input  clk, reset_n, card_inserted, pin_correct, balance_ok,
    output dispense_cash
  );

  modport TB (
    output reset_n, card_inserted, pin_correct, balance_ok,
    input  dispense_cash
  );

endinterface

