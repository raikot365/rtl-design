// Parameterized Modules
// parameter is a constant value that is defined at compile time and used within a module

// adder design code
module Adder #(parameter WIDTH = 4) (input [WIDTH-1:0] a, b, output [WIDTH-1:0] sum);
    assign sum = a + b;
endmodule

//Testbench
'timescale 1ns / 1ps
module tb_Adder; // Testbench module

// Declare 8-bit test signals
reg [7:0] a, b; // 8-bit inputs
wire [7:0] sum; // 8-bit output

// Instantiate the Adder module with WIDTH overridden to 8
Adder #(8) uut ( .a(a), .b(b), .sum(sum) );

initial begin
    $monitor("At time %t, a = %d, b = %d, sum = %d", $time, a, b, sum);
    // Initialize inputs
    a = 8'b00001111; // a = 15
    b = 8'b00000101; // b=5
    #10; // Wait for 10 time units
    a = 8'b11111111; // a = 255
    b = 8'b00000001; // b=1
    #10; // Wait for 10 time units
    // End of simulation
    $finish;
end
endmodule