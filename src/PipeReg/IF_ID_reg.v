`timescale 1ns/1ps
//20181218   JiangNan WU
//function : IF_ID Register
//comments : If  flush ,then  Instru has been cancelled 
//				  	   Instead of setting NextPC_id to 32'b0, 
//			    	   I set it to NextPC_id = NextPC_if - 4 , in case exception handling, CPU need to set EPC

module IF_ID_reg(

	//Input  
		clk,reset,       			
		PC_IFWrite,			//  if stall,  PC won't change
		IF_flush,				//  if  JR,J,Branch happen
		NextPC_if,
		Instruction_if,
		
	//output
		NextPC_id,
		Instruction_id
);

    input			clk;
    input			reset;
	input 			IF_flush;
	input			PC_IFWrite;
	input 	[31:0] NextPC_if;
	input	[31:0]	Instruction_if;
	
	output reg[31:0] NextPC_id;
	output reg[31:0]	Instruction_id;
	

	always @(posedge clk) 
	begin
		if (reset )   // reset : used for simulation
		begin
			NextPC_id <= 32'b0;
			Instruction_id <= 32'b0;
		end
		
		else if (IF_flush)
		begin
			NextPC_id <= NextPC_if - 4;         // 
			Instruction_id <= 32'b0;
		end
		
		else if(PC_IFWrite)
		begin
			NextPC_id <= NextPC_if;
			Instruction_id <= Instruction_if;
		end
		
		else ;  // stall = 1 , PC_IFWrite = ~stall = 0 ;
                    //	PC and Instru stay the same
		
	end
	
endmodule
