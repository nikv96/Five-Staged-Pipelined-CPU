`timescale 1ns / 1ps
`include "define.v"
  
module pipelined_regfile_5stage(
clk, rst, fileid, 
PCOUT, INST, rdata1, rdata2, branch_ID_EXE, waddr_out_ID_EXE, PC_ID_EXE, PC_IN,
rdata1_ID_EXE, rdata2_ID_EXE, imm_ID_EXE, rdata2_imm_ID_EXE, alusrc_ID_EXE, aluop_ID_EXE, 
aluout, aluout_EXE_MEM,waddr_out_EXE_MEM, rdata2_EXE_MEM, regDst, MemWrite_EXE_MEM, MemRead_EXE_MEM, 
MemToReg_MEM_WB, wen_MEM_WB, aluout_MEM, aluout_WB, zero,res,readMem, waddr_MEM_WB, aluout_MEM_WB, 
waddr_jal, aluout_jal, jump, jal_out, jr);

//CLOCK,RESET AND FILE ID
input clk;												
input	rst;
input fileid; 
 
//STAGE FETCH
output [`ISIZE-1:0]PCOUT;

//STAGE DECODE
output [`DSIZE-1:0]INST;
output [`DSIZE-1:0] rdata1;
output [`DSIZE-1:0] rdata2;

//STAGE EXECUTE
output [`DSIZE-1:0] rdata1_ID_EXE;
output [`DSIZE-1:0] rdata2_ID_EXE;
output [`DSIZE-1:0] imm_ID_EXE;
output [`DSIZE-1:0] rdata2_imm_ID_EXE;
output [`ASIZE-1:0] waddr_out_ID_EXE;
output [`DSIZE-1:0] aluout;	
output zero;
output [`ISIZE-1:0] res;
output [`ISIZE-1:0]PC_ID_EXE;

//STAGE MEMORY
output [`ASIZE-1:0] waddr_out_EXE_MEM;	
output [`DSIZE-1:0] aluout_EXE_MEM;
output [`DSIZE-1:0] readMem;
output [`DSIZE-1:0] aluout_MEM;
output [`DSIZE-1:0] aluout_WB;		

//STAGE WRITE BACK
wire [`ASIZE-1:0] waddr_MEM_WB;//
wire [`DSIZE-1:0] aluout_MEM_WB;//	
output [`ASIZE-1:0] waddr_jal;//
output [`DSIZE-1:0] aluout_jal;//

//CONTROL SIGNALS
output branch_ID_EXE;
output alusrc_ID_EXE;
output [2:0]aluop_ID_EXE;
output regDst;
output memWrite_EXE_DM;
output memRead_EXE_DM;
output memToReg_WB;
output wen_DM_WB;	
output jump;
output jal_out;
output jr;

//PC
output [`ISIZE-1:0]PCIN;
wire [`ISIZE-1:0]PCNEXT;
wire [`ISIZE-1:0]PCAddr_mux;
wire [`ISIZE-1:0]PCAddr_mux2;
wire [`ISIZE-1:0]concatenator;

/*************************************** FETCH STAGE ****************************************/

PC1 pc(.clk(clk),.rst(rst),.nextPC(PCAddr_mux2),.currPC(PCOUT)); //PCOUT is your PC value and PCIN is your next PC


assign PCIN = PCOUT + 32'b1; //increments PC to PC +1
assign PCNEXT = (zero & branch_ID_EXE)?res:PCIN;
assign concatenator = {{PCIN[31:26]},{INST[25:0]}};
assign PCAddr_mux = jump? concatenator:PCNEXT ;
assign PCAddr_mux2 = jr?  rdata1:PCAddr_mux;

