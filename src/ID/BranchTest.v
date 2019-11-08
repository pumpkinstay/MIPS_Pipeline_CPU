//20181217    JiangNan WU
//Zero Detector :  Branch test , detecting Structural hazards
module BranchTest (
	// Input
	input [4:0]ALUCode_id,
	input [31:0] RsData_id,
	input [31:0] RtData_id,
	//Output
	output Z 
);
	
	assign Z =  (ALUCode_id == 5'b01010) &&(RsData_id == RtData_id)  ||    		   				   		// ALUCode     == alu_beq
						 (ALUCode_id == 5'b01011) &&(RsData_id != RtData_id) ||       		 		   				// 					   == alu_bne
						 (ALUCode_id == 5'b01100) && (~RsData_id [31]) ||  				     		 		   		  // 			    		      == alu_bgez
						 (ALUCode_id == 5'b01101) && ( ( ~RsData_id[31]) && ( RtData_id != 32'b0) ) || 	   //     	  == alu_bgtz
						 (ALUCode_id == 5'b01111) && (RsData_id [31]) ||   	     				          						 // 				   == alu_bltz
						 (ALUCode_id == 5'b01110) && ((RsData_id [31]) && ( RtData_id != 32'b0) )  ;        // 				  == alu_blez
																																													  // for other ALUCode, Z=0					

endmodule

