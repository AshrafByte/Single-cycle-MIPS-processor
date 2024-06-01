module controller
(
	input	[5:0] funct , Opcode,
	input zero,
	output reg 	regDst, 
					memToReg,
					memWrite,
					ALUSrc,
					regWrite,
					jump,
					PCSrc,
	output reg [2:0] ALU_controls
);
// Main control unit
	// instructions Opcode.
	localparam R    = 6'd 0 ;
	localparam addi = 6'd 8 ;
	localparam beq	 = 6'd 4	;
	localparam j 	 = 6'd 2 ;
	localparam sw   = 6'd 43 ;
	localparam lw 	 = 6'd 35 ;

	reg [1:0] ALUOp ;
	reg Branch;
	
	always @(*)
	begin
		case(Opcode)
			R		: 	begin	
							regDst 	= 1'b1  ; 
							ALUSrc 	= 1'b0  ; 
							memToReg = 1'b0  ; 
							regWrite = 1'b1  ; 
							memWrite = 1'b0  ; 
							Branch 	= 1'b0  ; 
							ALUOp 	= 2'b10 ; 
							jump 		= 1'b0  ; 
						end
							
			addi 	: 	begin	
							regDst 	= 1'b0 ; 
							ALUSrc 	= 1'b1 ; 
							memToReg = 1'b0 ; 
							regWrite = 1'b1 ; 
							memWrite = 1'b0 ; 
							Branch 	= 1'b0 ; 
							ALUOp 	= 2'b00 ; 
							jump 		= 1'b0 ; 
						end
							
			beq	: 	begin 	
							regDst 	= 1'bx ; 
							ALUSrc 	= 1'b0 ; 
							memToReg = 1'b0 ; 
							regWrite = 1'b0 ; 
							memWrite = 1'b0 ; 
							Branch 	= 1'b1 ; 
							ALUOp 	= 2'b01 ; 
							jump 		= 1'b0 ; 
						end
							
			j    : 	begin	
							regDst 	= 1'bx ; 
							ALUSrc 	= 1'bx ; 
							memToReg = 1'bx ; 
							regWrite = 1'b0 ; 
							memWrite = 1'b0 ; 
							Branch 	= 1'bx ; 
							ALUOp 	= 2'bxx ; 
							jump 		= 1'b1 ;	 
						end
							
			 lw 	: 	begin 	
							regDst 	= 1'b0 ; 
							ALUSrc 	= 1'b1 ; 
							memToReg = 1'b1 ; 
							regWrite = 1'b1 ; 
							memWrite = 1'b0 ; 
							Branch 	= 1'b0 ; 
							ALUOp 	= 2'b00 ; 
							jump 		= 1'b0 ; 
						end
						
			 sw 	: 	begin	
							regDst 	= 1'b0 ; 
							ALUSrc 	= 1'b1 ; 
							memToReg = 1'bx ; 
							regWrite = 1'b0 ; 
							memWrite = 1'b1 ; 
							Branch 	= 1'b0 ; 
							ALUOp 	= 2'b00 ; 
							jump 		= 1'b0 ; 
						end
							
			default : {regDst , ALUSrc , memToReg  , regWrite , memWrite , Branch , ALUOp , jump} = 9'dx ;
		endcase
		PCSrc = Branch & zero ;
	end
			
// ALU control unit
	always @(*)
		if (ALUOp == 2'b00)
			ALU_controls = 3'b010;	// add
		else if (ALUOp == 2'b01)
			ALU_controls = 3'b110;	// sub
		else
			case(funct) // R_format
				6'd32 : ALU_controls = 3'b010 ; // add
				6'd34 : ALU_controls = 3'b110 ; // subtract
				6'd36 : ALU_controls = 3'b000 ; // and 
				6'd37 : ALU_controls = 3'b001 ; // or
				6'd42 : ALU_controls = 3'b111 ; // set on less than
			 default : ALU_controls = 3'bxxx ; 
			endcase
endmodule
