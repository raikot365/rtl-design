// Four-bit binary counter
// Build a 4-bit binary counter that counts from 0 through 15, inclusive, with a period of 16. The reset input is synchronous, and should reset the counter to 0.

//My solution
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    always @(posedge clk) begin
        if (reset) q <= 4'h0;
        else q <= q + 1'b1;
    end
endmodule

// //HDLbits solution
// module top_module(
// 	input clk,
// 	input reset,
// 	output reg [3:0] q);
	
// 	always @(posedge clk)
// 		if (reset)
// 			q <= 0;
// 		else
// 			q <= q+1;		// Because q is 4 bits, it rolls over from 15 -> 0.
// 		// If you want a counter that counts a range different from 0 to (2^n)-1, 
// 		// then you need to add another rule to reset q to 0 when roll-over should occur.
	
// endmodule

// Decade counter
