`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2022 10:56:04
// Design Name: 
// Module Name: proc_tb
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

module proc_tb; 
 
  logic rst, clk; 
  core DUT(.rst(rst),.clk(clk)); 

  initial begin
	 clk = 1'b0; #100;
  repeat(400000)
   begin
	  clk = 1'b1; #50;
	  clk = 1'b0; #50;
   end
	 clk = 1'b1; #50;
  end

  initial begin
	 rst = 1'b1; #100;
	 rst = 1'b0; #10000000;
	 $finish;
  end
endmodule
