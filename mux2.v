module mux2  #(parameter bits = 1) 
(
	input sel,
	input  [bits - 1 : 0] in1 , in2,
	output [bits - 1 : 0] out
);
	assign out = sel ?  in2 : in1 ;
endmodule
