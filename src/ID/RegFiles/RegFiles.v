//20181217    JiangNan WU
//RegFiles : Register files with Read After Write  function

module  RegFiles( 	
	// Outputs
	RsData_id, RtData_id,  

	// Inputs
	clk, RegWriteData_wb, RegWriteAddr_wb, RegWrite_wb, 
	RsAddr_id, RtAddr_id  
);

	input		clk;
	// Info for register write port
	input [31:0]	RegWriteData_wb;
	input [4:0]RegWriteAddr_wb;
	input		RegWrite_wb;
	input [4:0]	RsAddr_id, RtAddr_id;

	// Data from register read ports
	output [31:0]	RsData_id;		// data output for read port A
	output [31:0]	RtData_id;		// data output for read port B

	//  Forwarding singals
		wire RsSel , RtSel ;
		wire [31:0]RsData, RtData;
		
	// Forwarding  detector: Read After Write 
		ForwardDetector  ForwardDetector (
				.RsAddr_id(RsAddr_id), 
				.RtAddr_id(RtAddr_id), 
				.RegWrite_wb(RegWrite_wb),
				.RegWriteAddr_wb(RegWriteAddr_wb),
	
				.RsSel(RsSel),
				.RtSel(RtSel)  );	
		
	// Registers	
	Registers Registers(
		.clk(clk), 
		.WriteData(RegWriteData_wb), 
		.WriteAddr(RegWriteAddr_wb), 
		.RegWrite(RegWrite_wb), 
		.RsAddr(RsAddr_id), 
		.RtAddr(RtAddr_id) ,
		
		.RsData(RsData), 
		.RtData(RtData) );
		
	// select   RsAddr_id , RtData_id
		MUX_2to1 #(.n(32)) MUX_RsData(
				.in0(RsData),
				.in1(RegWriteData_wb),
				.addr(RsSel),
				.out(RsData_id) );
		MUX_2to1 #(.n(32)) MUX_RtData(
				.in0(RtData),
				.in1(RegWriteData_wb),
				.addr(RtSel),
				.out(RtData_id) );
endmodule
