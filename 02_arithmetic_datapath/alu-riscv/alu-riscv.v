
// Supported ALU Operations

// • ADD (Addition): Adds two operands (A + B).
// • SUB (Subtraction): Subtracts operand B from A (A - B).
// • AND (Bitwise AND): Performs a bitwise logical AND operation.
// • OR (Bitwise OR): Performs a bitwise logical OR operation.
// • XOR (Bitwise XOR): Performs a bitwise exclusive-OR operation.
// • SLT (Set Less Than - Signed): Compares two signed numbers and outputs 1 if A < B, else 0.
// • SLTU (Set Less Than - Unsigned): Compares two unsigned numbers and outputs 1 if A < B, else 0.
// • SLL (Shift Left Logical): Shifts bits of A to the left by the shift amount, filling with zeros.
// • SRL (Shift Right Logical): Shifts bits of A to the right, filling vacated high-order bits with zeros.
// • SRA (Shift Right Arithmetic): Shifts bits of A to the right while preserving the sign bit (two's complement)

`define DATA_WIDTH 32

// RISC-V ALU Operations
`define OP_ALU_ADD    6'b011001 // Add
`define OP_ALU_SUB    6'b011011 // Subtract
`define OP_ALU_AND    6'b011101 // Bitwise AND
`define OP_ALU_OR     6'b011111 // Bitwise OR
`define OP_ALU_XOR    6'b100001 // Bitwise XOR
`define OP_ALU_SLT    6'b100011 // Set Less Than (signed)
`define OP_ALU_SLTU   6'b100101 // Set Less Than (unsigned)
`define OP_ALU_SLL    6'b100111 // Shift Left Logical
`define OP_ALU_SRL    6'b101001 // Shift Right Logical
`define OP_ALU_SRA    6'b101011 // Shift Right Arithmetic

module alu (
    // INPUT
    input wire [5:0] i_alu_op,
    input wire [`DATA_WIDTH-1:0] i_a,
    input wire [`DATA_WIDTH-1:0] i_b,
    // OUTPUT
    output reg [`DATA_WIDTH-1:0] o_c
);

    always @(*) begin
        case (i_alu_op)
            `OP_ALU_ADD:  o_c = i_a + i_b; // ADD
            `OP_ALU_SUB:  o_c = i_a - i_b; // SUB
            `OP_ALU_AND:  o_c = i_a & i_b; // AND
            `OP_ALU_OR:   o_c = i_a | i_b; // OR
            `OP_ALU_XOR:  o_c = i_a ^ i_b; // XOR
            `OP_ALU_SLT:  o_c = ($signed(i_a) < $signed(i_b)) ? 1 : 0; // SLT (signed)
            `OP_ALU_SLTU: o_c = (i_a < i_b) ? 1 : 0; // SLTU (unsigned)
            `OP_ALU_SLL:  o_c = i_a << i_b[4:0]; // SLL
            `OP_ALU_SRL:  o_c = i_a >> i_b[4:0]; // SRL
            `OP_ALU_SRA:  o_c = $signed(i_a) >>> i_b[4:0]; // SRA
            default:      o_c = {`DATA_WIDTH{1'b0}}; // Default case
        endcase
    end


endmodule