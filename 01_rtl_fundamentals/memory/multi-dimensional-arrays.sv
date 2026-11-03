// Multi-Dimensional Arrays
// . Multi-dimensional arrays allow for the creation of matrices or tables.
reg [7:0] my_2d_array [0:15] [0:7]; // 16x8 matrix, each element is 8 bits wide

// . This is a 2D array (matrix) with 16 rows and 8 columns.
// Each element is 8 bits wide.

initial begin
    my_2d_array[0][0] = 8'hFF; // Assign 0xFF to element [0][0]
    my_2d_array[1][2] = 8'hAA; // Assign 0xAA to element [1][2]
    $display("Element [0][0]: %h", my_2d_array[0][0]);
    $display("Element [1][2]: %h", my_2d_array[1][2]);
end

// <data-type> [size] <array-name> [num.rows] [num.columns]; // two-dimensional array declaration
// reg [31:0] my_array [2][6]; // 2 rows, 6 columns, each element is 32 bits wide
// reg [31:0] my_array [0:1][0:5]; // 2 rows, 6 columns, each element is 32 bits wide