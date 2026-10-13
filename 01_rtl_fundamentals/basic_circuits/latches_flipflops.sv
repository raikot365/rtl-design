//Latches and flip-flops


// ============================================================
//                    MODULO: D flip-flop
//                    
// ============================================================

// D flip-flop https://hdlbits.01xz.net/wiki/Dff
module top_module(
	input clk,
	input d,
	output reg q);
	
	// Use non-blocking assignment for edge-triggered always blocks
	always @(posedge clk)
		q <= d;

	// Undefined simulation behaviour can occur if there is more than one edge-triggered
	// always block and blocking assignment is used. Which always block is simulated first?
	
endmodule

// ============================================================
//                    MODULO: 8-bit D flip-flop
//                    
// ============================================================

// for a 8-bit D flip-flop
// module top_module(
// 	input clk,
// 	input [7:0] d,
// 	output reg [7:0] q);
	
// 	// Because q is a vector, this creates multiple DFFs.
// 	always @(posedge clk)
// 		q <= d;
	
// endmodule

// 8-bit D flip-flop with synchronous reset
// module top_module (
//     input clk,
//     input reset,            // Synchronous reset
//     input [7:0] d,
//     output [7:0] q
// );
//     always @(posedge clk) begin
//         q <= reset ? 8'h00: d;
//     end

// endmodule

// ============================================================
//                    MODULO: 8-bit D flip-flop 
//                    synchronous reset to 0x34
// ============================================================

// Create 8 D flip-flops with active high synchronous reset. The flip-flops must be reset to 0x34 rather than zero. All DFFs should be triggered by the negative edge of clk.

// module top_module (
//     input clk,
//     input reset,
//     input [7:0] d,
//     output [7:0] q
// );
//     always @(negedge clk) begin
//         q <= reset ? 8'h34 : d;
//     end
// endmodule

// ============================================================
//                    MODULO: 8-bit D flip-flop 
//                    asynchronous reset
// ============================================================

// Create 8 D flip-flops with active high asynchronous reset. All DFFs should be triggered by the positive edge of clk.
//my solution
// module top_module (
//     input clk,
//     input areset,   // active high asynchronous reset
//     input [7:0] d,
//     output [7:0] q
// );
//     always @(posedge clk or posedge areset)
//         q <= areset ? 8'h00 : d;
// endmodule

// solution provided by HDLBits
// module top_module(
// 	input clk,
// 	input [7:0] d,
// 	input areset,
// 	output reg [7:0] q);
	
// 	// The only difference in code compared to synchronous reset is in the sensitivity list.
// 	always @(posedge clk, posedge areset)
// 		if (areset)
// 			q <= 0;
// 		else
// 			q <= d;


// 	// In Verilog, the sensitivity list looks strange. The FF's reset is sensitive to the
// 	// *level* of areset, so why does using "posedge areset" work?
// 	// To see why it works, consider the truth table for all events that change the input 
// 	// signals, assuming clk and areset do not switch at precisely the same time:
	
// 	//  clk		areset		output
// 	//   x		 0->1		q <= 0; (because areset = 1)
// 	//   x		 1->0		no change (always block not triggered)
// 	//  0->1	   0		q <= d; (not resetting)
// 	//  0->1	   1		q <= 0; (still resetting, q was 0 before too)
// 	//  1->0	   x		no change (always block not triggered)
	
// endmodule

// ============================================================
//                    MODULO: 16-bit D flip-flop
//                    bite-enable upper and lower bytes
// ============================================================

//Create 16 D flip-flops. It's sometimes useful to only modify parts of a group of flip-flops. The byte-enable inputs control whether each byte of the 16 registers should be written to on that cycle. byteena[1] controls the upper byte d[15:8], while byteena[0] controls the lower byte d[7:0].

// resetn is a synchronous, active-low reset.

// All DFFs should be triggered by the positive edge of clk.

// module top_module (
//     input clk,
//     input resetn,
//     input [1:0] byteena,
//     input [15:0] d,
//     output [15:0] q
// );
//     always @(posedge clk) begin
//         case (byteena)
//             2'b01: q[7:0] <= resetn ? d[7:0]: 8'h00;
//             2'b10: q[15:8] <= resetn ? d[15:8]: 8'h00;
//             2'b11: q <= resetn ? d : 16'h0000;
//         endcase
//     end
           	

// endmodule


// ============================================================
//                    MODULO: D - latch
//                    
// ============================================================

// Implement the following circuit:

    //          ┌─────────────┐
    //   D ────►│ D         Q │────► Q
    //          │             │
    // ENA ────►│ EN          │
    //          └─────────────┘

