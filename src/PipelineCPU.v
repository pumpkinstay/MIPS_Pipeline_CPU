`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  ZJU
// Engineer:  JiangNan WU 
// Create Date:    19/12/2018 
// Description:     5-stages Pipeline CPU  (IF, ID ,EX, MEM ,WB)
//
//////////////////////////////////////////////////////////////////////////////////

module PipelineCPU(clk,reset,JumpFlag,Instruction_id,ALU_A,
                     ALU_B,ALUResult,PC,MemDout_mem,Stall);
	
	input clk;
	input reset;
	output[2:0] JumpFlag;
	output [31:0] Instruction_id;
	output [31:0] ALU_A;
	output [31:0] ALU_B;
	output [31:0] ALUResult;
	output [31:0] PC;
	output [31:0] MemDout_mem;
	output Stall;
	 

	//===== IF =====
	wire [31:0] Instruction_if;
	wire [31:0] NextPC_if;
	wire IF_flush;
	
	//===== ID =====
	wire [31:0] Instruction_id;
	wire [31:0] NextPC_id;
	wire MemtoReg_id;
	wire RegWrite_id;
	wire MemWrite_id;
	wire MemRead_id;
	wire [4:0] ALUCode_id;
	wire ALUSrcA_id;
	wire ALUSrcB_id;
	wire RegDst_id;
	wire Stall;
	wire Z;
	wire J;
	wire JR;
	wire PC_IFWrite;
	wire [31:0] BranchAddr;
	wire [31:0] JumpAddr;
	wire [31:0] JrAddr;
	wire [31:0] Imm_id;
	wire [31:0] Sa_id;
	wire [4:0] RdAddr_id;
	wire [4:0] RsAddr_id;
	wire [4:0] RtAddr_id;
	wire [31:0] RsData_id;
	wire [31:0] RtData_id;
	
	//===== EX =====
	wire RegDst_ex;
	wire [4:0] ALUCode_ex;
	wire ALUSrcA_ex;
	wire ALUSrcB_ex;
	wire [31:0] Imm_ex;
	wire [31:0] Sa_ex;
	wire [4:0] RsAddr_ex;
	wire [4:0] RtAddr_ex;
	wire [4:0] RdAddr_ex;
	wire [31:0] RsData_ex;
	wire [31:0] RtData_ex;
	wire MemToReg_ex;
	wire RegWrite_ex;
	wire MemWrite_ex;
	wire MemRead_ex;
	wire [4:0] RegWriteAddr_ex;
	wire [31:0] ALUResult_ex;
	wire [31:0] MemWriteData_ex;
	wire [31:0] ALU_A;
	wire [31:0] ALU_B;
	
	//===== MEM =====
	
	wire [31:0] ALUResult_mem;
	wire [4:0] RegWriteAddr_mem;
	wire [31:0] MemWriteData_mem;
	wire RegWrite_mem;
	wire MemWrite_mem;
	wire [31:0]MemDout_mem;
	wire MemToReg_mem;
	
	//===== WB =====
	wire [31:0] RegWriteData_wb;
	wire [4:0] RegWriteAddr_wb;
	wire [31:0]MemDout_wb;
	wire MemToReg_wb;
	wire RegWrite_wb;
	wire [31:0]ALUResult_wb;
	
	//========================


	// Test Signals 
	
	assign JumpFlag = {JR,J,Z} ;
	assign ALUResult =ALUResult_ex;
	assign PC = NextPC_if - 4 ;
	 
	
	//========IF Stage=========
	IF IF(
			.clk(clk),
			.reset(reset),
			.Z(Z),
			.J(J),
			.JR(JR),
			.PC_IFWrite(PC_IFWrite),
			.JumpAddr(JumpAddr),
			. JrAddr(JrAddr),
			.BranchAddr(BranchAddr),
			.Instruction_if(Instruction_if),
			.IF_flush(IF_flush),
			.NextPC_if(NextPC_if) );
	
	//========IF/ID Register=========
	IF_ID_reg IF_ID_reg(
		.clk(clk),
		.reset(reset),       			
		.PC_IFWrite(PC_IFWrite),			
		.IF_flush(IF_flush),
		.NextPC_if(NextPC_if),
		.Instruction_if(Instruction_if),
		
		.NextPC_id(NextPC_id),
		.Instruction_id(Instruction_id) );
		
		
	//========ID Stage=========
	 ID  ID(
			.clk(clk),
			.Instruction_id(Instruction_id),
			.NextPC_id(NextPC_id),
			.RegWrite_wb(RegWrite_wb),
			.RegWriteAddr_wb(RegWriteAddr_wb),
			.RegWriteData_wb(RegWriteData_wb),
			.MemRead_ex(MemRead_ex),
			.RegWriteAddr_ex(RegWriteAddr_ex),
			.MemtoReg_id(MemtoReg_id),
			.RegWrite_id(RegWrite_id),
			.MemWrite_id(MemWrite_id),
			.MemRead_id(MemRead_id),
			.ALUCode_id(ALUCode_id),
			.ALUSrcA_id(ALUSrcA_id),
			.ALUSrcB_id(ALUSrcB_id),
			.RegDst_id(RegDst_id),
			.Stall(Stall),
			.Z(Z),
			.J(J),
			.JR(JR),
			.PC_IFWrite(PC_IFWrite),
			.BranchAddr(BranchAddr),
			.JumpAddr(JumpAddr),
			.JrAddr(JrAddr),
			.Imm_id(Imm_id),
			.Sa_id(Sa_id),
			.RdAddr_id(RdAddr_id),
			.RsAddr_id(RsAddr_id),
			.RtAddr_id(RtAddr_id),
			.RsData_id(RsData_id),
			.RtData_id(RtData_id));
			
	//========ID/EX Register=========
	ID_EX_reg  ID_EX_reg(
			.clk(clk),
			.reset(reset),
			.stall(Stall),
			
			.ALUCode_id(ALUCode_id),
			.ALUSrcA_id(ALUSrcA_id),
			.ALUSrcB_id(ALUSrcB_id),
			.RegDst_id(RegDst_id),
			.MemWrite_id(MemWrite_id),
			.MemRead_id(MemRead_id),
			.RegWrite_id(RegWrite_id),
			.MemToReg_id(MemtoReg_id),
			.Sa_id(Sa_id),
			.Imm_id(Imm_id),
			.RdAddr_id(RdAddr_id),
			.RsAddr_id(RsAddr_id),
			.RtAddr_id(RtAddr_id),
			.RsData_id(RsData_id),
			.RtData_id(RtData_id),
			
			.ALUCode_ex(ALUCode_ex),
			.ALUSrcA_ex(ALUSrcA_ex),
			.ALUSrcB_ex(ALUSrcB_ex),
			.RegDst_ex(RegDst_ex),
			.MemWrite_ex(MemWrite_ex),
			.MemRead_ex(MemRead_ex),
			.RegWrite_ex(RegWrite_ex),
			.MemToReg_ex(MemToReg_ex),
			.Sa_ex(Sa_ex),
			.Imm_ex(Imm_ex),
			.RdAddr_ex(RdAddr_ex),
			.RsAddr_ex(RsAddr_ex),
			.RtAddr_ex(RtAddr_ex),
			.RsData_ex(RsData_ex),
			.RtData_ex(RtData_ex)  );
			
	//========EX Stage=========
	EX  EX(
			.RegDst_ex(RegDst_ex),
			.ALUCode_ex(ALUCode_ex),
			.ALUSrcA_ex(ALUSrcA_ex),
			.ALUSrcB_ex(ALUSrcB_ex),
			.Imm_ex(Imm_ex),
			.Sa_ex(Sa_ex),
			.RsAddr_ex(RsAddr_ex),
			.RtAddr_ex(RtAddr_ex),
			.RdAddr_ex(RdAddr_ex),
			.RsData_ex(RsData_ex),
			.RtData_ex(RtData_ex),
			.RegWriteData_wb(RegWriteData_wb),
			.ALUResult_mem(ALUResult_mem),
			.RegWriteAddr_wb(RegWriteAddr_wb),
			.RegWriteAddr_mem(RegWriteAddr_mem),
			.RegWrite_wb(RegWrite_wb),
			.RegWrite_mem(RegWrite_mem),
			.RegWriteAddr_ex(RegWriteAddr_ex),
			.ALUResult_ex(ALUResult_ex),
			.MemWriteData_ex(MemWriteData_ex),
			.ALU_A(ALU_A),
			.ALU_B(ALU_B)		);
			
	//========EX/MEM Register=========
	EX_MEM_reg  EX_MEM_reg( 
			.clk(clk),
			.reset(reset),
			.MemWrite_ex(MemWrite_ex),
			.MemWriteData_ex(MemWriteData_ex),
			.RegWrite_ex(RegWrite_ex),
			.RegWriteAddr_ex(RegWriteAddr_ex),
			.MemToReg_ex(MemToReg_ex),
			.ALUResult_ex(ALUResult_ex),
			.MemWrite_mem(MemWrite_mem),
			.MemWriteData_mem(MemWriteData_mem),
			.RegWrite_mem(RegWrite_mem),
			.RegWriteAddr_mem(RegWriteAddr_mem),
			.MemToReg_mem(MemToReg_mem),
			.ALUResult_mem(ALUResult_mem)  );
			
	//========MEM Stage: DataRam=========
	
			// Reading or Writing to address begining with 4 is FORBIDDEN
	DataRam DataRam(
		    .a(ALUResult_mem[7:2]),      // input addr
		    .d(MemWriteData_mem),   // input [31:0] din
		    .clk(clk),  
		    .we(MemWrite_mem),    // input wire we
		    .spo(MemDout_mem)  // output wire [31 : 0] 
			); 
			
	//========MEM/WB Register=========
	MEM_WB_reg  MEM_WB_reg(
			.clk(clk),
			.reset(reset),
			.MemToReg_mem(MemToReg_mem ),
			.RegWrite_mem(RegWrite_mem),
			.RegWriteAddr_mem(RegWriteAddr_mem),
			.ALUResult_mem(ALUResult_mem),
			.MemDout_mem(MemDout_mem),
			
			.MemToReg_wb(MemToReg_wb),
			.RegWrite_wb(RegWrite_wb),
			.RegWriteAddr_wb(RegWriteAddr_wb),
			.ALUResult_wb(ALUResult_wb),
			.MemDout_wb(MemDout_wb) );
			
	//========WB Stage=========
		
		WB  WB(
			.MemToReg_wb(MemToReg_wb), 
			.MemDout_wb(MemDout_wb), 
			.ALUResult_wb(ALUResult_wb), 
			.RegWriteData_wb(RegWriteData_wb) );

		


endmodule
