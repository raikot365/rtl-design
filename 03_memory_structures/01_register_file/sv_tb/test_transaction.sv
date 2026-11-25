`timescale 1ns/1ns

`include "transaction.sv"

module test_transaction;

    transaction tr;

    initial begin
        tr = new(1);

        $display("--- Normal randomization ---");
        repeat (5) begin
            tr.run();
        end
        $display("--- Desactivando constraint manualmente ---");
        tr.we_default.constraint_mode(0); // Apaga la constraint

        assert((tr.randomize() with { we == 0; }) == 1)
            else $fatal(1, "Randomization failed");

        tr.we_default.constraint_mode(1); // La vuelve a prender para después

        // $display("--- Inline constraint: read operation ---");
        // assert((tr.randomize() with { we == 0; }) == 1)
        //     else $fatal(1, "Randomization failed");

        tr.print();

        if (tr.we !== 1'b0) begin
            $fatal(1, "ERROR: Expected we=0, got we=%b", tr.we);
        end

        $display("Inline constraint test passed!");

        $finish;
    end

endmodule
