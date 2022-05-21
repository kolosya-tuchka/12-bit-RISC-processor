`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 14:23:41
// Design Name: 
// Module Name: reg_32
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


module reg_256(
    input write, read, clk,
    input [11:0] in,
    input [7:0] addr,
    output [11:0] data
    );
    
    logic [11:0] R[255:0];
    logic [7:0] r_addr;
    
    assign r_addr = addr[7:0];
    assign data = (read) ? R[r_addr] : 12'hzzz;
    
    always @(posedge clk) begin
        if (write) R[r_addr] <= in;
    end    
    
endmodule
