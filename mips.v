module mips
(
	input clk , reset,
	input [31:0] readData , instr,
	output memWrite,
	output [31:0] PC , ALUOut , writeData
	
);
	wire zero ;
	wire regDst, PCSrc, memToReg, ALUSrc, regWrite, jump;
	wire [2:0] ALU_controls;
	
	controller controller
	(
		.funct(instr[5:0]),
		.Opcode(instr[31:26]),
		.zero(zero),
		.regDst(regDst), 
		.PCSrc(PCSrc),
		.memToReg(memToReg),
		.memWrite(memWrite),
		.ALUSrc(ALUSrc),
		.regWrite(regWrite),
		.jump(jump),
		.ALU_controls(ALU_controls)
	);
	dataPath dataPath
	(
		clk,reset,
		regDst, PCSrc, memToReg, ALUSrc, regWrite, jump,
		ALU_controls,
		instr, readData, writeData,
		PC,
		ALUOut,zero
	);
endmodule