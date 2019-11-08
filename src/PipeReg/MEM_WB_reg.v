`timescale 1ns / 1ps
//20181218   JiangNan WU
//function : MEM_WB Register

module MEM_WB_reg(
	clk,reset,       // reset : used for simulation
	
	//Input from Mem
	MemToReg_mem , RegWrite_mem,
	RegWriteAddr_mem,
	ALUResult_mem,
	MemDout_mem,
	
	//Output to WB
	MemToReg_wb , RegWrite_wb,
	RegWriteAddr_wb,
	ALUResult_wb,
	MemDout_wb
);
	input clk;
	input reset;    
	
	input MemToReg_mem ;
	input RegWrite_mem ;
	input [4:0]RegWriteAddr_mem ; 
	input [31:0]ALUResult_mem ; 
	input [31:0]MemDout_mem;
	
	output reg MemToReg_wb ; 
	output reg RegWrite_wb ; 
	output reg [4:0]RegWriteAddr_wb ; 
	output reg [31:0]ALUResult_wb ; 
	output reg  [31:0]MemDout_wb;


	always @(posedge clk) 
	begin
			if (reset)
			begin
				MemToReg_wb <= 1'b0;
				RegWrite_wb <= 1'b0;
				RegWriteAddr_wb <= 5'b0;
				ALUResult_wb <= 32'b0;
				MemDout_wb <= 32'b0;
			end
			
			else
			begin
			MemToReg_wb <= MemToReg_mem;
			RegWrite_wb <= RegWrite_mem;
			RegWriteAddr_wb <= RegWriteAddr_mem;
			ALUResult_wb <= ALUResult_mem;
			MemDout_wb <= MemDout_mem;
			end
	end
	
endmodule
