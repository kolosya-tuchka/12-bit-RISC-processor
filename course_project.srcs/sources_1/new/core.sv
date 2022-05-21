`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 14:55:56
// Design Name: 
// Module Name: core
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


module core(
    input clk, rst
    );	

logic write_r, read_r, PC_en, ac_ena, ram_ena, rom_ena;
logic ram_write, ram_read, rom_read, ad_sel, ad_sel2, gto;

logic [1:0] fetch;
wire [11:0] data, addr;
logic [11:0] accum_out, alu_out;
logic [11:0] ir_ad, pc_ad;
logic [7:0] reg_ad;
logic [3:0] ins;

ram RAM1(.data(data), 
         .addr(addr), 
         .ena(ram_ena), 
         .read(ram_read), 
         .write(ram_write));

rom ROM1(.data(data), 
         .addr(addr), 
         .ena(rom_ena), 
         .read(rom_read));

addr_mux MUX1(.addr(addr), 
              .sel(ad_sel),
              .sel_ac(ad_sel2), 
              .ir_ad(ir_ad), 
              .pc_ad(pc_ad),
              .accum(accum_out));
              
prog_counter PC1(.pc_addr(pc_ad),
            .gto(gto),
            .accum(accum_out), 
            .clock(clk), 
            .rst(rst), 
            .ena(PC_en));

accum ACCUM1(.out(accum_out), 
             .in(alu_out), 
             .ena(ac_ena), 
             .clk(clk), 
             .rst(rst));

alu ALU1(.alu_out(alu_out), 
         .alu_in(data), 
         .accum(accum_out), 
         .op(ins));

reg_256 REG1(.in(alu_out), 
            .data(data), 
            .write(write_r), 
            .read(read_r), 
            .addr(reg_ad), 
            .clk(clk));	

ins_reg IR1(.data(data), 
            .fetch(fetch), 
            .clk(clk), 
            .rst(rst), 
            .ins(ins), 
            .ad1(reg_ad), 
            .ad2(ir_ad));

controller CONTROLLER1(.ins(ins), 
					.clk(clk), 
					.rst(rst), 
					.write_r(write_r), 
					.read_r(read_r), 
					.PC_en(PC_en), 
					.fetch(fetch), 
					.ac_ena(ac_ena), 
					.ram_ena(ram_ena), 
					.rom_ena(rom_ena),
					.ram_write(ram_write), 
					.ram_read(ram_read), 
					.rom_read(rom_read), 
					.ad_sel(ad_sel),
					.sel_ac(ad_sel2),
					.gto(gto),
					.cmp(alu_out[0])
					);
endmodule
