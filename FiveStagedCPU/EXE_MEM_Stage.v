`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:40:49 04/05/2016 
// Design Name: 
// Module Name:    EXE_MEM_Stage 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module EXE_MEM_Stage(
    input clk,
    input rst,
    input [`ASIZE-1:0] alu_out,
	 input [`DSIZE-1:0] rdata2,
	 input MemWriteIn,
	 input MemReadIn,
	 input MemToRegIn,
    output reg [`ASIZE-1:0] addr,
    output reg [`DSIZE-1:0] wdata,
	 output MemWriteOut,
	 output MemReadOut,
	 output MemToRegOut
    );
	 
	 always @ (posedge clk)
	 begin
		if(rst)
		begin
			addr <= 0;
			wdata<= 0;
			MemWriteOut <=0;
			MemReadOut <= 0;
			MemToRegOut <= 0;
		end
		else
		begin
			addr <= alu_out;
			wdata <= rdata2;
			MemWriteOut <= MemWriteIn;
			MemReadOut <= MemReadIn;
			MemToRegOut <= MemToRegIn;
		end
	end


endmodule
