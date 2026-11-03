timescale 1ns/1ns;

module clock_generator;
reg clk1;
reg clk2;

// clock generation using always, 50% duty cycle
initial clk1=0; //0 ns
always #5 clk1 =~ clk1; // Period 10ns, Freq 100MHz

// clock generation using forever, 50% duty cycle

initial begin
clk1=0; //0 ns
forever #10 clk1 =~ clk1; // Period 20ns, Freq 50MHz
end

// 10% Duty cycle, Period 20ns, Freq 50MHz
always begin
#9 clk2 = 1;//on period
#1 clk2 = 0 ;// off period
end

initial
#100 $finish;

endmodule