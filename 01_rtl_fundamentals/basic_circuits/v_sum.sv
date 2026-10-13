module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
    assign s = a+b;
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);
    // assign s = ...
    // assign overflow = ...

endmodule

module 8_bit_adder (
    input [7:0] a,
    input [7:0] b,
    output [8:0] s,
    output cout
); //
    assign s = a+b;
    assign cout = s[8];
    // assign s = ...

endmodule

module 100_bit_adder (
	input [99:0] a,
	input [99:0] b,
	input cin,
	output cout,
	output [99:0] sum
);

	// The concatenation {cout, sum} is a 101-bit vector.
	assign {cout, sum} = a+b+cin;

endmodule