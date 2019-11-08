`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  ZJU
// Engineer:  JiangNan WU   
// Create Date:    18/12/2018 
// Description:   IF (instruction fetch) stage of pipeline CPU 
//
//////////////////////////////////////////////////////////////////////////////////

module IF(clk, reset, Z, J, JR, PC_IFWrite, JumpAddr, 
           JrAddr, BranchAddr, Instruction_if,IF_flush, NextPC_if);
	input clk;
	input reset;
	input Z;
	input J;
	input JR;
	input PC_IFWrite;
	input [31:0] JumpAddr;
	input [31:0] JrAddr;
	input [31:0] BranchAddr;
	output [31:0] Instruction_if;
	output [31:0] NextPC_if;
	output IF_flush;


	wire [31:0]PC_mux,PC;
	
// ***		MUX PC source *** // 
	MUX_4to1  #(.n(32))	MUX_PCSrc (
		.in0(NextPC_if),
		.in1(BranchAddr),
		.in2(JumpAddr),
		.in3(JrAddr),
		.addr( {JR,J,Z}),
		.out(PC_mux));

// ***		PC register *** // 		
	 dffre #(.n(32)) PCreg(
		.d(PC_mux),
		.en(PC_IFWrite),
		.r(reset),
		.clk(clk),
		.q(PC) );
		

// ***		InstructionROM *** // 

	InstructionROM  InstructionROM(
		.addr(PC[7:2]),
		.dout(Instruction_if) );
		
// 	PC+4 
	assign NextPC_if = PC+4;

// IF_flush  control signal  : clear  IF/ID reg, when  J,JR,Branch
	assign IF_flush = JR || J || Z;
	
	
endmodule
