// Basic Top Module for my
// Basys 3 Board, ARTIX-7 FPGA Module
module ztop(
	input	     clk, 
	input      [15:0] sw,
	output reg [15:0] led
);

	for (genvar i = 0; i < 16; i = i + 1) begin
		always @(posedge clk)
			led[i] = sw[i];
	end

endmodule