//instruction memory
memory im( .clk(clk), .rst(rst), .wen(1'b0), .addr(PCOUT), .data_in(32'b0), .fileid(4'b0),.data_out(INST));//note that memory read is having one clock cycle delay as memory is a slow operation

//initialization of regfiles is done as hardcoding here
wire wen;
wire memWrite;
wire memToReg;
wire memRead;
wire [2:0] aluop;
wire branch;
wire jal;

//Note: .alusrc not defined
control C0 (.inst_cntrl(INST[31:26]),.wen_cntrl(wen),.alusrc_cntrl(alusrc), .aluop_cntrl(aluop),
				.alusrc(alusrc),.regDst(regDst),.memWrite(memWrite),.memRead(memRead),.memToReg(memToReg),
				.branch(branch),.jump(jump),.jal(jal),.jr(jr));

//Mux
wire [4:0] waddr_in = RegDst? INST[15:11]:INST[20:16];
wire [`ASIZE-1:0] wra_addr = 16'b1111;
assign waddr_jal = jal_out? wra_addr:waddr_MEM_WB;
assign aluout_jal = jal_out? PC_MEM_WB:aluout_WB;

regfile  RF0 ( .clk(clk), .rst(rst), .wen(wen_MEM_WB), .raddr1(INST[25:21]), 
					.raddr2(INST[20:16]), .waddr(waddr_jal), 
					.wdata(aluout_jal), .rdata1(rdata1), .rdata2(rdata2));

//sign extension for immediate needs to be done for I type instuction.
//you can add that here
wire [`DSIZE-1:0]extended_imm;
assign extended_imm=({{16{INST[15]}},INST[15:0]});

/****************ID EXE PIPELINE******************/

wire wen_ID_EXE;
wire [2:0] aluop_ID_EXE;
wire regDst_ID_EXE;
wire memWrite_ID_EXE;
wire memRead_ID_EXE;
wire memToReg_ID_EXE;
wire jal_ID_EXE;

//Note: Discuss PCDelay
 
ID_EXE_stage ID_EXE(.clk(clk), .rst(rst), .rdata1_in(rdata1),
						.rdata2_in(rdata2),.imm_in(extended_imm),.opcode_in(aluop), 
						.alusrc_in(alusrc), .waddr_in(waddr_in), .waddr_out(waddr_out_ID_EXE),
						.imm_out(imm_ID_EXE), .rdata1_out(rdata1_ID_EXE), .rdata2_out(rdata2_ID_EXE),
						.alusrc_out(alusrc_ID_EXE), .opcode_out(aluop_ID_EXE)
						,wen_in(wen), .memWriteIn(memWrite), .memReadIn(memRead), .memToRegIn(memToReg), .branchIn(branch),
						.PC_in(PCIN),.wen_out(wen_ID_EXE),.memWrite_out(memWrite_ID_EXE),
					   .memRead_out(memRead_ID_EXE),.memToReg_out(memToReg_ID_EXE),.branch_out(branch_ID_EXE),
					   .PC_out(PC_ID_EXE),.jal_in(jal),.jal_out(jal_ID_EXE));
						
//immediate value is only zero extended. As we are concentrationg only on R type instuctions, this is not an issue.

wire [`DSIZE-1:0]rdata2_imm_ID_EXE=alusrc_ID_EXE ? imm_ID_EXE : rdata2_ID_EXE;// mux for selecting immedaite or the rdata2 value

/*****************ALU INSTANTIATION********/
alu ALU0 ( .a(rdata1_ID_EXE), .b(rdata2_imm_ID_EXE), .op(aluop_ID_EXE), .out(aluout), .zero(zero));//ALU takes its input from pipeline register and the output of mux.

assign res=PC_ID_EXE+imm_ID_EXE;

/***************** EXE MEM PIPELINE *********/


wire wen_EXE_MEM;
wire [`ISIZE-1:0] PC_EXE_MEM;
wire memToReg_EXE_MEM;
wire jal_EXE_MEM;

EXE_MEM_Stage EXE_MEM(.clk(clk),.rst(rst),.w_addr_in(waddr_out_ID_EXE),.w_data_in(aluout),.Rdata2_in(rdata2_ID_EXE),
					.memWrite_in(memWrite_ID_EXE),.memRead_in(memRead_ID_EXE),
					.memToReg_in(memToReg_ID_EXE),.wen_in(wen_ID_EXE),.w_addr_out(waddr_out_EXE_MEM),
					.w_data_out(aluout_EXE_MEM),.Rdata2_out(rdata2_EXE_MEM),.memWrite_out(memWrite_EXE_MEM),
					.memRead_out(memRead_EXE_MEM),.memToReg_out(memToReg_EXE_MEM),.wen_out(wen_EXE_MEM),
					.jal_in(jal_ID_EXE),.jal_out(jal_EXE_MEM),.PC_in(PC_ID_EXE),.PC_out(PC_EXE_MEM));


/*****************DATA MEMORY INSTATIATION*****/
memory dm( .clk(clk), .rst(rst), .wen(memWrite_EXE_MEM), .addr(aluout_EXE_MEM), .data_in(rdata2_EXE_MEM), 
				.fileid(4'b1000),.data_out(readMem));


/****************MEM WB PIPELINE***************/

wire wen_MEM_WB;
wire [`ISIZE-1:0]PC_MEM_WB;
wire memToReg_MEM;
wire [`ASIZE-1:0] waddr_out_MEM_WB;
wire [`DSIZE-1:0] readMem_WB;

MEM_WB_Stage MEM_WB (.clk(clk), .rst(rst), .w_addr_in(waddr_out_MEM_WB),
.w_data_in(aluout_MEM),.w_addr_out(waddr_MEM_WB),.w_data_out(aluout_MEM_WB),
.wen_in(wen_EXE_MEM),.wen_out(wen_MEM_WB),.PC_in(PC_EXE_MEM),.PC_out(PC_MEM_WB),
.jal_in(jal_EXE_MEM),.jal_out(jal_out),.MemtoReg_in(memToReg_EXE_MEM),.MemtoReg_out(memToReg_WB),.readMem_in(readMem),.readMem_out(readMem_WB));

assign aluout_WB = memToReg_WB? aluout_MEM_WB:readMem_WB;

endmodule


