//------------------------------------------------------------------------------
// File        : atm_controller.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-07
// Module      : atm_controller
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : ATM Controller design with enum 
//------------------------------------------------------------------------------
module atm_controller (
    input  logic clk,
    input  logic rst_n,

    input  logic card_inserted,
    input  logic pin_correct,
    input  logic balance_ok,

    output logic dispense_cash
);

    typedef enum logic [1:0] {
        IDLE       = 2'b00,
        CHECK_PIN = 2'b01,
        CHECK_BAL = 2'b10,
        DISPENSE  = 2'b11
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next-state logic
    always_comb begin
        next_state     = state;
        dispense_cash = 1'b0;

        case (state)
            IDLE: begin
                if (card_inserted)
                    next_state = CHECK_PIN;
            end

            CHECK_PIN: begin
                if (pin_correct)
                    next_state = CHECK_BAL;
                else
                    next_state = IDLE;
            end

            CHECK_BAL: begin
                if (balance_ok)
                    next_state = DISPENSE;
                else
                    next_state = IDLE;
            end

            DISPENSE: begin
                dispense_cash = 1'b1;
                next_state    = IDLE;
            end
        endcase
    end

endmodule
