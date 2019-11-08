`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: ZJU
// edition 1.0   :  Engineer: tangyi   
// edition 2.0   :  modified by JiangNan WU   on 2018/12/21   
//							write operation("ALU_DataOut.txt") is added.
//							print out the value of ALUCode,A,B and ALUResult.
//
 ////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs
	reg [4:0] ALUCode;
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] ALUResult;
	
	integer w_file;
    initial 
	begin 
		w_file = $fopen("ALU_DataOut.txt");
		  $fdisplay(w_file,"ALUCode            A                         B                     ALUResult");
	end
	
	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.ALUResult(ALUResult), 
		.ALUCode(ALUCode), 
		.A(A), 
		.B(B)
	);
	

	
	always @ (ALUCode)
	begin
        $fdisplay(w_file,"   %b	       ",ALUCode,"%h	    ",A,"%h            ",B,"%h",ALUResult);
			
	end
	
	
	initial begin
		// Initialize Inputs
		ALUCode = 5'd0; A = 32'h00004012; B = 32'h1000200F;//add
		      
		// Add stimulus here
		#100 ALUCode = 5'd0;	A = 32'h40000000;	B = 32'h40000000;//add
		#100 ALUCode = 5'd1;	A = 32'hFF0C0E10;	B = 32'h10DF30FF;//and
		#100 ALUCode = 5'd2;	A = 32'hFF0C0E10;	B = 32'h10DF30FF;//xor
		#100 ALUCode = 5'd3;	A = 32'hFF0C0E10;	B = 32'h10DF30FF;//or
		#100 ALUCode = 5'd4;	A = 32'hFF0C0E10;	B = 32'h10DF30FF;//nor
		#100 ALUCode = 5'd5;	A = 32'h70F0C0E0;	B = 32'h10003054;//sub
		#100 ALUCode = 5'd6;	A = 32'hFF0C0E10;	B = 32'hFFFFE0FF;//andi
		#100 ALUCode = 5'd7;	A = 32'hFF0C0E10;	B = 32'hFFFFE0FF;//xori
		#100 ALUCode = 5'd8;	A = 32'hFF0C0E10;	B = 32'hFFFFE0FF;//ori
		#100 ALUCode = 5'd16;A = 32'h00000004;	B = 32'hFFFFE0FF;//sll
		#100 ALUCode = 5'd17;A = 32'h00000004;	B = 32'hFFFFE0FF;//srl
		#100 ALUCode = 5'd18;A = 32'h00000004;	B = 32'hFFFFE0FF;//sra
		#100 ALUCode = 5'd19;A = 32'hFF000004;	B = 32'h700000FF;//slt
		#100 ALUCode = 5'd20;A = 32'hFF000004;	B = 32'h700000FF;//sltu
		#100 begin $fclose(w_file); $stop; end

	end
      
endmodule

