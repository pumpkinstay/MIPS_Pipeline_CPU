//20181217    JiangNan WU
//Forwarding Detector :  data association ¡ª Read After Write 

module ForwardDetector( 
	// Input
	RsAddr_id, RtAddr_id, RegWrite_wb,RegWriteAddr_wb,
	// Output
	RsSel,RtSel
);
	
	input [4:0]RsAddr_id;
	input [4:0]RtAddr_id;
	input RegWrite_wb;
	input [4:0]RegWriteAddr_wb;
	output RsSel;
	output RtSel;
	
	// RsSel = 0 : RsData ;     1 : RegWriteData_wb    
	assign RsSel = RegWrite_wb && (  RegWriteAddr_wb != 5'b0) && ( RegWriteAddr_wb == RsAddr_id);
	// RtSel = 0 : RtData ; 		1 : RegWriteData_wb
	assign RtSel = RegWrite_wb && (  RegWriteAddr_wb != 5'b0) && ( RegWriteAddr_wb == RtAddr_id);
	
endmodule

