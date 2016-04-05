`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:12:28 04/05/2016 
// Design Name: 
// Module Name:    MEM_WB_Stage 
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
module MEM_WB_Stage(
	input clk,
    input rst,
	 input wen_in,
    input [`DSIZE-1:0] w_data_in,
    input [`ASIZE-1:0]w_addr_in,
	 input [`ISIZE-1:0]PC_in,
	 input MemtoReg_in,
	 input [`DSIZE-1:0] readMem_in,
	 
	 output reg [`ISIZE-1:0] PC_out,
	 output reg[`DSIZE-1:0] w_data_out,
    output reg[`ASIZE-1:0] w_addr_out,
	 output reg wen_out,
	 output reg MemtoReg_out,
	 output reg [`DSIZE-1:0] readMem_out
    );
	 
	 always @ (posedge clk)
	 begin
		if(rst)
		begin
			PC_out <= 0;
			w_data_out <= 0;
			w_addr_out <= 0;
			wen_out <= 0;
			MemtoReg_out <= 0;
			readMem_out <= 0;
		end
		else
		begin
			PC_out <= PC_in;
			w_data_out <= w_data_in;
			w_addr_out <= w_addr_in;
			wen_out <= wen_in;
			MemtoReg_out <= MemtoReg_in;
			readMem_out <= readMem_in;
		end
	end

endmodule
