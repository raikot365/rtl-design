// Timing and Delays :

// # Delay: This is a simple delay that specifies a time delay after an event. It's the most common way to introduce delays in Verilog.

`timescale 1ns / 1ps // Specifies that the time unit is 1ns, with a precision of 1ps

a = b; // Assign 'b' to 'a'
#5 // Wait for 5 time units
c = a; // Assign 'a' to 'c' after 5 time units

assign #10 y = a & b; // 'y' is assigned the value of 'a & b' after 10 time units

and #(10) (out, in1, in2); // AND gate with 10-time unit delay

always @(posedge clk) begin // Trigger on rising edge of 'clk'
    // Action
end

always @ (posedge clk) begin
    #5 x = y; // x is assigned the value of y with a 5-time unit delay
end