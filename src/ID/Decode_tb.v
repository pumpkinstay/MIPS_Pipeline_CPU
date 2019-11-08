`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: ZJU
// edition 1.0   :  Engineer: tangyi   
// edition 2.0   :  modified by JiangNan WU   on 2018/12/21   
//							write operation("data_out.txt") is added.
//							.txt includes the value of signals after decoding
//
 ////////////////////////////////////////////////////////////////////////////////
module Decode_tb;

	// Inputs
	reg [31:0] Instruction;

	// Outputs
	wire MemtoReg;
	wire RegWrite;
	wire MemWrite;
	wire MemRead;
	wire [4:0] ALUCode;
	wire ALUSrcA;
	wire ALUSrcB;
	wire RegDst;
	wire J;
	wire JR;

	integer w_file;
    initial 
	begin 
		w_file = $fopen("data_out.txt");
		  $fdisplay(w_file,"    op    	  funct    ALUCode     RegDst    ALUSrcA    ALUSrcB    MemWrite    MemRead    MemtoReg    RegWrite     J    JR");
	end
	
	// Instantiate the Unit Under Test (UUT)
	Decode uut (
		.MemtoReg(MemtoReg), 
		.RegWrite(RegWrite), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.ALUCode(ALUCode), 
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB), 
		.RegDst(RegDst), 
		.J(J), 
		.JR(JR), 
		.Instruction(Instruction)
	);
	always @ (Instruction)
	begin
        $fdisplay(w_file,"%b	",Instruction[31:26],"%b	  ",Instruction[5:0],"%b             ",ALUCode,
										"%d              ",RegDst,"%d                ",ALUSrcA,"%d                  ",ALUSrcB,"%d                  ",MemWrite, 
										"%d                    ",MemRead,"%d                    ",MemtoReg,"%d          ",RegWrite, "%d     ",J,"%d",JR);
			
	end
	
	initial begin
		// Initialize Inputs
		Instruction = 32'h0800000b;//j later(later address is 2Ch)		
        
		// Add stimulus here
		#100 Instruction = 32'h20080042;//addi $t0,$0,42
		#100 Instruction = 32'h01095022;//sub $t2,$t0,$t1
		#100 Instruction = 32'h01485825;//or $t3,$t2,$t0
		#100 Instruction = 32'hac0b000c;//sw $t3,0C($0)
		#100 Instruction = 32'h8d2c0008;//lw $t4,08($t1)
		#100 Instruction = 32'h000c4080;//sll $t0,$t4,2		
		#100 Instruction = 32'h012a582b ;//sltu $t3,$t1,$t2		
		#100 Instruction = 32'h14000001 ;//bne $0,$0,end(end address is 34h)
		#100 Instruction = 32'h1000fff4 ;//beq $0,$0,earlier(earlier address is 4h)			
        #100 begin $fclose(w_file);$stop;end
		
	end
     
endmodule
