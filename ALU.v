module ALU
( 
	input [2:0] controls,
	input signed [31:0] in1, in2, 
	output reg signed [31:0] result ,
	output z // zero flag
);
	always @(*)
		case(controls)
			3'b010: result = 	in1 +  in2 	;
			3'b110: result = 	in1 -  in2 	;
			3'b000: result = 	in1 &  in2 	;
			3'b001: result = 	in1 |  in2 	;
			3'b111: result = (in1 <  in2) ;
			default : result = 3'dx ;
		 endcase
	assign z = (in1 == in2) ;
endmodule
