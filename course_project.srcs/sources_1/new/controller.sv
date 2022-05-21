`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2022 09:07:39
// Design Name: 
// Module Name: controller
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


module controller(
    input clk, rst,
    input [3:0] ins,
    input logic cmp,
    output logic write_r, read_r, PC_en, ac_ena, ram_ena, rom_ena,
    output logic ram_write, ram_read, rom_read, ad_sel, gto, sel_ac,
    output logic [1:0] fetch
    );

logic [4:0] state;
logic [4:0] next_state;


// instructions
parameter 	NOP=4'b0000, // no operation
			LDO=4'b0001, // load ROM to register
			LDA=4'b0010, // load RAM to register
			STO=4'b0011, // Store intermediate results to accumulator
			PRE=4'b0100, // Prefetch Data from Address
			ADD=4'b0101, // Adds the contents of the memory address or integer to the accumulator
			LDM=4'b0110, // Load Multiple
			HLT=4'b0111, // Halt
			CNT=4'b1000, // Count_12
			GBY=4'b1001, // Get byte from RAM with accum-address
			GBI=4'b1010, // Get bit from 
			CMP=4'b1011, // Compare
			GTO=4'b1100; // Go to 

// states		 
parameter Sidle=5'h1f,
			 S0=5'd0,
			 S1=5'd1,
			 S2=5'd2,
			 S3=5'd3,
			 S4=5'd4,
			 S5=5'd5,
			 S6=5'd6,
			 S7=5'd7,
			 S8=5'd8,
			 S9=5'd9,
			 S10=5'd10,
			 S11=5'd11,
			 S12=5'd12,
			 S13=5'd13;
			 
always @(posedge clk or posedge rst) 
begin
	if(rst) state<=Sidle;
	else state<=next_state;
end

//Next-state combinational logic
always @*
begin
case(state)
S1:		begin
			if (ins==NOP) next_state=S0;
			else if (ins==HLT)  next_state=S2;
			else if (ins==PRE | ins==ADD | ins==CNT | ins==GBY | ins==GBI | ins==CMP | ins==GTO) next_state=S9;
			else if (ins==LDM) next_state=S11;
			else next_state=S3;
		end

S4:		begin
			if (ins==LDA | ins==LDO) next_state=S5;
			else if (ins==STO) next_state=S7; 
		end
Sidle:	next_state=S0;
S0:		next_state=S1;
S2:	    next_state=S2;
S3:		next_state=S4;
S5:		next_state=S6;
S6:		next_state=S0;
S7:		next_state=S8;
S8:		next_state=S0;
S9:		begin
            if (ins==GBY) next_state=S0;
            else next_state=S10;
        end
S10:	begin
            if (ins==GTO) next_state=S13; 
            else next_state=S0;
        end
S11:	next_state=S12;
S12:	next_state=S0;
S13:    next_state=S0;
default: next_state=Sidle;
endcase
end

//Combinational logic
always@*
begin 
case(state)
Sidle: begin
     write_r=1'b0;
     read_r=1'b0;
     PC_en=1'b0; 
     ac_ena=1'b0;
     ram_ena=1'b0;
     rom_ena=1'b0;
     ram_write=1'b0;
     ram_read=1'b0;
     rom_read=1'b0;
     ad_sel=1'b0;
     gto=1'b0;
     sel_ac=0;
     fetch=2'b00;
     end
S0: begin // load IR
     write_r=0;
     read_r=0;
     PC_en=0;
     ac_ena=0;
     ram_ena=0;
     rom_ena=1;
     ram_write=0;
     ram_read=0;
     rom_read=1;
     ad_sel=0;
     gto=1'b0;
     sel_ac=0;
     fetch=2'b01;
     end
S1: begin
     write_r=0;
     read_r=0;
     PC_en=1; 
     ac_ena=0;
     ram_ena=0;
     ram_write=0;
     ram_read=0;
     rom_ena=1;
     rom_read=1; 
     ad_sel=0;
     gto=1'b0;
     sel_ac=0;
     fetch=2'b00;
     end
S2: begin
     write_r=0;
     read_r=0;
     PC_en=0;
     ac_ena=0;
     ram_ena=0;
     rom_ena=0;
     ram_write=0;
     ram_read=0;
     rom_read=0;
     ad_sel=0;
     sel_ac=0;
     gto=1'b0;
     fetch=2'b00;
     end
S3: begin 
     write_r=0;
     read_r=0;
     PC_en=0;
     ac_ena=1; 
     ram_ena=0;
     rom_ena=1;
     ram_write=0;
     ram_read=0;
     rom_read=1;
     ad_sel=0;
     sel_ac=0;
     gto=1'b0;
     fetch=2'b10; 
     end
S4: begin
     write_r=0;
     read_r=0;
     PC_en=1;
     ac_ena=1;
     ram_ena=0;
     ram_write=0;
     ram_read=0;
     rom_ena=1; 
     rom_read=1;
     ad_sel=0;
     sel_ac=0;
     gto=1'b0;
     fetch=2'b10; 
     end
S5: begin
     if (ins==LDO)
         begin
         write_r=1;
         read_r=0;
         PC_en=0;
         ac_ena=1;
         ram_ena=0;
         ram_write=0;
         ram_read=0;
         rom_ena=1;
         rom_read=1;
         ad_sel=1;
         sel_ac=0;
         gto=1'b0;
         fetch=2'b01; 		 
         end
     else
         begin
         write_r=1;
         read_r=0;
         PC_en=0;
         ac_ena=1;
         ram_ena=1;
         ram_write=0;
         ram_read=1;
         rom_ena=0;
         rom_read=0;
         ad_sel=1;
         sel_ac=0;
         gto=1'b0;
         fetch=2'b01;
         end	 
     end
S6: begin 
	 write_r=1'b0;
     read_r=1'b0;
     PC_en=1'b0;
     ac_ena=1'b0;
     ram_ena=1'b0;
     rom_ena=1'b0;
     ram_write=1'b0;
     ram_read=1'b0;
     rom_read=1'b0;
     ad_sel=1'b0;
     sel_ac=0;
     gto=1'b0;
     fetch=2'b00;
	 end
S7: begin // STO 1
     write_r=0;
     read_r=1;
     PC_en=0;
     ac_ena=0;
     ram_ena=0;
     rom_ena=0;
     ram_write=0;
     ram_read=0;
     rom_read=0;
     ad_sel=0;
     sel_ac=0;
     gto=1'b0;
     fetch=2'b00;
     end
S8: begin // STO 2
     write_r=0;
     read_r=1;
     PC_en=0;
     ac_ena=0;
     rom_read=0;
     rom_ena=0;
     ram_ena=1;
     ram_write=1;
     ram_read=0;
     ad_sel=1;
     sel_ac=0;
     gto=1'b0;
     fetch=2'b00;
     end
S9: begin 
     if (ins==GBY)
         begin
         write_r=0;
         read_r=0;
         PC_en=0;
         ac_ena=1;
         ram_ena=1;
         rom_ena=0;
         ram_write=0;
         ram_read=1;
         rom_read=0;
         ad_sel=0;
         sel_ac=1;
         gto=1'b0;
         fetch=2'b00;
         end
     else if (ins==PRE) // REG->ACCUM
         begin
         write_r=0;
         read_r=1;
         PC_en=0;
         ac_ena=1;
         ram_ena=0;
         rom_ena=0;
         ram_write=0;
         ram_read=0;
         rom_read=0;
         ad_sel=0;
         sel_ac=0;
         gto=1'b0;
         fetch=2'b00;
         end
     else 
         begin 
         write_r=0;
         read_r=1;
         PC_en=0;
         ac_ena=1;
         ram_ena=0;
         rom_ena=0;
         ram_write=0;
         ram_read=0;
         rom_read=0;
         ad_sel=0;
         sel_ac=0;
         gto=(ins==GTO) ? !cmp : 1'b0;
         fetch=2'b00;		 
        end 
     end
S10: begin 
     if (ins==GTO)
         begin
         write_r=0;
         read_r=1;
         PC_en=gto;
         ac_ena=0;
         ram_ena=0;
         rom_ena=0;
         ram_write=0;
         ram_read=0;
         rom_read=0;
         ad_sel=0;
         sel_ac=0;
         fetch=2'b00;
         end
     else
         begin
         write_r=0;
         read_r=1;
         PC_en=0;
         ac_ena=0;
         ram_ena=0;
         rom_ena=0;
         ram_write=0;
         ram_read=0;
         rom_read=0;
         ad_sel=0;
         sel_ac=0;
         gto=1'b0;
         fetch=2'b00;
         end
     end
S11: begin // LDM 1
     write_r=1;
     read_r=0;
     PC_en=0;
     ac_ena=1;
     ram_ena=0;
     ram_write=0;
     ram_read=0;
     rom_ena=1;
     rom_read=1;
     ad_sel=0;
     sel_ac=0;
     gto=1'b0;
     fetch=2'b00;	
     end
S12: begin 
     write_r=0;
     read_r=0;
     PC_en=0;
     ac_ena=0;
     ram_ena=0;
     rom_ena=0;
     ram_write=0;
     ram_read=0;
     rom_read=0;
     ad_sel=0;
     sel_ac=0;
     gto=1'b0;
     fetch=2'b00;	 
     end
S13: begin 
     write_r=0;
     read_r=1;
     PC_en=gto;
     ac_ena=0;
     ram_ena=0;
     rom_ena=0;
     ram_write=0;
     ram_read=0;
     rom_read=0;
     ad_sel=0;
     sel_ac=0;
     fetch=2'b00;	 
     end
default: begin
     write_r=0;
     read_r=0;
     PC_en=0;
     ac_ena=0;
     ram_ena=0;
     rom_ena=0;
     ram_write=0;
     ram_read=0;
     rom_read=0;
     ad_sel=0;
     gto=1'b0;
     sel_ac=0;
     fetch=2'b00;		 
     end
endcase
end
endmodule

