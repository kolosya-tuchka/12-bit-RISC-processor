`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 12:01:38
// Design Name: 
// Module Name: addr_multiplexer
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

module addr_mux(
    input [11:0] ir_ad, pc_ad, accum,
    input sel, sel_ac,  
    output [11:0] addr
    );
    
    assign addr = (sel_ac) ? {4'b0000, accum[7:0]} : (sel) ? ir_ad : pc_ad;
    
endmodule
