module calculator_top;

  calculator_inter intf();

  calculator DUT (
    .a(intf.a),
    .b(intf.b),
    .opcode(intf.opcode),
    .result(intf.result)
  );

  calculator_test TB (intf);

endmodule

