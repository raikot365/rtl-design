`timescale 1ns/1ns

`include "../rtl/register_file.sv"
`include "reg_if.sv"
`include "transaction.sv"
`include "driver.sv"
`include "generator.sv"
`include "monitor.sv"
`include "scoreboard.sv"

module testbench;

    logic clk;
    reg_if intf(clk);

    // Salidas del DUT conectadas a señales del módulo superior.
    logic [15:0] read_data1_mon;
    logic [15:0] read_data2_mon;

    // DUT
    register_file dut (
        .clk        (intf.clk),
        .we         (intf.we),
        .write_addr (intf.write_addr),
        .write_data (intf.write_data),
        .read_addr1 (intf.read_addr1),
        .read_addr2 (intf.read_addr2),
        .read_data1 (read_data1_mon),
        .read_data2 (read_data2_mon)
    );

    // Componentes del testbench
    driver drv;
    generator gen;
    monitor mon;
    scoreboard sb;

    // Señales para capturar las entradas en el flanco positivo.
    logic sample_we;
    logic [2:0] sample_write_addr;
    logic [15:0] sample_write_data;
    logic [2:0] sample_read_addr1;
    logic [2:0] sample_read_addr2;

    // Generación del reloj
    initial clk = 0;
    always #5 clk = ~clk;

    // Captura de entradas y comparación de salidas.
    always @(posedge clk) begin

        // Capturar las entradas antes de la actualización del DUT.
        sample_we         = intf.we;
        sample_write_addr = intf.write_addr;
        sample_write_data = intf.write_data;
        sample_read_addr1 = intf.read_addr1;
        sample_read_addr2 = intf.read_addr2;

        // Esperar a que se completen las asignaciones no bloqueantes
        // y se actualicen las salidas combinacionales.
        #1;

        $display(
            "[DUT OUTPUTS] read_data1=%h read_data2=%h",
            read_data1_mon,
            read_data2_mon
        );

        // Enviar los valores capturados al Scoreboard.
        sb.check(
            sample_we,
            sample_write_addr,
            sample_write_data,
            sample_read_addr1,
            sample_read_addr2,
            read_data1_mon,
            read_data2_mon
        );

    end

    // Inicialización y ejecución
    initial begin

        drv = new(intf);
        gen = new(drv, 10);
        mon = new(intf);
        sb  = new();

        drv.reset_signals();

        fork
            gen.run();
            mon.run();
        join_any

        disable fork;

        // Mostrar el resumen de las verificaciones.
        sb.report();

        $finish;
    end

endmodule