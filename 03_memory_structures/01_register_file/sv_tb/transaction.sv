`ifndef TRANSACTION_SV
`define TRANSACTION_SV

class transaction;

    rand bit we;
    rand bit [2:0] write_addr;
    rand bit [15:0] write_data;
    rand bit [2:0] read_addr1;
    rand bit [2:0] read_addr2;

    int id;

    // Constraints
    constraint we_default {
        soft we == 1;
    }

    constraint read_addrs {
        read_addr1 != read_addr2;
    }

    // Constructor
    function new(int id = 0);
        this.id = id;
    endfunction

    // Print task
    task print();
        $display(
            "ID:%0d we:%b write_addr:%0d write_data:0x%04h read_addr1:%0d read_addr2:%0d",
            id, we, write_addr, write_data, read_addr1, read_addr2
        );
    endtask

    task run();
        if (this.randomize() == 1) begin
            print();
        end else begin
            $display("Randomization failed");
        end
    endtask

endclass

`endif