// Example for Functions
//Define a module that contains the function calc_parity
module parity;
//...
reg [31:0] addr; //32bit
reg parity;
//Compute new parity whenever address value changes
always @(addr)
begin
    parity = calc_parity(addr); //First invocation of calc_parity
    $display("Parity calculated = %b", calc_parity(addr) ); //Second invocation of
calc_parity
end
//...
//...
//define the parity calculation function
function calc_parity;
input [31:0] address; //32
begin
    //set the output value appropriately. Use the implicit
    //internal register calc_parity.
    calc_parity = ^address; //Return the xor of all address bits.
end
endfunction
//...
//...
endmodule