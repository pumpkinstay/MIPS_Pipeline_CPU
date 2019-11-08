//20181217    JiangNan WU
//Hazard Detector , handling load-use data hazard
module  HazardDetector( 
	// Input
	MemRead_ex, RegWriteAddr_ex, 
	RsAddr_id, RtAddr_id,

	// Output
	stall,PC_IFWrite);
	input [4:0]RsAddr_id;
	input [4:0]RtAddr_id;
	input MemRead_ex;
	input [4:0]RegWriteAddr_ex;
	
	output stall;
	output PC_IFWrite;
 
   // if hazard exists, stall =1  , PC_IFWrite = 0  
	assign stall = MemRead_ex &&( ( RegWriteAddr_ex == RsAddr_id ) || (RegWriteAddr_ex == RtAddr_id) ) ; 
	assign PC_IFWrite = ~stall;
	
endmodule
