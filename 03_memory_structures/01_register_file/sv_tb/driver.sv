
`ifndef DRIVER_SV
`define DRIVER_SV

`include "reg_if.sv"
`include "transaction.sv"

class driver;

    // Virtual interface
    virtual reg_if vif;

    // Constructor
    function new(virtual reg_if vif);
        this.vif = vif;
    endfunction

    // Initialize DUT inputs
    task reset_signals();

        vif.we         = 0;
        vif.write_addr = 0;
        vif.write_data = 0;
        vif.read_addr1 = 0;
        vif.read_addr2 = 0;

    endtask

    // Apply transaction to DUT
    task drive(transaction tr);
        @(negedge vif.clk);

        vif.we         = tr.we;
        vif.write_addr = tr.write_addr;
        vif.write_data = tr.write_data;
        vif.read_addr1 = tr.read_addr1;
        vif.read_addr2 = tr.read_addr2;

        @(posedge vif.clk);
        #2; 
    endtask

endclass

`endif
