`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  ZJU
// Engineer:  JiangNan WU   
// Create Date:    18/12/2018 
// Description:   instruction decode. 
// Output signal :  ALU control signals ; control signals about register write , memory write/read, jump
//
//////////////////////////////////////////////////////////////////////////////////

module Decode(   
	// Outputs
	MemtoReg, RegWrite, MemWrite, MemRead,ALUCode,ALUSrcA,ALUSrcB,
	RegDst,J ,JR, 

	// Inputs
	Instruction
);
	input [31:0]	Instruction;		// current instruction
	output		MemtoReg;		// use memory output as data to write into register
	output		RegWrite;		// enable writing back to the register
	output		MemWrite;		// write to memory
	output      MemRead;
	output reg[4:0] ALUCode;     // ALU operation select
	output      	ALUSrcA,ALUSrcB;
	output      RegDst;
	output      J,JR;
//******************************************************************************
// instruction field
//******************************************************************************
	wire [5:0]	op;
	wire [5:0]	funct;

	assign op=    Instruction[31:26];
	assign funct= Instruction[5:0];

//******************************************************************************
// Decode field
//******************************************************************************
	
	//R_type1  , R_type2 , JR
	parameter  R_type_op= 6'b000000;

    parameter  ADD_funct =  6'b100000;
	parameter  ADDU_funct = 6'b100001;
	parameter  AND_funct =  6'b100100;
	parameter  XOR_funct =  6'b100110;
	parameter  OR_funct =   6'b100101;
	parameter  NOR_funct =  6'b100111;
	parameter  SUB_funct =  6'b100010;
	parameter  SUBU_funct = 6'b100011;
	parameter  SLT_funct =  6'b101010;
	parameter  SLTU_funct = 6'b101011;	
	parameter  SLL_funct= 6'b000000;
	parameter  SLLV_funct=6'b000100;
	parameter  SRL_funct= 6'b000010;
	parameter  SRLV_funct=6'b000110;
	parameter  SRA_funct= 6'b000011;
	parameter  SRAV_funct=6'b000111;
	parameter  JR_funct= 6'b001000;
	// Branch
	parameter BEQ_op=  6'b000100;
	parameter BNE_op = 6'b000101;   
	parameter BGEZ_op= 6'b000001;
	parameter BGEZ_rt= 5'b00001;
	parameter BGTZ_op= 6'b000111;
	parameter BGTZ_rt= 5'b00000;
	parameter BLEZ_op = 6'b000110;
	parameter BLEZ_rt = 5'b00000;
	parameter BLTZ_op= 6'b000001;
	parameter BLTZ_rt= 5'b00000;
	// J_type
	parameter J_op=6'b000010;
	//	I_type
	parameter  ADDI_op = 6'b001000;
	parameter  ADDIU_op= 6'b001001;
	parameter  ANDI_op = 6'b001100;
	parameter  XORI_op = 6'b001110;
	parameter  ORI_op  = 6'b001101;
	parameter  SLTI_op = 6'b001010;
	parameter  SLTIU_op= 6'b001011;
	// LW,SW
    	parameter  SW_op = 6'b101011;
	parameter  LW_op = 6'b100011;
	//   ALUCode
	parameter	 alu_add=  5'b00000;
    	parameter	 alu_and=  5'b00001;
   	 parameter	 alu_xor=  5'b00010;
    	parameter	 alu_or =  5'b00011;
    	parameter	 alu_nor=  5'b00100;
    	parameter	 alu_sub=  5'b00101;
    	parameter	 alu_andi= 5'b00110;
	parameter	 alu_xori= 5'b00111;
	parameter	 alu_ori = 5'b01000;
	parameter    	 alu_jr =  5'b01001;
	parameter	 alu_beq=  5'b01010;
    	parameter	 alu_bne=  5'b01011;
	parameter	 alu_bgez= 5'b01100;
    	parameter	 alu_bgtz= 5'b01101;
    	parameter	 alu_blez= 5'b01110;
    	parameter	 alu_bltz= 5'b01111;
	parameter 	 alu_sll=  5'b10000;
	parameter	 alu_srl=  5'b10001;
	parameter	 alu_sra=  5'b10010;	
	parameter	 alu_slt=  5'b10011;
    	parameter	 alu_sltu= 5'b10100;
 	
	
//******************************************************************************
// Control signals
//******************************************************************************

   wire I_type , R_type1 , R_type2;
   assign  I_type= (op == ADDI_op) ||  (op ==	ADDIU_op) || (op == ANDI_op) || (op == XORI_op) ||
								(op == ORI_op) ||(op == SLTI_op) ||(op == SLTIU_op);
	assign  R_type1 = (op == R_type_op ) &&
										(( funct == ADD_funct) ||  (funct == ADDU_funct) || (funct == AND_funct) ||
										  (funct == XOR_funct) || (funct == OR_funct) ||  (funct == NOR_funct) || (funct == SUB_funct) ||
									      (funct == SUBU_funct) || (funct == SLT_funct) ||  (funct == SLTU_funct) || (funct == SLLV_funct) ||
									      (funct == SRLV_funct) || (funct == SRAV_funct) );						
	assign  R_type2 = (op == R_type_op ) && (( funct == SLL_funct)  ||  (funct == SRL_funct) || (funct == SRA_funct));
	
	//   MemtoReg_id=LW
	assign MemtoReg =  (op == LW_op);
	
	//   MemRead_id=LW
	assign MemRead =  (op == LW_op);
	
	//   MemWrite_id=SW
	assign MemWrite =   (op == SW_op);
	
	//   RegWrite_id=LW||R_type1||R_type2|| I_type
	assign  RegWrite =   (op == LW_op)|| R_type1||R_type2 ||  I_type;

	//   RegDst_id=R_type1||R_type2
	assign  RegDst = R_type1||R_type2;
	
	//	ALUSrcA_id= 0:rs ; 1:shamt
	assign  ALUSrcA=R_type2;
	
	//	ALUSrcB_id=  0:rt ; 1:imm
	assign ALUSrcB=I_type ||  (op == LW_op) ||  (op == SW_op);

	//  J, JR control signal
	assign J = (op ==  J_op);
	assign JR = (op == R_type_op ) && ( funct == JR_funct) ;
//******************************************************************************
// ALU control signal
//******************************************************************************

	always@(*)
	begin
		ALUCode=5'b00000;      //   initialization : ALU_add
		case(op)
			BEQ_op:				ALUCode = alu_beq;
			BNE_op:				ALUCode = alu_bne;
			BGEZ_op:				ALUCode = alu_bgez;
			BGTZ_op:				ALUCode = alu_bgtz;
			BLEZ_op:				ALUCode = alu_blez;
			BLTZ_op:				ALUCode = alu_bltz;
			
			R_type_op:
				begin
					case(funct)
						ADD_funct,ADDU_funct :       ALUCode = alu_add;						AND_funct:                                 ALUCode = alu_and;
						XOR_funct:                                  ALUCode = alu_xor;
						OR_funct:                                    ALUCode = alu_or;
						NOR_funct:                                 ALUCode = alu_nor;
						SUB_funct , SUBU_funct:       ALUCode = alu_sub;
						SLT_funct:                                   ALUCode = alu_slt;
						SLTU_funct:                                ALUCode = alu_sltu;
						SLL_funct , SLLV_funct:          ALUCode = alu_sll;
						SRL_funct , SRLV_funct:         ALUCode = alu_srl;
						SRA_funct , SRAV_funct:       ALUCode = alu_sra;
						JR_funct:								 		ALUCode = alu_jr;
						default : 										ALUCode=5'b00000;   //   default : ALU_add
					endcase
				end
			ADDI_op,ADDIU_op,LW_op,SW_op :        ALUCode = alu_add;
			ANDI_op:					ALUCode = alu_andi;
			XORI_op:			   		ALUCode = alu_xori;
			ORI_op:					ALUCode = alu_ori;
			SLTI_op:					ALUCode = alu_slt;
			SLTIU_op:				ALUCode = alu_sltu;
			
			default:					ALUCode=5'b00000;           //   default : ALU_add
		endcase
		
	end

	
endmodule