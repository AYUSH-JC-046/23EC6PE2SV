module atm_top;

  logic clk;

  // Clock generation (10 ns clock period)
  initial clk = 0;
  always #5 clk = ~clk;

  // Interface instantiation
  atm_inter intf (clk);

  // DUT instantiation
  atm dut (
    .intf(intf)
  );

  // Testbench instantiation
  atm_test tb (
    .intf(intf)
  );

endmodule

