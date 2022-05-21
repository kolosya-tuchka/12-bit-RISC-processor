`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 11:50:10
// Design Name: 
// Module Name: RAM
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


module ram(
    input ena, read, write,
    input [11:0] addr,
    inout [11:0] data
    );
    
    logic [11:0] ram[4095:0];
    
    assign data = (read && ena) ? ram[addr] : 12'hzzz;
    
    always @(posedge write) begin
        ram[addr] <= data;
    end
        
endmodule
