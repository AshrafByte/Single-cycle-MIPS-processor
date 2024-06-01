module instr_memory
(	input [5:0] address,
	output [31:0] readData
);
	reg [31:0] memory[63:0];
	initial
		$readmemh("memfile.dat", memory);
	assign readData = memory[address]; 
endmodule