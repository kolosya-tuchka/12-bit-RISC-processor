`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 11:52:56
// Design Name: 
// Module Name: PC
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

module prog_counter(
    input clock, rst, ena, gto,
    input logic [11:0] accum,
    output logic [11:0] pc_addr
    );
    
    always @(posedge clock or posedge rst) begin
        if (rst) pc_addr <= 12'd0;
        else begin
            if (gto & ena) pc_addr <= accum;
            else if (ena) pc_addr <= pc_addr + 1;
            else pc_addr <= pc_addr;
        end
    end            
    
endmodule