// Note that this is a latch, so a Quartus warning about having inferred a latch is expected.
// - Latches are level-sensitive (not edge-sensitive) circuits, so in an always block, they use level-sensitive sensitivity lists.
// - However, they are still sequential elements, so should use non-blocking assignments.
// - A D-latch acts like a wire (or non-inverting buffer) when enabled, and preserves the current value when disabled.

// module top_module (
//     input d, 
//     input ena,
//     output q);
	
//     always @(*) begin
//         q <= ena ? d : q;
//     end
// endmodule

// ============================================================
//                    MODULO: DFF
//                    asynchronous reset
// ============================================================

//Implement the following circuit:
//        ┌──────────┐
//    D ──┤ D      Q ├── Q
//        │          │
//  CLK ──┤►         │
//    AR ─┤ AR       │
//        └──────────┘

// module top_module (
//     input clk,
//     input d, 
//     input ar,   // asynchronous reset
//     output q);
    
//     always @(posedge clk, posedge ar) begin
//         q <= ar ? 1'b0 : d;
//     end

// endmodule

// ============================================================
//                    MODULO: DFF
//                    synchronous reset
// ============================================================

//Implement the following circuit:
//        ┌──────────┐
//    D ──┤ D      Q ├── Q
//        │          │
//  CLK ──┤►         │
//     R ─┤ R        │
//        └──────────┘

// module top_module (
//     input clk,
//     input d, 
//     input r,   // synchronous reset
//     output q);
//      always @(posedge clk) begin
//          q <= r ? 1'b0 : d;
//      end

// endmodule


// ============================================================
//                    MODULO: DFF + gate
//                    XOR gate
// ============================================================

//Implement the following circuit:

//     ┌────────────────────────────────┐
//     │                                │
//     │     ┌─────┐                    │
//     └─────┤     │                    │
//           │ XOR │       ┌─────────┐  │
//   IN ─────┤     ├───────│ D     Q ├──── Q
//           └─────┘       │         │
//                         │         │
//                   CLK ──┤►        │
//                         └─────────┘

// module top_module (
//     input clk,
//     input in, 
//     output out);

//     always @(posedge clk) begin
//         out <= in^out;
//     end
// endmodule


// ============================================================
//       MODULO: Taken from ECE253 2015 midterm question 5
//                    
// ============================================================


// Consider the sequential circuit below:


//              r0                         r1                                      r2
//               │                          │                                       │
//       ┌───────┼──────────────────────────┼───────────────────────────┬───────────┼──────────────────────┐
//       │       │                          │                           │           │                      │
//       │       ▼                          ▼                           │           ▼                      │
//       │    ┌──┴──┐                    ┌──┴──┐                        │        ┌──┴──┐                   │
//       │    │  1  │                    │  1  │                        ▼        │  1  │                   │
//       │    │     ├──┐                 │     ├──┐                  ┌──┴──┐     │     ├───┐               │
//       └──► ┤  0  │  │        ┌──────► ┤  0  │  │                  │ XOR ├───► ┤  0  │   │               │
//            └──┬──┘  │        │        └──┬──┘  │                  └──┬──┘     └──┬──┘   │               │
//               │     ▼       Q0           │     ▼                     ▲           │      ▼               │
//               │   ┌─┴─────┐  │           │   ┌─┴─────┐               │           │    ┌─┴─────┐         │
//               │   │ D   Q ├──┘           │   │ D   Q ├─── Q1 ────────┘           │    │ D   Q ├─── Q2 ──┘
//               │   │       │              │   │       │                           │    │       │
//               │   │  CLK  │              │   │  CLK  │                           │    │  CLK  │
//               │   └───▲───┘              │   └───▲───┘                           │    └───▲───┘
//               │       │                  │       │                               │        │
//     L ────────┴───────┴──────────────────┴───────┴────────────────────────────────────────┘
//     Clock ────────────┴──────────────────┴───────────────────────────────────────┘

// Assume that you want to implement hierarchical Verilog code for this circuit, using three instantiations of a submodule that has a flip-flop and multiplexer in it. Write a Verilog module (containing one flip-flop and multiplexer) named top_module for this submodule.

// module top_module (
// 	input clk,
// 	input L,
// 	input r_in,
// 	input q_in,
// 	output reg Q);
//     always @(posedge clk) begin
//         Q <= L ? r_in : q_in;
//     end
// endmodule

    // always @(posedge clk) begin
	// 	if (L) begin
	// 		Q <= r_in;
	// 	end else begin
	// 		Q <= q_in;
	// 	end
	// end
