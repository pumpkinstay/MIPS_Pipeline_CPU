`timescale 1ns / 1ps
//20181218   JiangNan WU
//function: ID_EX Register


module ID_EX_reg(
		clk,reset,       			// reset : used for simulation
		stall,
		
	//Input  from ID
	ALUCode_id,ALUSrcA_id,ALUSrcB_id,RegDst_id,   
	MemWrite_id,MemRead_id,	
	RegWrite_id, 								
	MemToReg_id,		
	Sa_id,         	  		  // zero-extend (shamt)
	Imm_id,        			  // sign-extend (immediate)
	RdAddr_id ,RsAddr_id,RtAddr_id,
	RsData_id,RtData_id ,
	
	//output reg to EX
	ALUCode_ex,ALUSrcA_ex,ALUSrcB_ex,RegDst_ex,        // for EX , ALU operations
	MemWrite_ex,MemRead_ex,	 // for Mem operations
	RegWrite_ex, 									  	 // for WB operations
	MemToReg_ex, 
	Sa_ex,       
	Imm_ex,
	RdAddr_ex ,RtAddr_ex,RsAddr_ex,
	RsData_ex,RtData_ex
);
	input reset;
	input clk;
	input stall;
	input	[4:0]ALUCode_id ;
	input	ALUSrcA_id ,ALUSrcB_id ; 
	input	 RegDst_id ; 
	
	input	MemWrite_id ; 
	input	MemRead_id ; 

	input	RegWrite_id ; 
	input	MemToReg_id ; 
	
	input	[31:0]Sa_id ; 
	input	[31:0]Imm_id ; 	
	input	[4:0]RdAddr_id ,RsAddr_id,RtAddr_id; 
	input	[31:0]RsData_id,RtData_id ; 

	
	
	output reg	[4:0]ALUCode_ex ;
	output reg	ALUSrcA_ex ,ALUSrcB_ex ; 
	output reg	RegDst_ex ; 
	
	output reg	MemWrite_ex ; 
	output reg	MemRead_ex ; 

	output reg	RegWrite_ex ; 
	output reg	MemToReg_ex ; 
	
	output reg	[31:0]Sa_ex ; 
	output reg	[31:0]Imm_ex ; 
	output reg	[4:0]RdAddr_ex ,RtAddr_ex,RsAddr_ex; 	
	output reg	[31:0]RsData_ex,RtData_ex ; 
	
	
	always @(posedge clk ) 
	begin
		if (reset)
		begin
			ALUCode_ex <= 5'b0;
			ALUSrcA_ex <=  1'b0;
			ALUSrcB_ex <= 1'b0;
			RegDst_ex <= 1'b0;
			MemWrite_ex <= 1'b0;
			MemRead_ex <= 1'b0;
			RegWrite_ex <= 1'b0;
			MemToReg_ex <= 1'b0;
			Sa_ex <= 32'b0;
			Imm_ex <= 32'b0;
			RdAddr_ex <= 5'b0;
			RtAddr_ex<= 5'b0;
			RsAddr_ex<=  5'b0;
			RsData_ex<= 32'b0;
			RtData_ex <= 32'b0;     
		end 
		
		// Pipeline blocking
		else 	if (stall)
		begin
			ALUCode_ex <= 5'b0;
			ALUSrcA_ex <=  1'b0;
			ALUSrcB_ex <= 1'b0;
			RegDst_ex <= 1'b0;
			MemWrite_ex <= 1'b0;
			MemRead_ex <= 1'b0;
			RegWrite_ex <= 1'b0;
			MemToReg_ex <= 1'b0;
			Sa_ex <= 32'b0;
			Imm_ex <= 32'b0;
			RdAddr_ex <= 5'b0;
			RtAddr_ex<= 5'b0;
			RsAddr_ex<=  5'b0;
			RsData_ex<= 32'b0;
			RtData_ex <= 32'b0;     
		end
					
		else
		begin
			ALUCode_ex <= ALUCode_id;
			ALUSrcA_ex <=  ALUSrcA_id;
			ALUSrcB_ex <= ALUSrcB_id;
			 RegDst_ex <= RegDst_id;
			MemWrite_ex <= MemWrite_id;
			MemRead_ex <= MemRead_id;
			RegWrite_ex <= RegWrite_id;
			MemToReg_ex <= MemToReg_id;
			Sa_ex <= Sa_id;
			Imm_ex <= Imm_id;
			RdAddr_ex <= RdAddr_id;
			RtAddr_ex<= RtAddr_id;
			RsAddr_ex<=  RsAddr_id;
			RsData_ex<= RsData_id;
			RtData_ex <= RtData_id; 
		end
	end
endmodule