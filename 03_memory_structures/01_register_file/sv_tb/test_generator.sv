`timescale 1ns/1ns

`include "generator.sv"

module test_generator;

    generator gen;

    initial begin
        gen = new(10);

        $display("--- Generator test ---");
        gen.run();

        $finish;
    end

endmodule