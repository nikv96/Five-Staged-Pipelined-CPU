`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:49:05 02/26/2016
// Design Name:   pipelined_regfile_4stage
// Module Name:   Y:/CE3001_Lab3/test_bench_4_stage_pipeline.v
// Project Name:  CE3001_Lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipelined_regfile_4stage
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench_4_stage_pipeline;

	// Inputs
	reg clk;
	reg rst;
	reg fileid;

	// Outputs
	wire [31:0] PCOUT;
	wire [31:0] INST;
	wire [31:0] rdata1;
	wire [31:0] rdata2;
	wire [31:0] rdata1_ID_EXE;
	wire [31:0] rdata2_ID_EXE;
	wire [31:0] imm_ID_EXE;
	wire [31:0] rdata2_imm_ID_EXE;
	wire [2:0] aluop_ID_EXE;
	wire alusrc_ID_EXE;
	wire [4:0] waddr_out_ID_EXE;
	wire [31:0] aluout;
	wire [31:0] aluout_EXE_WB;
	wire [4:0] waddr_out_EXE_WB;

	// Instantiate the Unit Under Test (UUT)
	pipelined_regfile_4stage uut (
		.clk(clk), 
		.rst(rst), 
		.fileid(fileid), 
		.PCOUT(PCOUT), 
		.INST(INST), 
		.rdata1(rdata1), 
		.rdata2(rdata2), 
		.rdata1_ID_EXE(rdata1_ID_EXE), 
		.rdata2_ID_EXE(rdata2_ID_EXE), 
		.imm_ID_EXE(imm_ID_EXE), 
		.rdata2_imm_ID_EXE(rdata2_imm_ID_EXE), 
		.aluop_ID_EXE(aluop_ID_EXE), 
		.alusrc_ID_EXE(alusrc_ID_EXE), 
		.waddr_out_ID_EXE(waddr_out_ID_EXE), 
		.aluout(aluout), 
		.aluout_EXE_WB(aluout_EXE_WB), 
		.waddr_out_EXE_WB(waddr_out_EXE_WB)
	);
always #15 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		fileid = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#25 rst =1;
		#25 rst=0;

	end
      
endmodule

