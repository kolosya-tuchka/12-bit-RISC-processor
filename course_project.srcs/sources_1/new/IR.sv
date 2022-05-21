`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 14:50:30
// Design Name: 
// Module Name: IR
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


module ins_reg(
    input clk, rst,
    input [1:0] fetch,
    input [11:0] data,
    output [3:0] ins,
    output [7:0] ad1,
    output [11:0] ad2
    );
    
    logic [11:0] ins_p1, ins_p2;
    logic [3:0] state;
    
    assign ins = ins_p1[11:8];
    assign ad1 = ins_p1[7:0];
    assign ad2 = ins_p2;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ins_p1 <= 12'd0;
            ins_p2 <= 12'd0;
        end
        else begin
            if(fetch==2'b01) begin		//fetch==2'b01 operation1, to fetch data from REG
			     ins_p1 <= data;
			     ins_p2 <= ins_p2;
		    end
		  else if(fetch==2'b10) begin		//fetch==2'b10 operation2, to fetch data from RAM/ROM
			     ins_p1 <= ins_p1;
			     ins_p2 <= data;
		  end
		  else begin
			     ins_p1 <= ins_p1;
			     ins_p2 <= ins_p2;
		  end
		  
        end        
    end
    
endmodule
