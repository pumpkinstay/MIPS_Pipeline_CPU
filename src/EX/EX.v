`timescale 1ns / 1ps
//
// Engineer:   JiangNan WU
// Data :		  20181221
// function:    EX stage of pipeline CPU  
//

module EX(RegDst_ex, ALUCode_ex, ALUSrcA_ex, ALUSrcB_ex, Imm_ex, Sa_ex, RsAddr_ex, RtAddr_ex, RdAddr_ex,
          RsData_ex, RtData_ex, RegWriteData_wb, ALUResult_mem, RegWriteAddr_wb, RegWriteAddr_mem, 
			 RegWrite_wb, RegWrite_mem, RegWriteAddr_ex, ALUResult_ex, MemWriteData_ex, ALU_A, ALU_B);
		input RegDst_ex;
    	input [4:0] ALUCode_ex;
    	input ALUSrcA_ex;
    	input ALUSrcB_ex;
    	input [31:0] Imm_ex;
    	input [31:0] Sa_ex;
    	input [4:0] RsAddr_ex;
    	input [4:0] RtAddr_ex;
    	input [4:0] RdAddr_ex;
    	input [31:0] RsData_ex;
    	input [31:0] RtData_ex;
    	input [31:0] RegWriteData_wb;
    	input [31:0] ALUResult_mem;
    	input [4:0] RegWriteAddr_wb;
    	input [4:0] RegWriteAddr_mem;
    	input RegWrite_wb;
    	input RegWrite_mem;
    	output [4:0] RegWriteAddr_ex;
    	output [31:0] ALUResult_ex;
    	output [31:0] MemWriteData_ex;
    	output [31:0] ALU_A;
    	output [31:0] ALU_B;

	

	wire [31:0]A,B;
	wire [1:0]ForwardA,ForwardB;
	
	assign MemWriteData_ex = B; 
	
// ** 		Register Destination 		 **//
		MUX_2to1   #(.n(5))  WBRegSelector(
			.in0(RtAddr_ex),
			.in1(RdAddr_ex),
			.addr(RegDst_ex),
			.out(RegWriteAddr_ex) );

// ** 		select  OperandA		 **//
		MUX_3to1    #(.n(32))  OperandA(
			.in0(RsData_ex),
			.in1(RegWriteData_wb),
			.in2(ALUResult_mem),
			.addr(ForwardA),
			.out(A) );		
			
// ** 		select  OperandB		 **//
		MUX_3to1   #(.n(32))   OperandB(
			.in0(RtData_ex),
			.in1(RegWriteData_wb),
			.in2(ALUResult_mem),
			.addr(ForwardB),
			.out(B) );
			
// ** 		ALU SourceA 		 **//
		MUX_2to1  #(.n(32))    SrcA(
			.in0(A),
			.in1(Sa_ex),
			.addr(ALUSrcA_ex),
			.out(ALU_A) );
			
// ** 		ALU SourceB 		 **//
		MUX_2to1  #(.n(32))    SrcB(
			.in0(B),
			.in1(Imm_ex),
			.addr(ALUSrcB_ex),
			.out(ALU_B) );
			
// ** 		ALU operation 		 **//		
		ALU   ALU(
			.ALUCode(ALUCode_ex), 
			.A(ALU_A), 
			.B(ALU_B),
			.ALUResult(ALUResult_ex)  );
		
// ** 		Forwarding 		 **//		

		Forwarding  Forwarding(
			// Input
			.RsAddr_ex(RsAddr_ex),
			.RtAddr_ex(RtAddr_ex),
			.RegWrite_mem(RegWrite_mem),
			.RegWriteAddr_mem(RegWriteAddr_mem),
			.RegWrite_wb(RegWrite_wb),
			.RegWriteAddr_wb(RegWriteAddr_wb),
			
			// Output
			.ForwardA(ForwardA),
			.ForwardB(ForwardB)  );
			
endmodule
