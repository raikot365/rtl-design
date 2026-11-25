`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

class scoreboard;

    // Modelo de referencia: 8 registros de 16 bits
    logic [15:0] model [0:7];
    bit valid [0:7];

    int total_checks;
    int errors;

    function new();
        total_checks = 0;
        errors = 0;

        // Al no existir reset en el DUT, inicialmente
        // ningún registro tiene un valor conocido.
        foreach (valid[i]) begin
            valid[i] = 0;
            model[i] = '0;
        end
    endfunction

    task check(
        input logic we,
        input logic [2:0] write_addr,
        input logic [15:0] write_data,
        input logic [2:0] read_addr1,
        input logic [2:0] read_addr2,
        input logic [15:0] actual1,
        input logic [15:0] actual2
    );

        // Actualizar el modelo si hubo una escritura.
        if (we) begin
            model[write_addr] = write_data;
            valid[write_addr] = 1;
        end

        // Comparar la primera salida de lectura.
        if (valid[read_addr1]) begin
            total_checks++;

            if (actual1 !== model[read_addr1]) begin
                errors++;
                $error(
                    "[SCOREBOARD] ERROR read_data1: addr=%0d expected=%h actual=%h",
                    read_addr1, model[read_addr1], actual1
                );
            end else begin
                $display(
                    "[SCOREBOARD] OK read_data1: addr=%0d data=%h",
                    read_addr1, actual1
                );
            end
        end

        // Comparar la segunda salida de lectura.
        if (valid[read_addr2]) begin
            total_checks++;

            if (actual2 !== model[read_addr2]) begin
                errors++;
                $error(
                    "[SCOREBOARD] ERROR read_data2: addr=%0d expected=%h actual=%h",
                    read_addr2, model[read_addr2], actual2
                );
            end else begin
                $display(
                    "[SCOREBOARD] OK read_data2: addr=%0d data=%h",
                    read_addr2, actual2
                );
            end
        end

    endtask

    task report();
        $display("");
        $display("========== SCOREBOARD REPORT ==========");
        $display("Total checks : %0d", total_checks);
        $display("Errors       : %0d", errors);

        if (errors == 0)
            $display("RESULT       : PASS");
        else
            $display("RESULT       : FAIL");

        $display("========================================");
    endtask

endclass

`endif