module flipflop
(
	input clk , reset ,
	input [31:0] d,
	output reg [31:0] q
);
	always @(posedge clk , posedge reset)
		if (reset)
			q <= 32'd0 ;
		else
			q <= d ;
		
endmodule