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



// Consider the n-bit shift register circuit shown below:
// See https://hdlbits.01xz.net/wiki/Exams/2014_q4a
// Write a Verilog module named top_module for one stage of this circuit, including both the flip-flop and multiplexers.

// ============================================================
//                    MODULO: 2-mux + dff
//
// ============================================================

// module top_module (
//     input clk,
//     input w, R, E, L,
//     output Q
// );

// 	always @(posedge clk) begin
// 		if (L) Q <= R;
// 		else begin
// 			if (E) Q <= w;
// 			else Q <= Q;
// 		end
// 	end

// endmodule


// Given the finite state machine circuit as shown, assume that the D flip-flops are initially reset to zero before the machine begins. Build this circuit.
// See https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q4


// ============================================================
//                    MODULO: dff and gates
//
// ============================================================

// module top_module (
//     input clk,
//     input x,
//     output z
// );
//     // 1. Declaramos los cables para las salidas Q y Q_negada de cada flip-flop
//     wire q1;
//     wire q2;
//     wire q3;

//     // 2. Cables para las entradas D que van a las compuertas previas
//     wire d1, d2, d3;

//     // 3. Lógica combinacional de las compuertas de entrada (antes de los D)
//     assign d1 = x ^ q1;         // Compuerta XOR superior
//     assign d2 = x & ~q2;     // Compuerta AND del medio
//     assign d3 = x | ~q3;     // Compuerta OR inferior

//     // 4. Instanciación de los 3 Flip-Flops D
//     // (Asumimos que tu módulo dff tiene puertos: clk, d, q y q_bar)
//     dff ff1 (
//         .clk(clk),
//         .d(d1),
//         .q(q1),
//     );

//     dff ff2 (
//         .clk(clk),
//         .d(d2),
//         .q(q2),
//     );

//     dff ff3 (
//         .clk(clk),
//         .d(d3),
//         .q(q3),
//     );

//     // 5. Compuerta NOR final que genera la salida Z
//     assign z = ~(q1 | q2 | q3);

// endmodule


// ============================================================
//                    MODULO: JFF flip-flop
//
// ============================================================

// A JK flip-flop has the below truth table. Implement a JK flip-flop with only a D-type flip-flop and gates. Note: Qold is the output of the D flip-flop before the positive clock edge.

// J	K	Q
// 0	0	Qold
// 0	1	0
// 1	0	1
// 1	1	~Qold

// module top_module (
//     input clk,
//     input j,
//     input k,
//     output Q);

//     always @( posedge clk) begin
//         case ({j,k})
//             2'b00: Q <= Q;
//             2'b01: Q <= 1'b0;
//             2'b10: Q <= 1'b1;
//             2'b11: Q <= ~Q;
//         endcase
//     end
// endmodule


// ============================================================
//                    MODULO: Edge detection
//               		bit-to-bit
// ============================================================

// For each bit in an 8-bit vector, detect when the input signal changes from 0 in one clock cycle to 1 the next (similar to positive edge detection). The output bit should be set the cycle after a 0 to 1 transition occurs.

// Here are some examples. For clarity, in[1] and pedge[1] are shown separately.
// See https://hdlbits.01xz.net/wiki/Edgedetect

// module top_module (
//     input clk,
//     input [7:0] in,
//     output reg [7:0] pedge
// );
//     reg [7:0] last;

//     always @(posedge clk) begin
//         // Guardamos el valor actual para usarlo como referencia en el siguiente ciclo
//         last <= in;

//         // Detectamos el flanco positivo bit a bit:
//         // bits que ahora son 1 (in) y antes eran 0 (~last)
//         pedge <= in & ~last;
//     end

// endmodule

// Mi primera solucion fue tomando todo el vector pero esto no es correcto porque no detecta bit a bit.
// module top_module (
//     input clk,
//     input [7:0] in,
//     output [7:0] pedge

// );

//     reg [7:0] last;
//     always @(posedge clk) begin
//         last <= in;
//         if(in != 8'h00 & in != last)
//         pedge <= in;
//         else pedge <= 8'h00;
//     end

// endmodule


// ============================================================
//                    MODULO: Edgedetect2
//               		bit-to-bit
// ============================================================

// For each bit in an 8-bit vector, detect when the input signal changes from one clock cycle to the next (detect any edge). The output bit should be set the cycle after a 0 to 1 transition occurs.

// Here are some examples. For clarity, in[1] and anyedge[1] are shown separately
// See https://hdlbits.01xz.net/wiki/Edgedetect2

// module top_module (
//     input clk,
//     input [7:0] in,
//     output [7:0] anyedge
// );
//     reg [7:0]last;
//     always @(posedge clk) begin
//         last <= in;
//         anyedge <= in ^ last;
//     end
// endmodule


// ============================================================
//                    MODULO: Edgecapture
//               		32-bit
// ============================================================
// For each bit in a 32-bit vector, capture when the input signal changes from 1 in one clock cycle to 0 the next. "Capture" means that the output will remain 1 until the register is reset (synchronous reset).

// Each output bit behaves like a SR flip-flop: The output bit should be set (to 1) the cycle after a 1 to 0 transition occurs. The output bit should be reset (to 0) at the positive clock edge when reset is high. If both of the above events occur at the same time, reset has precedence. In the last 4 cycles of the example waveform below, the 'reset' event occurs one cycle earlier than the 'set' event, so there is no conflict here.

// In the example waveform below, reset, in[1] and out[1] are shown again separately for clarity.
//See https://hdlbits.01xz.net/wiki/Edgecapture
// For this solution like the reset has priority there is an if to restart and an else to set the change.
// Also use the last state to compare but if the state is set will not change because of the or operator.
// module top_module (
//     input clk,
//     input reset,
//     input [31:0] in,
//     output [31:0] out
// );
//     reg [31:0] last;	
//     always @(posedge clk) begin
//         if(reset) out <= 0;
//         else out <= ~in & last | out;
//         last <= in;
//     end
// endmodule

// ============================================================
//                    MODULO: Dualedge
//               		
// ============================================================

//You're familiar with flip-flops that are triggered on the positive edge of the clock, or negative edge of the clock. A dual-edge triggered flip-flop is triggered on both edges of the clock. However, FPGAs don't have dual-edge triggered flip-flops, and always @(posedge clk or negedge clk) is not accepted as a legal sensitivity list.

// Build a circuit that functionally behaves like a dual-edge triggered flip-flop:
// Se https://hdlbits.01xz.net/wiki/Dualedge

// module top_module(
// 	input clk,
// 	input d,
// 	output q);
	
// 	reg p, n;
	
// 	// A positive-edge triggered flip-flop
//     always @(posedge clk)
//         p <= d ^ n;
        
//     // A negative-edge triggered flip-flop
//     always @(negedge clk)
//         n <= d ^ p;
    
//     // Why does this work? 
//     // After posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
//     // After negedge clk, n changes to d^p. Thus q = (p^n) = (p^d^p) = d.
//     // At each (positive or negative) clock edge, p and n FFs alternately
//     // load a value that will cancel out the other and cause the new value of d to remain.
//     assign q = p ^ n;
    
    
// 	// Can't synthesize this.
// 	/*always @(posedge clk, negedge clk) begin
// 		q <= d;
// 	end*/
    
    
// endmodule