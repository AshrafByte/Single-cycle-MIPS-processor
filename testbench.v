module testbench();
	reg	clk;
	reg   reset;
	wire [31:0] memWriteData, memDataAddr; // mem_dataAddress is the output of the processor main ALU (ALUOut).
	wire memWrite;
// instantiate device to be tested
singleCyclePro uut (clk, reset, memWriteData, memDataAddr, memWrite);
// initialization
initial
	begin
		reset = 1; 
		# 1;
		reset = 0;
	end
// generate clock to sequence tests
always
	begin
		clk = 1; 
		# 5; 
		clk = 0;
		# 5;
	end

endmodule