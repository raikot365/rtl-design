module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );

    assign {cout, sum} = (a + b + cin > 9) ? (a + b + cin + 6) : (a + b + cin);
endmodule