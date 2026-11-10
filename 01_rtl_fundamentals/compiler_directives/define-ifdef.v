// `define, `ifdef

`include "nor_dut. v"
`define AND_OP

module dut(
input i1, i2,
output out1, out2, out3

);
    `ifdef AND_OP
        assign out1 = i1 & i2;
    `else
        assign out2 = i1 | i2;
        nor_dut n1(out3, i1, i2);
    `endif

endmodule

// *Compile option syntax is Simulator specific
// . -DAND_OP in icarus
// · +define+AND_OP in cadence xcelium, Questa, synopsis vcs