module sll2 #(parameter bits = 1)
(
	input  [bits-1:0] in ,
	output [bits-1:0] out
);
	assign out = in << 2 ;
endmodule