`timescale 1ns/1ns
module register_file_tb;
    localparam int WIDTH_REG  = 16;
    localparam int WIDTH_ADDR = 3;
    //inputs
    logic clk;
    logic we = 1'b0;
    logic [WIDTH_ADDR-1:0] write_addr = '0;
    logic [WIDTH_REG-1:0] write_data  = '0;
    logic [WIDTH_ADDR-1:0] read_addr1 = '0;
    logic [WIDTH_ADDR-1:0] read_addr2 = '0;
    //outputs
    logic [WIDTH_REG-1:0] read_data1;
    logic [WIDTH_REG-1:0] read_data2;

    register_file dut (
        .clk(clk),
        .we(we),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    task automatic check_read(
        input logic [WIDTH_ADDR-1:0] addr1,
        input logic [WIDTH_ADDR-1:0] addr2,
        input logic [WIDTH_REG-1:0] expected1,
        input logic [WIDTH_REG-1:0] expected2
    );
        read_addr1 = addr1;
        read_addr2 = addr2;
        #1;

        assert (read_data1 === expected1)
            else $fatal(1, "FAIL: read port 1, addr=%0d", addr1);//fatal stop the tb

        assert (read_data2 === expected2)
            else $fatal(1, "FAIL: read port 2, addr=%0d", addr2);
    endtask

    initial begin
        for (int i = 0; i < 8; i++) begin
            @(negedge clk);
            we = 1'b1;
            write_addr = i;
            write_data = 16'h1000 + i;
        end

        @(posedge clk);
        #1;
        we = 1'b0;
        #2;
        we = 1'b1;
        write_addr = 3'd0;
        write_data = 16'h1234;
        #10;
        write_addr = 3'd1;
        write_data = 16'hABCD;
        @(posedge clk);
        #1;
        we = 1'b0;

        read_addr1 = 3'd0;
        #1;
        read_addr2 = 3'd1;
        #1;
        check_read(read_addr1, read_addr2, 16'h1234, 16'hABCD);
        $display("read_data1 = 0x%04h, read_data2 = 0x%04h", read_data1, read_data2);

        #1;
        write_data = 16'hffff;
        @(posedge clk);
        
        $display("read_data1 = 0x%04h, read_data2 = 0x%04h", read_data1, read_data2);

        #1;
        read_addr1 = 3'd2;
        read_addr2 = 3'd2;
        #1;
        check_read(read_addr1, read_addr2, 16'h1002, 16'h1002);
        $display("read_data1 = 0x%04h, read_data2 = 0x%04h", read_data1, read_data2);

        #1;
        we = 1'b1;
        write_addr = 3'd4;
        write_data = 16'h1111;
        @(posedge clk);
        read_addr1 = 3'd4;
        read_addr2 = 3'd5;
        check_read(read_addr1, read_addr2, 16'h1111, 16'h1005);
        $display("read_data1 = 0x%04h, read_data2 = 0x%04h", read_data1, read_data2);
        $finish;
    end




endmodule