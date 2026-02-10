//------------------------------------------------------------------------------
// File        : digital_clock.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-06
// Module      : digital_clock
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : Digital clock design 
//------------------------------------------------------------------------------

module digital_clock (
    input  logic clk,
    input  logic rst_n,
    output logic [5:0] sec,
    output logic [5:0] min
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sec <= 6'd0;
            min <= 6'd0;
        end
        else begin
            if (sec == 6'd59) begin
                sec <= 6'd0;
                if (min == 6'd59)
                    min <= 6'd0;
                else
                    min <= min + 6'd1;
            end
            else begin
                sec <= sec + 6'd1;
            end
        end
    end

endmodule
