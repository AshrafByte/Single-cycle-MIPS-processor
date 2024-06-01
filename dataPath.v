module dataPath
(
	input clk , reset ,
	input regDst, 
			PCSrc,
			memToReg,
			ALUSrc,
			regWrite,
			jump,
	input [2:0] ALU_controls,		
	input [31:0] instr , readData,   // instr -> data read from instruction memory , readData -> data read from data memory
	output [31:0] writeData,
	output [31:0] PC , ALUOut,
	output zero
);
	wire [31:0] srcA , srcB , immSignExt , PC_branch , PC4 , PC_next , mtr_out , branchOffset , pcs_out; 
	wire [4:0] rd_out ;
	
// memory to register Mux
	mux2 #(32) mtr ( .sel(memToReg), .in1(ALUOut), .in2(readData) , .out(mtr_out) );
	
// register destination Mux
	mux2 #(5)  rd  ( .sel(regDst), .in1(instr[20:16]), .in2(instr[15:11]) , .out(rd_out) );
	
// register file
	regFile rf 
	(
		.clk(clk),
		.writeEn(regWrite),
		.readReg1(instr[25:21]), 
		.readReg2(instr[20:16]), 
		.writeReg(rd_out),
		.writeData(mtr_out),
		.readData1(srcA),
		.readData2(writeData)
	);
// sign extension unit
	
	signExt se (.in(instr[15:0]) , .result(immSignExt) ) ;
	
// ALUSrc Mux
	mux2 #(32) alus ( .sel(ALUSrc), .in1(writeData), .in2(immSignExt) , .out(srcB) ); // immSignExt -> sign extended immediate.
	
// ALU unit
	ALU ALU ( .controls(ALU_controls), .in1(srcA) , .in2(srcB) , .result(ALUOut), .z(zero) ) ;
	
// shift left 2 unit for branch
	sll2 #(32) sll2b ( .in(immSignExt) , .out(branchOffset) );
	
// PC + 4 adder	
	add pc4 ( .in1(PC) , .in2(32'd4) , .result(PC4) );
	
// branch adder unit
	add ba ( .in1(PC4) , .in2(branchOffset) , .result(PC_branch) ) ;

// PCSrc Mux
	mux2 #(32) pcs ( .sel(PCSrc), .in1(PC4), .in2(PC_branch) , .out(pcs_out) );
	
// Jump Mux
	wire [31:0] jumpAddr;
	wire [25:0] jumpPesudo ;
	sll2 #(26) sll2j ( .in(instr[25:0]) , .out(jumpPesudo) );
	assign jumpAddr = {PC4[31:26], jumpPesudo};
	mux2 #(32) jumpMux ( .sel(jump), .in1(pcs_out), .in2(jumpAddr) , .out(PC_next) );
	
// PC flip flop
	flipflop ff (.clk(clk) , .reset(reset) , .d(PC_next) , .q(PC));
	
endmodule
