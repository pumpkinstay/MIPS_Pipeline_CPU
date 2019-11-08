`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  ZJU
// Engineer:  JiangNan WU   
// Create Date:    17/12/2018 
// Description:   WB(write back) stage of pipeline CPU 
//
//////////////////////////////////////////////////////////////////////////////////
module WB(MemToReg_wb, MemDout_wb, ALUResult_wb, RegWriteData_wb);
		input MemToReg_wb; 
		input [31:0] MemDout_wb;
		input [31:0] ALUResult_wb;
		output [31:0] RegWriteData_wb;
		
		
		// select write back data , MemToReg_wb = 0 (from ALUResult) ; 1(from DataRAM)
		MUX_2to1 #(.n(32)) WBDataSelector(
				.in0(ALUResult_wb),
				.in1(MemDout_wb),
				.addr(MemToReg_wb),
				.out(RegWriteData_wb) );
		

endmodule
