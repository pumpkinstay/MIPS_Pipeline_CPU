module MUX_4to1(out,in0,in1,in2,in3,addr);
  parameter n=1;            	 //n is the number of input/output 
  output reg[n-1:0] out;
  input[n-1:0] in0,in1,in2,in3;	     
  input [2:0]addr;
  
  always @(*)
		begin 
			 case(addr)
				3'b000:	out = in0;
				3'b001:	out = in1;	
				3'b010:	out = in2;
				3'b100:   out = in3;		
				default:  out=0;      // error: out =0;
			 endcase
		end

endmodule