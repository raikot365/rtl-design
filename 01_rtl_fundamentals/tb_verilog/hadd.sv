module half_adder(
    input logic a, b,
    output logic sum, carry
);
    assign sum = a ^ b; // Sum is the XOR of inputs
    assign carry = a & b; // Carry is the AND of inputs

endmodule