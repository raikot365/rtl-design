`ifndef REG_IF_SV
`define REG_IF_SV

interface reg_if (input logic clk);

    // Write port
    logic we;
    logic [2:0] write_addr;
    logic [15:0] write_data;

    // Read ports
    logic [2:0] read_addr1;
    logic [2:0] read_addr2;

    // DUT outputs
    logic [15:0] read_data1;
    logic [15:0] read_data2;

endinterface

`endif
