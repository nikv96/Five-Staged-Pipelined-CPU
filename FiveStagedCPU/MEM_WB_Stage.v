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
	input MemToRegIn,
	input addr_in,
	output MemToRegOut,
	output addr_out
    );
	 
	 always @ (posedge clk)
	 begin
		if(rst)
		begin
			addr_out <= 0;
			MemToRegOut <= 0;
		end
		else
		begin
			addr_out <= addr_in;
			MemToRegOut <= MemToRegIn;
		end
	end

endmodule
