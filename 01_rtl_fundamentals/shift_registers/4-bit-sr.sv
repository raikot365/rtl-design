// Build a 4-bit shift register (right shift), with asynchronous reset, synchronous load, and enable.

// areset: Resets shift register to zero.
// load: Loads shift register with data[3:0] instead of shifting.
// ena: Shift right (q[3] becomes zero, q[0] is shifted out and disappears).
// q: The contents of the shift register.
// If both the load and ena inputs are asserted (1), the load input has higher priority.

//My solution

module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
	
    always @(posedge clk or posedge areset) begin
        if (areset) q <= 4'h0;
        else if (load) q <= data;
        else if (ena) begin
            q[3] <= 0;
            q[2] <= q[3];
            q[1] <= q[2];
            q[0] <= q[1];
        end
    end  
        
endmodule

//HDLbits solution (Use a vector part select to express a shift and , instead or for the clocking event)
// module top_module(
// 	input clk,
// 	input areset,
// 	input load,
// 	input ena,
// 	input [3:0] data,
// 	output reg [3:0] q);
	
// 	// Asynchronous reset: Notice the sensitivity list.
// 	// The shift register has four modes:
// 	//   reset
// 	//   load
// 	//   enable shift
// 	//   idle -- preserve q (i.e., DFFs)
// 	always @(posedge clk, posedge areset) begin
// 		if (areset)		// reset
// 			q <= 0;
// 		else if (load)	// load
// 			q <= data;
// 		else if (ena)	// shift is enabled
// 			q <= q[3:1];	// Use vector part select to express a shift.
// 	end
	
// endmodule