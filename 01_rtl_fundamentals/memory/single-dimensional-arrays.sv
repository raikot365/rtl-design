// Single-Dimensional Arrays
// . Single-dimensional arrays are often used to store values like memory or a set of registers.
reg [7:0] my_array [0:15]; // Array of 16 elements, each 8 bits wide
// reg [7:0] my_array [6]; // compact declaration of 6 elements, each 8 bits wide
// reg [7:0] my_array [5:0]; // explicit declaration of 6 elements, each 8 bits wide
initial begin
    my_array[0] = 8'hAA; // Assign 0xAA to the first element
    my_array[1] = 8'hBB; // Assign 0xBB to the second element
    $display("First element: %h", my_array[0]);
    $display("Second element: %h", my_array[1]);
end