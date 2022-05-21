`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 14:14:20
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Arithmetic logic unit
module alu(
    input [3:0] op,
    input [11:0] alu_in, accum,
    output logic [11:0] alu_out
    );
    
    parameter NOP = 4'b0000,
              LDO = 4'b0001,
              LDA = 4'b0010,
              STO = 4'b0011,
              PRE = 4'b0100,
              ADD = 4'b0101,
              LDM = 4'b0110,
              HLT = 4'b0111,
              CNT = 4'b1000,
              GBY = 4'b1001,
			  GBI = 4'b1010,
			  CMP = 4'b1011,
			  GTO = 4'b1100;
    
    always @(*) begin
        casez(op)
        NOP:	alu_out = accum;
		HLT:	alu_out = accum;
		LDO:	alu_out = alu_in;
		LDA:	alu_out = alu_in;
		STO:	alu_out = accum;
		PRE:	alu_out = alu_in;
		ADD:	alu_out = accum+alu_in;
		LDM:	alu_out = accum;
		GBY:    alu_out = alu_in;
		GBI:    alu_out = !accum[alu_in[11:8]];
		CMP:    alu_out = (accum == alu_in) ? 1 : 0;
		GTO:    alu_out = (accum[0]) ? accum : alu_in;
		CNT:    begin
		        alu_out[8] <= !accum[8] &
                    (!accum[11] | accum[10] | !accum[9] | !accum[8]);
                alu_out[9] <= (accum[8] & !accum[9] | !accum[8] & accum[9]) & 
                    (!accum[11] | accum[10] | !accum[9] | !accum[8]);
                alu_out[10] <= ((accum[10] & (!accum[9] | !accum[8])) |
                    (!accum[10] & accum[9] & accum[8])) &
                    (!accum[11] | accum[10] | !accum[9] | !accum[8]);
                alu_out[11] <= ((accum[11] & (!accum[10] | !accum[9] | !accum[8])) |
                    (!accum[11] & accum[10] & accum[9] & accum[8])) &
                    (!accum[11] | accum[10] | !accum[9] | !accum[8]);
                
                if (accum[11] & !accum[10] & accum[9] & accum[8]) begin
                    alu_out[0] <= !accum[0];
                    alu_out[1] <=  ((accum[1] & (!accum[0])) |
                        (!accum[1] & accum[0]));
                    alu_out[2] <=  ((accum[2] & (!accum[1] | !accum[0])) |
                        (!accum[2] & accum[1] & accum[0]));
                    alu_out[3] <=  ((accum[3] & (!accum[2] | !accum[1] | !accum[0])) |
                        (!accum[3] & accum[2] & accum[1] & accum[0]));
                    alu_out[4] <=  ((accum[4] & (!accum[3] | !accum[2] | !accum[1] | !accum[0])) |
                        (!accum[4] & accum[3] & accum[2] & accum[1] & accum[0]));
                    alu_out[5] <=  ((accum[5] & (!accum[4] | !accum[3] | !accum[2] | !accum[1] | !accum[0])) |
                        (!accum[5] & accum[4] & accum[3] & accum[2] & accum[1] & accum[0]));
                    alu_out[6] <=  ((accum[6] & (!accum[5] | !accum[4] | !accum[3] | !accum[2] | !accum[1] | !accum[0])) |
                        (!accum[6] & accum[5] & accum[4] & accum[3] & accum[2] & accum[1] & accum[0]));
                    alu_out[7] <=  ((accum[7] & (!accum[6] | !accum[5] | !accum[4] | !accum[3] | !accum[2] | !accum[1] | !accum[0])) |
                        (!accum[7] & accum[6] & accum[5] & accum[4] & accum[3] & accum[2] & accum[1] & accum[0]));
                    end
                else alu_out[7:0] <= accum[7:0];
                end
		default:	alu_out = 12'bzzzzzz_zzzzzz;
		endcase
    
    end

endmodule