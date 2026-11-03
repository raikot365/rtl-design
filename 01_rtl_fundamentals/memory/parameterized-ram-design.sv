// Parameterized RAM Design
end

module RAM #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 10) (
    input clk,                          // Clock signal
    input reset,                        // Reset signal
    input we,                           // Write enable
    input [ADDR_WIDTH-1:0] addr,        // Address input
    input [DATA_WIDTH-1:0] din,         // Data input
    output reg [DATA_WIDTH-1:0] dout    // Data output
);

// Declare the memory (1KB : 1024 locations of 8 bits each)
reg [DATA_WIDTH-1:0] mem [(2 ** ADDR_WIDTH)-1:0];   // Array of registers
                                                    // Memory size is 2^ADDR_WIDTH

// Read and write operations
always @(posedge clk or posedge reset) begin
    if (reset) begin
        dout ≤ 0;
    end
    else if (we) begin
        // Write operation
        mem[addr] ≤ din;
    end
    else begin
        // Read operation
        dout ≤ mem[addr];
    end
end

endmodule

// If ADDR_WIDTH is 10, then the memory size is 2^10 = 1024 locations, which is equivalent to 1KB of memory.
// Using ADDR_WIDTH - 1 the range is (0 to 1023)