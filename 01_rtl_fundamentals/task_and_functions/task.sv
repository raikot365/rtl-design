// Example for Tasks
// an example design illustrating how to count the zeros in a byte.
module zero_count_task (data, out);
input [7:0] data;
input [7:0] datal;
input [7:0] data3;
output reg [3:0] out; // output declared as register

always @(data) begin
    count_0s_in_byte(data, out); // task declaration or usage
    count_0s_in_byte(data1, out); // task declaration or usage
    count_0s_in_byte(datal, out); // task declaration or usage
end

// task definition is here.
task count_0s_in_byte(input [7:0] data_in, output reg [3:0] count);
integer i;
begin // task body
    count = 0;
        for (i = 0; i <= 7; i = i + 1)
            if (data_in[i] == 0) count= count + 1;
end
endtask

endmodule