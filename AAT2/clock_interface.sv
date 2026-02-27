interface clock_interface (input logic clk);

    logic reset;
    logic [5:0] seconds;
    logic [5:0] minutes;

    modport DUT (
        input  clk,
        input  reset,
        output seconds,
        output minutes
    );

    modport TB (
        input  clk,
        output reset,
        input  seconds,
        input  minutes
    );

endinterface
