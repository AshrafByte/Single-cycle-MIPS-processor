module regFile
(
	input clk, writeEn,
	input [4:0]	readReg1, readReg2, writeReg, 
	input [31:0] writeData,
	output reg [31:0]	readData1, readData2
);
	reg [31:0] rf [31:0] ;
	
	always @(posedge clk) 
		if (writeEn)
			rf[writeReg] <= writeData ;
	
	always @(*) begin
		rf[0] = 32'd0;
		readData1 = rf[readReg1];
		readData2 = rf[readReg2];
	end	
	
endmodule