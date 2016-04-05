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
    input [`ASIZE-1:0] w_addr_in,
    input [`DSIZE-1:0] w_data_in,
	 input [`DSIZE-1:0] Rdata2_in,
	 input memWrite_in,
	 input memRead_in,
	 input memToReg_in,
	 input wen_in,
	 input [`ISIZE-1:0] PC_in,
	 
	 output reg [`ASIZE-1:0] w_addr_out,
    output reg [`DSIZE-1:0] w_data_out,
	 output reg [`DSIZE-1:0] Rdata2_out,
	 output reg memWrite_out,
	 output reg memRead_out,
	 output reg memToReg_out,
	 output reg wen_out,
	 output reg [`ISIZE-1:0] PC_out
    );
	 
	 always @ (posedge clk)
	 begin
		if(rst)
		begin
			w_addr_out <= 0;
			w_data_out<= 0;
			Rdata2_out <= 0;
			memWrite_out <=0;
			memRead_out <= 0;
			memToReg_out <= 0;
			wen_out <= 0;
			PC_out <= 0;
		end
		else
		begin
			w_addr_out <= w_addr_in;
			w_data_out<= w_data_in;
			Rdata2_out <= Rdata2_in;
			memWrite_out <= memWrite_in;
			memRead_out <= memRead_in;
			memToReg_out <= memToReg_in;
			wen_out <= wen_in;
			PC_out <= PC_in;
		end
	end


endmodule
