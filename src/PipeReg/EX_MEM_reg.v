`timescale 1ns / 1ps
//20181218   JiangNan WU
//EX_MEM Register

module EX_MEM_reg( 
	clk,reset,       // reset : used for simulation
	
	//Input  from EX
	MemWrite_ex,  MemWriteData_ex,	
	RegWrite_ex, RegWriteAddr_ex,    			
	MemToReg_ex,		
	ALUResult_ex,	
	
	//Output to MEM
	MemWrite_mem,  MemWriteData_mem,  // for Mem operation
	RegWrite_mem, RegWriteAddr_mem,		// for WB operation
	MemToReg_mem, 
	ALUResult_mem
);
	input			clk;
	input			reset;
	input	[31:0]	ALUResult_ex;
	
	input	MemWrite_ex;
	input	[31:0]MemWriteData_ex;
	
	input	RegWrite_ex;
	input	MemToReg_ex;
	input	[4:0]	RegWriteAddr_ex;
	
	output	reg MemWrite_mem;
	output	reg	[31:0]MemWriteData_mem;
	output	reg RegWrite_mem;
	output	reg MemToReg_mem;
	output	reg [4:0]	RegWriteAddr_mem;
	output	reg [31:0]	ALUResult_mem;

	
	always @(posedge clk ) 
	begin
		if (reset)
		begin
			MemWrite_mem  <=  1'b0;
			MemWriteData_mem  <=  32'b0;
			 RegWrite_mem  <=  1'b0;
			 MemToReg_mem  <=  1'b0;
			 RegWriteAddr_mem  <=  5'b0;
			 ALUResult_mem <=  32'b0; 
		end 
		
		else
		begin
		MemWrite_mem <= MemWrite_ex;
		MemWriteData_mem <= MemWriteData_ex;								
		RegWrite_mem <= RegWrite_ex;
		MemToReg_mem <= MemToReg_ex;
		RegWriteAddr_mem <= RegWriteAddr_ex; 	
		ALUResult_mem <= ALUResult_ex;
		end
	end

endmodule
