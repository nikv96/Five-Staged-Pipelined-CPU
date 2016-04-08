//control unit for write enable and ALU control

`include "define.v"

module control(
  input [5:0] inst_cntrl, 
  output reg wen_cntrl,
  output reg alusrc_cntrl,
  output reg regDst,
  output reg memWrite,
  output reg memRead,
  output reg memToReg,
  output reg branch,
  output reg [2:0] aluop_cntrl,
  output reg jump,
  output reg jal,
  output reg jr
  );
  
  always@(inst_cntrl)
  begin
 
    case(inst_cntrl)
			`ADD: begin
					wen_cntrl=1;
					alusrc_cntrl=0;
					aluop_cntrl=inst_cntrl[2:0];
					regDst=0;
					memWrite=0;
					memRead=0;
					memToReg=1;
					branch=0;
					jump = 0;
					jal = 0;
					jr = 0;
			end
        `SUB: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=1;
					 branch=0;
					 jump = 0;
					 jal = 0;
					 jr = 0;
        end
        `AND: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=1;
					 branch=0;
                jump = 0;
					 jal = 0;
					 jr = 0;
        end
        `XOR: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=1;
					 branch=0;
                jump = 0;
					 jal = 0;
					 jr = 0;
        end
     
        `COM: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=1;
					 branch=0;
					 jump = 0;
					 jal = 0;
					 jr = 0;
        end
        `MUL: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
                aluop_cntrl=inst_cntrl[2:0];
					 jump = 0;
					 jal = 0;
					 jr = 0;
					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=1;
					 branch=0;					 
			end
			
			`LW: begin
                wen_cntrl=1;
					 alusrc_cntrl=1;
 					 regDst=0;
					 memWrite=0;
					 memRead=1;
					 memToReg=0;
					 branch=0;
                aluop_cntrl=inst_cntrl[2:0];
					 jump = 0;
					 jal = 0;
					 jr = 0;
        end
		  `SW: begin
                wen_cntrl=0;
					 alusrc_cntrl=1;
 					 regDst=1;
					 memWrite=1;
					 memRead=0;
					 memToReg=0;
					 branch=0;
                aluop_cntrl=3'b000;
					 jump = 0;
					 jal = 0;
					 jr = 0;
        end
		  `BEQ: begin
                wen_cntrl=0;
					 alusrc_cntrl=0;
 					 regDst=1;
					 memWrite=0;
					 memRead=0;
					 memToReg=0;
					 branch=1;
                aluop_cntrl=inst[2:0];
					 jump = 0;
					 jal = 0;
					 jr = 0;
        end
		  
		  `JUMP: begin
                wen_cntrl=0;
					 alusrc_cntrl=0;
 					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=0;
					 branch=0;
					 aluop_cntrl=inst_cntrl[2:0];
					 //Note: jump control signal is enabled for this instruction 
					 jump = 1;
					 jal = 0;
					 jr = 0;
        end
		  
		  `JAL: begin
                wen_cntrl=1;
					 alusrc_cntrl=0;
 					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=0;
					 branch=0;
					 aluop_cntrl=inst_cntrl[2:0];
					 //Note: jump control signal is enabled for this instruction 
					 jump = 1;
					 jal = 1;
					 jr = 0;
        end
		  
		  `JR: begin
                wen_cntrl=0;
					 alusrc_cntrl=0;
 					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=0;
					 branch=0;
					 aluop_cntrl=inst_cntrl[2:0];
					 //Note: jr signal is enabled for this instruction 
					 jump = 0;
					 jal = 0;
					 jr = 1;
        end
		   
		  `NOP: begin
                wen_cntrl=0;
					 alusrc_cntrl=0;
 					 regDst=0;
					 memWrite=0;
					 memRead=0;
					 memToReg=0;
					 branch=0;
                aluop_cntrl=inst_cntrl[2:0];
					 jump = 0;
					 jal = 0;
					 jr = 0;
        end
			
		`ADDI: begin
                wen_cntrl=1;
					 alusrc_cntrl=1;
                aluop_cntrl=inst_cntrl[2:0];
					 regDst=0;
					 memWrite=0;
					 memRead=1;
					 memToReg=0;
					 branch=0;
        end
		  
		default: begin
				wen_cntrl=0;
				alusrc_cntrl=0;
				aluop_cntrl=inst_cntrl[2:0];
		end	
		
    endcase
  end
  
endmodule
