//Data:  20181218      
//Engineer :  JiangNan WU
// function : Forwarding Unit  , handling data association
// signal:   	ForwardA ¡ªcontrol signal of  MUX_OperandA
//					ForwardB ¡ªcontrol signal of  MUX_OperandB

module Forwarding(
	// Input
	RsAddr_ex,RtAddr_ex,
	RegWrite_mem,RegWriteAddr_mem,
	RegWrite_wb,RegWriteAddr_wb,
	
	// Output
	ForwardA,ForwardB
);
	input [4:0]RsAddr_ex,RtAddr_ex;
	input RegWrite_mem;
	input [4:0]RegWriteAddr_mem;
	input RegWrite_wb;
	input [4:0]RegWriteAddr_wb;
	
	output [1:0]ForwardA;
	output [1:0]ForwardB;
	
	assign ForwardA[0] = RegWrite_wb && ( RegWriteAddr_wb != 0)
												&& (RegWriteAddr_mem != RsAddr_ex) 
												&& ( RegWriteAddr_wb == RsAddr_ex);             
 	assign ForwardA[1] =  RegWrite_mem && ( RegWriteAddr_mem != 0)
												&& ( RegWriteAddr_mem == RsAddr_ex);         //
												
	assign ForwardB[0] = RegWrite_wb && ( RegWriteAddr_wb != 0)
												&& (RegWriteAddr_mem != RtAddr_ex) 
												&& ( RegWriteAddr_wb == RtAddr_ex);
 	assign ForwardB[1] =  RegWrite_mem && ( RegWriteAddr_mem != 0)
												&& ( RegWriteAddr_mem == RtAddr_ex);
												
endmodule
