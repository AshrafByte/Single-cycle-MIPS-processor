module singleCyclePro
(
	input clk , reset,
	output [31:0] memWriteData , memDataAddr, // memDataAddress is the output of the processor main ALU (ALUOut).
	output memWrite
);
 wire [31:0] PC , instr , memReadData ;
 data_memory dm 
 (
	.writeEn(memWrite),
	.clk(clk),
	.address(memDataAddr),
	.writeData(memWriteData),
	.readData(memReadData)
 );
 instr_memory im
 (
	.address(PC[7:2]), // for testing we will use 18 address , so 5 bits should be enough, and we ignored first 2 bits for word allignment. 
	.readData(instr)
 );
 mips m 
 (
	.clk(clk),
	.reset(reset),
	.readData(memReadData),
	.instr(instr),
	.PC(PC),
	.ALUOut(memDataAddr),
	.writeData(memWriteData),
	.memWrite(memWrite)
 );
endmodule