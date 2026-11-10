// The following is the state transition table for a Moore state machine with one input, one output, and four states. Use the following state encoding: A=2'b00, B=2'b01, C=2'b10, D=2'b11.

// Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. Given the current state (state), compute the next_state and output (out) based on the state transition table.

// State	Next state	    Output
//         in=0	in=1
// A	    A	    B	       0
// B	    C	    B	       0
// C	    A	    D	       0
// D	    C	    B	       1


module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;
    assign next_state = f(state,in);
    assign out = f_out(state);
    // State transition logic: next_state = f(state, in)
    function [1:0]f;
        input [1:0] st;
        input i;
        begin
            case(st)
                A: f = (i) ? B:A;
                B: f = (i) ? B:C;
                C: f = (i) ? D:A;
                D: f = (i) ? B:C;
            endcase
        end
    endfunction
    // Output logic:  out = f(state) for a Moore state machine
	function f_out;
        input [1:0]st;
        begin
            case(st)
                A: f_out = 0;
                B: f_out = 0;
                C: f_out = 0;
                D: f_out = 1;
            endcase
        end
    endfunction
            
endmodule