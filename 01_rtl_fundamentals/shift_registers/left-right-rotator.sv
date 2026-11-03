// Build a 100-bit left/right rotator, with synchronous load and left/right enable. A rotator shifts-in the shifted-out bit from the other end of the register, unlike a shifter that discards the shifted-out bit and shifts in a zero. If enabled, a rotator rotates the bits around and does not modify/discard them.

// load: Loads shift register with data[99:0] instead of rotating.
// ena[1:0]: Chooses whether and which direction to rotate.
        // 2'b01 rotates right by one bit
        // 2'b10 rotates left by one bit
        // 2'b00 and 2'b11 do not rotate.
// q: The contents of the rotator.


// My solution
module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);
    
    always @(posedge clk) begin
        if (load) q <= data;
        else case (ena)
            2'b10: begin //rotates left by one bit
                q[99:1] <=  q[98:0];
                q[0] <= q[99];
            end
            2'b01: begin //rotates right by one bit
                q[98:0] <=  q[99:1];
                q[99] <= q[0];
            end
        endcase
    end
endmodule

// HDLbits solution
// module top_module(
// 	input clk,
// 	input load,
// 	input [1:0] ena,
// 	input [99:0] data,
// 	output reg [99:0] q);
	
// 	// This rotator has 4 modes:
// 	//   load
// 	//   rotate left
// 	//   rotate right
// 	//   do nothing
// 	// I used vector part-select and concatenation to express a rotation.
// 	// Edge-sensitive always block: Use non-blocking assignments.
// 	always @(posedge clk) begin
// 		if (load)		// Load
// 			q <= data;
// 		else if (ena == 2'h1)	// Rotate right
// 			q <= {q[0], q[99:1]};
// 		else if (ena == 2'h2)	// Rotate left
// 			q <= {q[98:0], q[99]};
// 	end
// endmodule