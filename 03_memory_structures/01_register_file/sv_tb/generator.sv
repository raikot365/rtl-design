`ifndef GENERATOR_SV
`define GENERATOR_SV

`include "transaction.sv"
`include "driver.sv"

class generator;

    int num_transactions;
    driver drv;

    function new(driver drv, int num_transactions = 10);
        this.drv = drv;
        this.num_transactions = num_transactions;
    endfunction

    task run();
        transaction tr;

        for (int i = 0; i < num_transactions; i++) begin
            tr = new(i);

            if (tr.randomize() == 1) begin
                tr.print();
                drv.drive(tr);
            end
            else begin
                $fatal(1, "Generator: randomization failed at transaction %0d", i);
            end
        end
    endtask

endclass

`endif