`ifndef MONITOR_SV
`define MONITOR_SV

`include "reg_if.sv"

class monitor;

    virtual reg_if vif;

    function new(virtual reg_if vif);
        this.vif = vif;
    endfunction

    task run();
        forever begin
            @(posedge vif.clk);
            #1;

            $display(
                "[MONITOR] we=%b write_addr=%0d write_data=%h",
                vif.we,
                vif.write_addr,
                vif.write_data
            );
        end
    endtask

endclass

`endif