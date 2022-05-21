`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 11:58:31
// Design Name: 
// Module Name: accumulator
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

// a register, to storage result
module accum(
    input clk, rst, ena,
    input [11:0] in,
    output logic [11:0] out
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) out <= 12'd0;
        else begin
            if (ena) out <= in;
            else out <= out;
        end
    end
    
endmodule
