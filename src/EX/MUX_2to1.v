module MUX_2to1(out,in0,in1,addr);
  parameter n=1;            	 //n is the number of input/output 
  output[n-1:0] out;
  input[n-1:0] in0,in1;	     
  input addr;
	assign out=addr?in1:in0;     // if  addr=1，out=in1, or out=in0
endmodule