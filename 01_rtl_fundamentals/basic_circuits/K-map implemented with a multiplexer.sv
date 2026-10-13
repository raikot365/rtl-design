// https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q3

// For the following Karnaugh map, give the circuit implementation using one 4-to-1 multiplexer and as many 2-to-1 multiplexers as required, but using as few as possible. You are not allowed to use any other logic gate and you must use a and b as the multiplexer selector inputs, as shown on the 4-to-1 multiplexer below.

              
       ab 00  01  11  10
    cd   ┌────────────────┐
    00   │ 0   0   0   1  │
    01   │ 1   0   0   0  │
    11   │ 1   0   1   0  │
    10   │ 1   0   0   1  │
         └────────────────┘
                                                                   a b
                                                                   │ │
                                                                   ▼ ▼
                                                                 ┌────
                 ┌─────────────────────────┐                     │    \
          c ────►│                         │────► mux_in[0] ──►  │ 00  \
                 │                         │                     │      │
          d ────►│      Lógica combin.     │────► mux_in[1] ──►  │ 01   │
                 │                         │                     │      │----> f
                 │                         │────► mux_in[2] ──►  │ 10   │
                 │                         │                     │      │
                 │                         │────► mux_in[3] ──►  │ 11  /
                 └─────────────────────────┘                     │    /
                                                                 └────
                                                   

// You are implementing just the portion labelled top_module, such that the entire circuit (including the 4-to-1 mux) implements the K-map. 

// (The requirement to use only 2-to-1 multiplexers exists because the original exam question also wanted to test logic function simplification using K-maps and how to synthesize logic functions using only multiplexers. If you wish to treat this as purely a Verilog exercise, you may ignore this constraint and write the module any way you wish.)

//my solution

module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    always @(*) begin
        case ({c,d}) 
            2'b00: mux_in = 4'b0100;
            2'b01: mux_in = 4'b0001;
			2'b10: mux_in = 4'b0101;
            2'b11: mux_in = 4'b1001;
            endcase
        end

endmodule

// solution provided by HDLBits
// module top_module (
// 	input c,
// 	input d,
// 	output [3:0] mux_in
// );
	
// 	// After splitting the truth table into four columns,
// 	// the rest of this question involves implementing logic functions
// 	// using only multiplexers (no other gates).
// 	// I will use the conditional operator for each 2-to-1 mux: (s ? a : b)
// 	assign mux_in[0] = c ? 1 : d;          // 1 mux:   c|d
// 	assign mux_in[1] = 0;                  // No muxes:  0
// 	assign mux_in[2] = d ? 0 : 1;          // 1 mux:    ~d
// 	assign mux_in[3] = c ? d : 0;          // 1 mux:   c&d
	
// endmodule

