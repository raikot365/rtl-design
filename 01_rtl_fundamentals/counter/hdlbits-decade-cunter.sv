// Build a decade counter that counts from 0 through 9, inclusive, with a period of 10. The reset input is synchronous, and should reset the counter to 0.

// My solution

module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
	
    always @(posedge clk) begin
        if (reset) q <= 0;
        else if (q == 4'b1001) q <= 0;
        else q <= q + 1'b1;
    end
endmodule

// HDLbits solution
// module top_module(
// 	input clk,
// 	input reset,
// 	output reg [3:0] q);
	
// 	always @(posedge clk)
// 		if (reset || q == 9)	// Count to 10 requires rolling over 9->0 instead of the more natural 15->0
// 			q <= 0;
// 		else
// 			q <= q+1;
	
// endmodule


// Make a decade counter that counts 1 through 10, inclusive. The reset input is synchronous, and should reset the counter to 1.
// module top_module(
// 	input clk,
// 	input reset,
// 	output reg [3:0] q);
	
// 	always @(posedge clk)
//         if (reset || q == 10)	
// 			q <= 1;
// 		else
// 			q <= q+1;
	
// endmodule