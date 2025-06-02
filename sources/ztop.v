// Basic Top Module for my
// Basys 3 Board, ARTIX-7 FPGA Module
module ztop(
	input	clk, 
	input sw, 
	output reg led);
	
	always @(posedge clk)
		led = sw;

endmodule
