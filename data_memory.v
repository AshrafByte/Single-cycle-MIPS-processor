module data_memory
(
	input clk , writeEn,
	input[31:0] address , writeData,
	output [31:0] readData
);
 reg [31:0] memory [63:0] ;
 assign readData = memory[address[31:2]];
 always @(posedge clk)
	if (writeEn)
		memory[address[31:2]] <= writeData ;
endmodule
