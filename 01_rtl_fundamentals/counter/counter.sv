module counter (
    input clk, rst;
    output logic [3:0] count_out
)
    


endmodule

module ff_jk(
    input logic j, k, clk, rst,
    output logic q
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q <= 1'b0;
        end
        else begin
            case ({j, k}) // Se concatena j y k para analizar los casos posibles
                2'b00: q <= q;        // No change
                2'b01: q <= 1'b0;     // Reset
                2'b10: q <= 1'b1;     // Set
                2'b11: q <= ~q;       // Toggle
            endcase
        end
    end
endmodule