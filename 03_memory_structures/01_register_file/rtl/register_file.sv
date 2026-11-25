`timescale 1ns/1ns
module register_file #(
    parameter int WIDTH_REG = 16,
    parameter int NUM_REGS = 8,
    localparam int WIDTH_ADDR = ($clog2(NUM_REGS) == 0) ? 1 : $clog2(NUM_REGS)
    )(   
    input logic clk,
    input logic we,
    input logic [WIDTH_ADDR-1:0] write_addr,
    input logic [WIDTH_REG-1:0] write_data,
    input logic [WIDTH_ADDR-1:0] read_addr1,
    input logic [WIDTH_ADDR-1:0] read_addr2,
    output logic [WIDTH_REG-1:0] read_data1,
    output logic [WIDTH_REG-1:0] read_data2
);
    
    logic [WIDTH_REG-1:0] regs [NUM_REGS-1:0];

    always_ff @(posedge clk) begin
        if (we) begin
            regs[write_addr] <= write_data;
        end
    end

    always_comb begin
        read_data1 = regs[read_addr1];
        read_data2 = regs[read_addr2];
    end

endmodule