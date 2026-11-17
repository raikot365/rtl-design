// Build a 4-digit BCD (binary-coded decimal) counter. Each decimal digit is encoded using 4 bits: q[3:0] is the ones digit, q[7:4] is the tens digit, etc. For digits [3:1], also output an enable signal indicating when each of the upper three digits should be incremented.

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q
);

    assign ena[1] = (q[3:0] == 4'd9);

    assign ena[2] = ena[1] && (q[7:4] == 4'd9);

    assign ena[3] = ena[2] && (q[11:8] == 4'd9);

    bcd_counter count0 (.clk(clk),     .reset(reset), .enable(1'b1),     .q(q[3:0]));
    bcd_counter count1 (.clk(clk),     .reset(reset), .enable(ena[1]),   .q(q[7:4]));
    bcd_counter count2 (.clk(clk),     .reset(reset), .enable(ena[2]),   .q(q[11:8]));
    bcd_counter count3 (.clk(clk),     .reset(reset), .enable(ena[3]),   .q(q[15:12]));

endmodule

module bcd_counter (
    input clk,
    input reset,
    input enable,
    output reg [3:0] q
);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'd0;
        end else if (enable) begin
            if (q == 4'd9)
                q <= 4'd0;
            else
                q <= q + 4'd1;
        end
    end
    
endmodule