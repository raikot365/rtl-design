`define DATA_WIDTH 16

// LC3 ALU Operations
`define OP_ALU_ADD    2'b00 // Add
`define OP_ALU_AND    2'b01 // And
`define OP_ALU_NOT    2'b10 // Not
`define OP_ALU_PASS   2'b11 // Pass a


module alu(
    input wire signed [`DATA_WIDTH-1:0] a,        // Operando A (con signo)
    input wire signed [`DATA_WIDTH-1:0] b,        // Operando B (con signo)
    input wire [1:0] aluk,                        // Señal de control de la ALU
    output reg signed [`DATA_WIDTH-1:0] alu_out   // Resultado de la ALU
);
    
    always@(*) begin 
        case (aluk)
            `OP_ALU_ADD: alu_out = a + b;
            `OP_ALU_AND: alu_out = a & b;
            `OP_ALU_NOT: alu_out = ~a;
            `OP_ALU_PASS: alu_out = a;
            default: alu_out = {`DATA_WIDTH{1'b0}};
        endcase
    end

endmodule