module signExt
(
	input [15:0] in ,
	output [31:0] result
);
	wire sign;
	assign sign = in [15];
	assign result = {{16{sign}},in} ;
endmodule
