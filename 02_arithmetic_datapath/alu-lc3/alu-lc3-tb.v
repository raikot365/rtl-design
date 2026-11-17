`default_nettype none
`timescale 1ns/1ns

`define assert(signal, value) \
        if (signal !== value) begin \
            $display("ASSERTION FAILED at %2d in %m: signal != value", $time); \
            $finish; \
        end

module  alu_tb;

  reg clk;
  reg [1:0] aluk = 2'b00;
  reg [`DATA_WIDTH-1:0] a = 16'h0000;
  reg [`DATA_WIDTH-1:0] b = 16'h0000;
  
  wire [`DATA_WIDTH-1:0] alu_out;

  alu dut (
    .aluk(aluk),
    .a(a),
    .b(b),
    .alu_out(alu_out)
  );
  
  initial begin
    clk = 1'b0;
  end

  always #5 clk = ~clk;

  initial begin
        a = 16'h0001;
        b = 16'h0001;
        aluk = `OP_ALU_ADD;
      #10;
        `assert(dut.alu_out, 16'h0002);
        a = 16'h0001;
        b = 16'h0001;
        aluk = `OP_ALU_AND;
      #10;
        `assert(dut.alu_out, 16'h0001);
        a = 16'h0001;
        b = 16'h0001;
        aluk = `OP_ALU_NOT;
      #10;
        `assert(dut.alu_out, 16'hfffe);
        a = 16'h1001;
        b = 16'h0001;
        aluk = `OP_ALU_PASS;
       #10;
        `assert(dut.alu_out, 16'h1001);
    $finish;

  end

  always @(posedge clk) begin 
    $display("time %2t, aluk = %5b, a = %8h, b = %8h, alu_out = %8h", $time, aluk, a, b, alu_out);
  end 
  
  initial begin
    $dumpfile("alu.vcd"); //genera el archivo de salida para visualizar en GTKWave
    $dumpvars;  
  end

endmodule