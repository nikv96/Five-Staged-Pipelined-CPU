`include "define.v"// defines DSIZE, ADD, SUB etc


module alu(
   a,   //1st operand
   b,   //2nd operand
   op,   //3-bit operation
   out,   //output
	zero //zero for branch
   );


   
   input [`DSIZE-1:0] a, b;
   input [2:0] op;
   output reg [`DSIZE-1:0] out;
   output reg zero;

	
      
always @(a or b or op )
begin
   case(op)
       `ADD: out = a+b;
       `SUB: out = a - b;
       `AND: out = a & b;
       `XOR:  out = a^b;
       `COM: out = a<=b;
       `MUL: out = a*b;
       `ADDI: out = a+b;
		 default: out = 0;  
   endcase
	if(a==b) begin
		zero=1;
	end
	else begin
		zero=0;
	end
end

endmodule
   
       
