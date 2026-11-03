module half_adder_tb;
reg x,y;
wire s, c;

//half_adder dut (x, y, s,c);
half_adder dut
(.a(x), .b(y), .sum(s),.carry(c));//design instantiation

//stimulus
initial begin
    x=0; y=0;
    #10 x=0; y=1;
    #10 x=1; y=0;
    #10 x=1; y=1;
    #20 $finish;
end

initial begin
    $monitor( $time, "x=%b y=%b sum=%b carry=%b",x,y,s,c);
end

endmodule