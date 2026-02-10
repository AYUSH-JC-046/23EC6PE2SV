//------------------------------------------------------------------------------
// File        : tb_alu.sv
// Author      : Ayush JC / 1BM23EC046 
// Created     : 2026-02-06
// Module      : tb_alu
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
// Description : 32 bit alu test bench design with enum
//------------------------------------------------------------------------------


module tb_alu;

    // DUT signals
    logic [31:0] a, b;
    logic [1:0]  opcode;
    logic [31:0] result;

    // Instantiate DUT
    alu dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result)
    );

    // Enum
    typedef enum logic [1:0] {
        ADD = 2'b00,
        SUB = 2'b01,
        MUL = 2'b10,
        XOR = 2'b11
    } opcode_t;

    // Transaction
    class alu_transaction;
        rand logic [31:0] a;
        rand logic [31:0] b;
        rand opcode_t     opcode;

        constraint opcode_dist {
            opcode dist {
                ADD := 40,
                SUB := 20,
                MUL := 20,
                XOR := 20
            };
        }
    endclass

    // Coverage
   covergroup alu_cg;
    coverpoint opcode {
        bins add_op = {ADD};
        bins sub_op = {SUB};
        bins mul_op = {MUL};
        bins xor_op = {XOR}; // FIXED
    }
endgroup

    alu_transaction tr;
    alu_cg cg;

    // Reference model
    function automatic logic [31:0] ref_model(
        input logic [31:0] a,
        input logic [31:0] b,
        input opcode_t op
    );
        case (op)
            ADD: ref_model = a + b;
            SUB: ref_model = a - b;
            MUL: ref_model = a * b;
            XOR: ref_model = a ^ b;
            default: ref_model = 32'h0;
        endcase
    endfunction

    initial begin
      
      $dumpfile("dump.vcd");
      $dumpvars(0, tb_alu);
      
      
        tr = new();
        cg = new();

        // Run multiple randomized transactions
        repeat (200) begin
            assert(tr.randomize())
                else $fatal("Randomization failed");

            a      = tr.a;
            b      = tr.b;
            opcode = tr.opcode;

            #1; // allow combinational settle

            // Sample coverage
            cg.sample();

            // Check result
            if (result !== ref_model(a, b, tr.opcode)) begin
                $error("Mismatch! a=%0d b=%0d opcode=%0d result=%0d expected=%0d",
                        a, b, opcode, result, ref_model(a, b, tr.opcode));
            end
        end

        $display("Simulation finished");
        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
