`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2022 11:44:48
// Design Name: 
// Module Name: ROM
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


module rom(
    input read, ena,
    input [11:0] addr,
    output [11:0] data
    );
    
    logic [11:0] memory[4095:0];
    
    initial begin
        
        //init regs    
        memory[544] = 12'b0001_00000001;
        memory[545] = 12'b1000_00000000; //reg[1] <- rom[2048] (n primary number)
        memory[546] = 12'b0001_00000010;
        memory[547] = 12'b1000_00000001; //reg[2] <- rom[2049] (current primary number(i))
        memory[548] = 12'b0001_00000011;
        memory[549] = 12'b1000_00000010; //reg[3] <- rom[2050] (current address)
        memory[550] = 12'b0001_00000100;
        memory[551] = 12'b1000_00000011; //reg[4] <- rom[2051] (current number)
        memory[552] = 12'b0001_00000101;
        memory[553] = 12'b1000_00000100; //reg[5] <- rom[2052] (current bit/byte)
        memory[554] = 12'b0001_00000110;
        memory[555] = 12'b1000_00000101; //reg[6] <- rom[2053] (increment)
        memory[556] = 12'b0001_00000111;
        memory[557] = 12'b1000_00000110; //reg[7] <- rom[2054] (goto instruction)
        
        //starting instructions. Without them, the result will be greater by one 
        memory[558] = 12'b0000_00000000; // NOP
        memory[559] = 12'b0100_00000011; // PRE
        memory[560] = 12'b1001_00000000; // GBY
        memory[561] = 12'b1010_00000011; // GBI
        memory[562] = 12'b0101_00000010; // ADD
        memory[563] = 12'b0110_00000010; // LDM
        memory[564] = 12'b0100_00000011; 
        memory[565] = 12'b1000_00000000; // CNT
        memory[566] = 12'b0110_00000011;
        
        //loop part
        memory[567] = 12'b0000_00000000;
        memory[568] = 12'b0000_00000000;
        memory[569] = 12'b0100_00000011;
        memory[570] = 12'b1001_00000000;
        memory[571] = 12'b1010_00000011;
        memory[572] = 12'b0101_00000010;
        memory[573] = 12'b0110_00000010;
        memory[574] = 12'b0100_00000011; 
        memory[575] = 12'b1000_00000000;
        memory[576] = 12'b0110_00000011;
        memory[577] = 12'b0100_00000100;
        memory[578] = 12'b0101_00000110;
        memory[579] = 12'b0110_00000100;
        memory[580] = 12'b0100_00000010;
        memory[581] = 12'b1011_00000001; // CMP
        memory[582] = 12'b1100_00000111; // GTO
        
        //storage the result
        memory[583] = 12'b0000_00000000;
        memory[584] = 12'b0100_00000100; 
        memory[585] = 12'b0111_00000000;
        
        //regs(vars)
        memory[2048] = 12'b0000_10000001; //n primary number
        memory[2049] = 12'b0000_00000000; //0
        memory[2050] = 12'b0000_00000000; //0
        memory[2051] = 12'b0000_00000000; //0
        memory[2052] = 12'b0000_00000000; //0
        memory[2053] = 12'b0000_00000001; //increment
        memory[2054] = 12'b0010_00111000; //go to instruction
        
        //���������� ��� �������� ������ ���������� � ����������� ������
        memory[0] = 12'b0001_00000001;
        memory[1] = 12'b0100_00000000;
        memory[2] = 12'b0011_00000001;
        memory[3] = 12'b0000_00000000;
        memory[4] = 12'b0001_00000001;
        memory[5] = 12'b0100_00000001;
        memory[6] = 12'b0011_00000001;
        memory[7] = 12'b0000_00000001;
        memory[8] = 12'b0001_00000001;
        memory[9] = 12'b0100_00000010;
        memory[10] = 12'b0011_00000001;
        memory[11] = 12'b0000_00000010;
        memory[12] = 12'b0001_00000001;
        memory[13] = 12'b0100_00000011;
        memory[14] = 12'b0011_00000001;
        memory[15] = 12'b0000_00000011;
        memory[16] = 12'b0001_00000001;
        memory[17] = 12'b0100_00000100;
        memory[18] = 12'b0011_00000001;
        memory[19] = 12'b0000_00000100;
        memory[20] = 12'b0001_00000001;
        memory[21] = 12'b0100_00000101;
        memory[22] = 12'b0011_00000001;
        memory[23] = 12'b0000_00000101;
        memory[24] = 12'b0001_00000001;
        memory[25] = 12'b0100_00000110;
        memory[26] = 12'b0011_00000001;
        memory[27] = 12'b0000_00000110;
        memory[28] = 12'b0001_00000001;
        memory[29] = 12'b0100_00000111;
        memory[30] = 12'b0011_00000001;
        memory[31] = 12'b0000_00000111;
        memory[32] = 12'b0001_00000001;
        memory[33] = 12'b0100_00001000;
        memory[34] = 12'b0011_00000001;
        memory[35] = 12'b0000_00001000;
        memory[36] = 12'b0001_00000001;
        memory[37] = 12'b0100_00001001;
        memory[38] = 12'b0011_00000001;
        memory[39] = 12'b0000_00001001;
        memory[40] = 12'b0001_00000001;
        memory[41] = 12'b0100_00001010;
        memory[42] = 12'b0011_00000001;
        memory[43] = 12'b0000_00001010;
        memory[44] = 12'b0001_00000001;
        memory[45] = 12'b0100_00001011;
        memory[46] = 12'b0011_00000001;
        memory[47] = 12'b0000_00001011;
        memory[48] = 12'b0001_00000001;
        memory[49] = 12'b0100_00001100;
        memory[50] = 12'b0011_00000001;
        memory[51] = 12'b0000_00001100;
        memory[52] = 12'b0001_00000001;
        memory[53] = 12'b0100_00001101;
        memory[54] = 12'b0011_00000001;
        memory[55] = 12'b0000_00001101;
        memory[56] = 12'b0001_00000001;
        memory[57] = 12'b0100_00001110;
        memory[58] = 12'b0011_00000001;
        memory[59] = 12'b0000_00001110;
        memory[60] = 12'b0001_00000001;
        memory[61] = 12'b0100_00001111;
        memory[62] = 12'b0011_00000001;
        memory[63] = 12'b0000_00001111;
        memory[64] = 12'b0001_00000001;
        memory[65] = 12'b0100_00010000;
        memory[66] = 12'b0011_00000001;
        memory[67] = 12'b0000_00010000;
        memory[68] = 12'b0001_00000001;
        memory[69] = 12'b0100_00010001;
        memory[70] = 12'b0011_00000001;
        memory[71] = 12'b0000_00010001;
        memory[72] = 12'b0001_00000001;
        memory[73] = 12'b0100_00010010;
        memory[74] = 12'b0011_00000001;
        memory[75] = 12'b0000_00010010;
        memory[76] = 12'b0001_00000001;
        memory[77] = 12'b0100_00010011;
        memory[78] = 12'b0011_00000001;
        memory[79] = 12'b0000_00010011;
        memory[80] = 12'b0001_00000001;
        memory[81] = 12'b0100_00010100;
        memory[82] = 12'b0011_00000001;
        memory[83] = 12'b0000_00010100;
        memory[84] = 12'b0001_00000001;
        memory[85] = 12'b0100_00010101;
        memory[86] = 12'b0011_00000001;
        memory[87] = 12'b0000_00010101;
        memory[88] = 12'b0001_00000001;
        memory[89] = 12'b0100_00010110;
        memory[90] = 12'b0011_00000001;
        memory[91] = 12'b0000_00010110;
        memory[92] = 12'b0001_00000001;
        memory[93] = 12'b0100_00010111;
        memory[94] = 12'b0011_00000001;
        memory[95] = 12'b0000_00010111;
        memory[96] = 12'b0001_00000001;
        memory[97] = 12'b0100_00011000;
        memory[98] = 12'b0011_00000001;
        memory[99] = 12'b0000_00011000;
        memory[100] = 12'b0001_00000001;
        memory[101] = 12'b0100_00011001;
        memory[102] = 12'b0011_00000001;
        memory[103] = 12'b0000_00011001;
        memory[104] = 12'b0001_00000001;
        memory[105] = 12'b0100_00011010;
        memory[106] = 12'b0011_00000001;
        memory[107] = 12'b0000_00011010;
        memory[108] = 12'b0001_00000001;
        memory[109] = 12'b0100_00011011;
        memory[110] = 12'b0011_00000001;
        memory[111] = 12'b0000_00011011;
        memory[112] = 12'b0001_00000001;
        memory[113] = 12'b0100_00011100;
        memory[114] = 12'b0011_00000001;
        memory[115] = 12'b0000_00011100;
        memory[116] = 12'b0001_00000001;
        memory[117] = 12'b0100_00011101;
        memory[118] = 12'b0011_00000001;
        memory[119] = 12'b0000_00011101;
        memory[120] = 12'b0001_00000001;
        memory[121] = 12'b0100_00011110;
        memory[122] = 12'b0011_00000001;
        memory[123] = 12'b0000_00011110;
        memory[124] = 12'b0001_00000001;
        memory[125] = 12'b0100_00011111;
        memory[126] = 12'b0011_00000001;
        memory[127] = 12'b0000_00011111;
        memory[128] = 12'b0001_00000001;
        memory[129] = 12'b0100_00100000;
        memory[130] = 12'b0011_00000001;
        memory[131] = 12'b0000_00100000;
        memory[132] = 12'b0001_00000001;
        memory[133] = 12'b0100_00100001;
        memory[134] = 12'b0011_00000001;
        memory[135] = 12'b0000_00100001;
        memory[136] = 12'b0001_00000001;
        memory[137] = 12'b0100_00100010;
        memory[138] = 12'b0011_00000001;
        memory[139] = 12'b0000_00100010;
        memory[140] = 12'b0001_00000001;
        memory[141] = 12'b0100_00100011;
        memory[142] = 12'b0011_00000001;
        memory[143] = 12'b0000_00100011;
        memory[144] = 12'b0001_00000001;
        memory[145] = 12'b0100_00100100;
        memory[146] = 12'b0011_00000001;
        memory[147] = 12'b0000_00100100;
        memory[148] = 12'b0001_00000001;
        memory[149] = 12'b0100_00100101;
        memory[150] = 12'b0011_00000001;
        memory[151] = 12'b0000_00100101;
        memory[152] = 12'b0001_00000001;
        memory[153] = 12'b0100_00100110;
        memory[154] = 12'b0011_00000001;
        memory[155] = 12'b0000_00100110;
        memory[156] = 12'b0001_00000001;
        memory[157] = 12'b0100_00100111;
        memory[158] = 12'b0011_00000001;
        memory[159] = 12'b0000_00100111;
        memory[160] = 12'b0001_00000001;
        memory[161] = 12'b0100_00101000;
        memory[162] = 12'b0011_00000001;
        memory[163] = 12'b0000_00101000;
        memory[164] = 12'b0001_00000001;
        memory[165] = 12'b0100_00101001;
        memory[166] = 12'b0011_00000001;
        memory[167] = 12'b0000_00101001;
        memory[168] = 12'b0001_00000001;
        memory[169] = 12'b0100_00101010;
        memory[170] = 12'b0011_00000001;
        memory[171] = 12'b0000_00101010;
        memory[172] = 12'b0001_00000001;
        memory[173] = 12'b0100_00101011;
        memory[174] = 12'b0011_00000001;
        memory[175] = 12'b0000_00101011;
        memory[176] = 12'b0001_00000001;
        memory[177] = 12'b0100_00101100;
        memory[178] = 12'b0011_00000001;
        memory[179] = 12'b0000_00101100;
        memory[180] = 12'b0001_00000001;
        memory[181] = 12'b0100_00101101;
        memory[182] = 12'b0011_00000001;
        memory[183] = 12'b0000_00101101;
        memory[184] = 12'b0001_00000001;
        memory[185] = 12'b0100_00101110;
        memory[186] = 12'b0011_00000001;
        memory[187] = 12'b0000_00101110;
        memory[188] = 12'b0001_00000001;
        memory[189] = 12'b0100_00101111;
        memory[190] = 12'b0011_00000001;
        memory[191] = 12'b0000_00101111;
        memory[192] = 12'b0001_00000001;
        memory[193] = 12'b0100_00110000;
        memory[194] = 12'b0011_00000001;
        memory[195] = 12'b0000_00110000;
        memory[196] = 12'b0001_00000001;
        memory[197] = 12'b0100_00110001;
        memory[198] = 12'b0011_00000001;
        memory[199] = 12'b0000_00110001;
        memory[200] = 12'b0001_00000001;
        memory[201] = 12'b0100_00110010;
        memory[202] = 12'b0011_00000001;
        memory[203] = 12'b0000_00110010;
        memory[204] = 12'b0001_00000001;
        memory[205] = 12'b0100_00110011;
        memory[206] = 12'b0011_00000001;
        memory[207] = 12'b0000_00110011;
        memory[208] = 12'b0001_00000001;
        memory[209] = 12'b0100_00110100;
        memory[210] = 12'b0011_00000001;
        memory[211] = 12'b0000_00110100;
        memory[212] = 12'b0001_00000001;
        memory[213] = 12'b0100_00110101;
        memory[214] = 12'b0011_00000001;
        memory[215] = 12'b0000_00110101;
        memory[216] = 12'b0001_00000001;
        memory[217] = 12'b0100_00110110;
        memory[218] = 12'b0011_00000001;
        memory[219] = 12'b0000_00110110;
        memory[220] = 12'b0001_00000001;
        memory[221] = 12'b0100_00110111;
        memory[222] = 12'b0011_00000001;
        memory[223] = 12'b0000_00110111;
        memory[224] = 12'b0001_00000001;
        memory[225] = 12'b0100_00111000;
        memory[226] = 12'b0011_00000001;
        memory[227] = 12'b0000_00111000;
        memory[228] = 12'b0001_00000001;
        memory[229] = 12'b0100_00111001;
        memory[230] = 12'b0011_00000001;
        memory[231] = 12'b0000_00111001;
        memory[232] = 12'b0001_00000001;
        memory[233] = 12'b0100_00111010;
        memory[234] = 12'b0011_00000001;
        memory[235] = 12'b0000_00111010;
        memory[236] = 12'b0001_00000001;
        memory[237] = 12'b0100_00111011;
        memory[238] = 12'b0011_00000001;
        memory[239] = 12'b0000_00111011;
        memory[240] = 12'b0001_00000001;
        memory[241] = 12'b0100_00111100;
        memory[242] = 12'b0011_00000001;
        memory[243] = 12'b0000_00111100;
        memory[244] = 12'b0001_00000001;
        memory[245] = 12'b0100_00111101;
        memory[246] = 12'b0011_00000001;
        memory[247] = 12'b0000_00111101;
        memory[248] = 12'b0001_00000001;
        memory[249] = 12'b0100_00111110;
        memory[250] = 12'b0011_00000001;
        memory[251] = 12'b0000_00111110;
        memory[252] = 12'b0001_00000001;
        memory[253] = 12'b0100_00111111;
        memory[254] = 12'b0011_00000001;
        memory[255] = 12'b0000_00111111;
        memory[256] = 12'b0001_00000001;
        memory[257] = 12'b0100_01000000;
        memory[258] = 12'b0011_00000001;
        memory[259] = 12'b0000_01000000;
        memory[260] = 12'b0001_00000001;
        memory[261] = 12'b0100_01000001;
        memory[262] = 12'b0011_00000001;
        memory[263] = 12'b0000_01000001;
        memory[264] = 12'b0001_00000001;
        memory[265] = 12'b0100_01000010;
        memory[266] = 12'b0011_00000001;
        memory[267] = 12'b0000_01000010;
        memory[268] = 12'b0001_00000001;
        memory[269] = 12'b0100_01000011;
        memory[270] = 12'b0011_00000001;
        memory[271] = 12'b0000_01000011;
        memory[272] = 12'b0001_00000001;
        memory[273] = 12'b0100_01000100;
        memory[274] = 12'b0011_00000001;
        memory[275] = 12'b0000_01000100;
        memory[276] = 12'b0001_00000001;
        memory[277] = 12'b0100_01000101;
        memory[278] = 12'b0011_00000001;
        memory[279] = 12'b0000_01000101;
        memory[280] = 12'b0001_00000001;
        memory[281] = 12'b0100_01000110;
        memory[282] = 12'b0011_00000001;
        memory[283] = 12'b0000_01000110;
        memory[284] = 12'b0001_00000001;
        memory[285] = 12'b0100_01000111;
        memory[286] = 12'b0011_00000001;
        memory[287] = 12'b0000_01000111;
        memory[288] = 12'b0001_00000001;
        memory[289] = 12'b0100_01001000;
        memory[290] = 12'b0011_00000001;
        memory[291] = 12'b0000_01001000;
        memory[292] = 12'b0001_00000001;
        memory[293] = 12'b0100_01001001;
        memory[294] = 12'b0011_00000001;
        memory[295] = 12'b0000_01001001;
        memory[296] = 12'b0001_00000001;
        memory[297] = 12'b0100_01001010;
        memory[298] = 12'b0011_00000001;
        memory[299] = 12'b0000_01001010;
        memory[300] = 12'b0001_00000001;
        memory[301] = 12'b0100_01001011;
        memory[302] = 12'b0011_00000001;
        memory[303] = 12'b0000_01001011;
        memory[304] = 12'b0001_00000001;
        memory[305] = 12'b0100_01001100;
        memory[306] = 12'b0011_00000001;
        memory[307] = 12'b0000_01001100;
        memory[308] = 12'b0001_00000001;
        memory[309] = 12'b0100_01001101;
        memory[310] = 12'b0011_00000001;
        memory[311] = 12'b0000_01001101;
        memory[312] = 12'b0001_00000001;
        memory[313] = 12'b0100_01001110;
        memory[314] = 12'b0011_00000001;
        memory[315] = 12'b0000_01001110;
        memory[316] = 12'b0001_00000001;
        memory[317] = 12'b0100_01001111;
        memory[318] = 12'b0011_00000001;
        memory[319] = 12'b0000_01001111;
        memory[320] = 12'b0001_00000001;
        memory[321] = 12'b0100_01010000;
        memory[322] = 12'b0011_00000001;
        memory[323] = 12'b0000_01010000;
        memory[324] = 12'b0001_00000001;
        memory[325] = 12'b0100_01010001;
        memory[326] = 12'b0011_00000001;
        memory[327] = 12'b0000_01010001;
        memory[328] = 12'b0001_00000001;
        memory[329] = 12'b0100_01010010;
        memory[330] = 12'b0011_00000001;
        memory[331] = 12'b0000_01010010;
        memory[332] = 12'b0001_00000001;
        memory[333] = 12'b0100_01010011;
        memory[334] = 12'b0011_00000001;
        memory[335] = 12'b0000_01010011;
        memory[336] = 12'b0001_00000001;
        memory[337] = 12'b0100_01010100;
        memory[338] = 12'b0011_00000001;
        memory[339] = 12'b0000_01010100;
        memory[340] = 12'b0001_00000001;
        memory[341] = 12'b0100_01010101;
        memory[342] = 12'b0011_00000001;
        memory[343] = 12'b0000_01010101;
        memory[344] = 12'b0001_00000001;
        memory[345] = 12'b0100_01010110;
        memory[346] = 12'b0011_00000001;
        memory[347] = 12'b0000_01010110;
        memory[348] = 12'b0001_00000001;
        memory[349] = 12'b0100_01010111;
        memory[350] = 12'b0011_00000001;
        memory[351] = 12'b0000_01010111;
        memory[352] = 12'b0001_00000001;
        memory[353] = 12'b0100_01011000;
        memory[354] = 12'b0011_00000001;
        memory[355] = 12'b0000_01011000;
        memory[356] = 12'b0001_00000001;
        memory[357] = 12'b0100_01011001;
        memory[358] = 12'b0011_00000001;
        memory[359] = 12'b0000_01011001;
        memory[360] = 12'b0001_00000001;
        memory[361] = 12'b0100_01011010;
        memory[362] = 12'b0011_00000001;
        memory[363] = 12'b0000_01011010;
        memory[364] = 12'b0001_00000001;
        memory[365] = 12'b0100_01011011;
        memory[366] = 12'b0011_00000001;
        memory[367] = 12'b0000_01011011;
        memory[368] = 12'b0001_00000001;
        memory[369] = 12'b0100_01011100;
        memory[370] = 12'b0011_00000001;
        memory[371] = 12'b0000_01011100;
        memory[372] = 12'b0001_00000001;
        memory[373] = 12'b0100_01011101;
        memory[374] = 12'b0011_00000001;
        memory[375] = 12'b0000_01011101;
        memory[376] = 12'b0001_00000001;
        memory[377] = 12'b0100_01011110;
        memory[378] = 12'b0011_00000001;
        memory[379] = 12'b0000_01011110;
        memory[380] = 12'b0001_00000001;
        memory[381] = 12'b0100_01011111;
        memory[382] = 12'b0011_00000001;
        memory[383] = 12'b0000_01011111;
        memory[384] = 12'b0001_00000001;
        memory[385] = 12'b0100_01100000;
        memory[386] = 12'b0011_00000001;
        memory[387] = 12'b0000_01100000;
        memory[388] = 12'b0001_00000001;
        memory[389] = 12'b0100_01100001;
        memory[390] = 12'b0011_00000001;
        memory[391] = 12'b0000_01100001;
        memory[392] = 12'b0001_00000001;
        memory[393] = 12'b0100_01100010;
        memory[394] = 12'b0011_00000001;
        memory[395] = 12'b0000_01100010;
        memory[396] = 12'b0001_00000001;
        memory[397] = 12'b0100_01100011;
        memory[398] = 12'b0011_00000001;
        memory[399] = 12'b0000_01100011;
        memory[400] = 12'b0001_00000001;
        memory[401] = 12'b0100_01100100;
        memory[402] = 12'b0011_00000001;
        memory[403] = 12'b0000_01100100;
        memory[404] = 12'b0001_00000001;
        memory[405] = 12'b0100_01100101;
        memory[406] = 12'b0011_00000001;
        memory[407] = 12'b0000_01100101;
        memory[408] = 12'b0001_00000001;
        memory[409] = 12'b0100_01100110;
        memory[410] = 12'b0011_00000001;
        memory[411] = 12'b0000_01100110;
        memory[412] = 12'b0001_00000001;
        memory[413] = 12'b0100_01100111;
        memory[414] = 12'b0011_00000001;
        memory[415] = 12'b0000_01100111;
        memory[416] = 12'b0001_00000001;
        memory[417] = 12'b0100_01101000;
        memory[418] = 12'b0011_00000001;
        memory[419] = 12'b0000_01101000;
        memory[420] = 12'b0001_00000001;
        memory[421] = 12'b0100_01101001;
        memory[422] = 12'b0011_00000001;
        memory[423] = 12'b0000_01101001;
        memory[424] = 12'b0001_00000001;
        memory[425] = 12'b0100_01101010;
        memory[426] = 12'b0011_00000001;
        memory[427] = 12'b0000_01101010;
        memory[428] = 12'b0001_00000001;
        memory[429] = 12'b0100_01101011;
        memory[430] = 12'b0011_00000001;
        memory[431] = 12'b0000_01101011;
        memory[432] = 12'b0001_00000001;
        memory[433] = 12'b0100_01101100;
        memory[434] = 12'b0011_00000001;
        memory[435] = 12'b0000_01101100;
        memory[436] = 12'b0001_00000001;
        memory[437] = 12'b0100_01101101;
        memory[438] = 12'b0011_00000001;
        memory[439] = 12'b0000_01101101;
        memory[440] = 12'b0001_00000001;
        memory[441] = 12'b0100_01101110;
        memory[442] = 12'b0011_00000001;
        memory[443] = 12'b0000_01101110;
        memory[444] = 12'b0001_00000001;
        memory[445] = 12'b0100_01101111;
        memory[446] = 12'b0011_00000001;
        memory[447] = 12'b0000_01101111;
        memory[448] = 12'b0001_00000001;
        memory[449] = 12'b0100_01110000;
        memory[450] = 12'b0011_00000001;
        memory[451] = 12'b0000_01110000;
        memory[452] = 12'b0001_00000001;
        memory[453] = 12'b0100_01110001;
        memory[454] = 12'b0011_00000001;
        memory[455] = 12'b0000_01110001;
        memory[456] = 12'b0001_00000001;
        memory[457] = 12'b0100_01110010;
        memory[458] = 12'b0011_00000001;
        memory[459] = 12'b0000_01110010;
        memory[460] = 12'b0001_00000001;
        memory[461] = 12'b0100_01110011;
        memory[462] = 12'b0011_00000001;
        memory[463] = 12'b0000_01110011;
        memory[464] = 12'b0001_00000001;
        memory[465] = 12'b0100_01110100;
        memory[466] = 12'b0011_00000001;
        memory[467] = 12'b0000_01110100;
        memory[468] = 12'b0001_00000001;
        memory[469] = 12'b0100_01110101;
        memory[470] = 12'b0011_00000001;
        memory[471] = 12'b0000_01110101;
        memory[472] = 12'b0001_00000001;
        memory[473] = 12'b0100_01110110;
        memory[474] = 12'b0011_00000001;
        memory[475] = 12'b0000_01110110;
        memory[476] = 12'b0001_00000001;
        memory[477] = 12'b0100_01110111;
        memory[478] = 12'b0011_00000001;
        memory[479] = 12'b0000_01110111;
        memory[480] = 12'b0001_00000001;
        memory[481] = 12'b0100_01111000;
        memory[482] = 12'b0011_00000001;
        memory[483] = 12'b0000_01111000;
        memory[484] = 12'b0001_00000001;
        memory[485] = 12'b0100_01111001;
        memory[486] = 12'b0011_00000001;
        memory[487] = 12'b0000_01111001;
        memory[488] = 12'b0001_00000001;
        memory[489] = 12'b0100_01111010;
        memory[490] = 12'b0011_00000001;
        memory[491] = 12'b0000_01111010;
        memory[492] = 12'b0001_00000001;
        memory[493] = 12'b0100_01111011;
        memory[494] = 12'b0011_00000001;
        memory[495] = 12'b0000_01111011;
        memory[496] = 12'b0001_00000001;
        memory[497] = 12'b0100_01111100;
        memory[498] = 12'b0011_00000001;
        memory[499] = 12'b0000_01111100;
        memory[500] = 12'b0001_00000001;
        memory[501] = 12'b0100_01111101;
        memory[502] = 12'b0011_00000001;
        memory[503] = 12'b0000_01111101;
        memory[504] = 12'b0001_00000001;
        memory[505] = 12'b0100_01111110;
        memory[506] = 12'b0011_00000001;
        memory[507] = 12'b0000_01111110;
        memory[508] = 12'b0001_00000001;
        memory[509] = 12'b0100_01111111;
        memory[510] = 12'b0011_00000001;
        memory[511] = 12'b0000_01111111;
        memory[512] = 12'b0001_00000001;
        memory[513] = 12'b0100_10000000;
        memory[514] = 12'b0011_00000001;
        memory[515] = 12'b0000_10000000;
        memory[516] = 12'b0001_00000001;
        memory[517] = 12'b0100_10000001;
        memory[518] = 12'b0011_00000001;
        memory[519] = 12'b0000_10000001;
        memory[520] = 12'b0001_00000001;
        memory[521] = 12'b0100_10000010;
        memory[522] = 12'b0011_00000001;
        memory[523] = 12'b0000_10000010;
        memory[524] = 12'b0001_00000001;
        memory[525] = 12'b0100_10000011;
        memory[526] = 12'b0011_00000001;
        memory[527] = 12'b0000_10000011;
        memory[528] = 12'b0001_00000001;
        memory[529] = 12'b0100_10000100;
        memory[530] = 12'b0011_00000001;
        memory[531] = 12'b0000_10000100;
        memory[532] = 12'b0001_00000001;
        memory[533] = 12'b0100_10000101;
        memory[534] = 12'b0011_00000001;
        memory[535] = 12'b0000_10000101;
        memory[536] = 12'b0001_00000001;
        memory[537] = 12'b0100_10000110;
        memory[538] = 12'b0011_00000001;
        memory[539] = 12'b0000_10000110;
        memory[540] = 12'b0001_00000001;
        memory[541] = 12'b0100_10000111;
        memory[542] = 12'b0011_00000001;
        memory[543] = 12'b0000_10000111;
        
        //������ ����������
        memory[1024] = 12'b0111_01010011;
        memory[1025] = 12'b0111_01011101;
        memory[1026] = 12'b1111_01011111;
        memory[1027] = 12'b0111_01011101;
        memory[1028] = 12'b0111_11011111;
        memory[1029] = 12'b0111_01111101;
        memory[1030] = 12'b0111_01111101;
        memory[1031] = 12'b1111_11011111;
        memory[1032] = 12'b0111_01011101;
        memory[1033] = 12'b1111_11011101;
        memory[1034] = 12'b0111_01111111;
        memory[1035] = 12'b1111_01011111;
        memory[1036] = 12'b1111_01011111;
        memory[1037] = 12'b0111_01111101;
        memory[1038] = 12'b0111_11011111;
        memory[1039] = 12'b0111_11111101;
        memory[1040] = 12'b1111_01011101;
        memory[1041] = 12'b1111_01111111;
        memory[1042] = 12'b0111_01111111;
        memory[1043] = 12'b0111_11011101;
        memory[1044] = 12'b0111_11111101;
        memory[1045] = 12'b0111_11011111;
        memory[1046] = 12'b1111_01011111;
        memory[1047] = 12'b1111_01011101;
        memory[1048] = 12'b1111_11011111;
        memory[1049] = 12'b0111_01111111;
        memory[1050] = 12'b1111_11011101;
        memory[1051] = 12'b1111_01111111;
        memory[1052] = 12'b0111_11111101;
        memory[1053] = 12'b0111_11011101;
        memory[1054] = 12'b1111_01111111;
        memory[1055] = 12'b0111_01111101;
        memory[1056] = 12'b1111_11011111;
        memory[1057] = 12'b1111_11011101;
        memory[1058] = 12'b0111_11111101;
        memory[1059] = 12'b0111_11111101;
        memory[1060] = 12'b0111_01111101;
        memory[1061] = 12'b1111_11011111;
        memory[1062] = 12'b0111_01011101;
        memory[1063] = 12'b0111_11111111;
        memory[1064] = 12'b0111_01111111;
        memory[1065] = 12'b0111_01111111;
        memory[1066] = 12'b1111_11011111;
        memory[1067] = 12'b1111_01011111;
        memory[1068] = 12'b1111_11111111;
        memory[1069] = 12'b1111_01111101;
        memory[1070] = 12'b0111_11011111;
        memory[1071] = 12'b1111_01011111;
        memory[1072] = 12'b0111_11111101;
        memory[1073] = 12'b0111_11011111;
        memory[1074] = 12'b1111_01111101;
        memory[1075] = 12'b1111_01011101;
        memory[1076] = 12'b1111_01111111;
        memory[1077] = 12'b0111_01011111;
        memory[1078] = 12'b0111_11011111;
        memory[1079] = 12'b1111_11111101;
        memory[1080] = 12'b0111_11011101;
        memory[1081] = 12'b1111_01111111;
        memory[1082] = 12'b1111_11011111;
        memory[1083] = 12'b0111_11111101;
        memory[1084] = 12'b1111_01111111;
        memory[1085] = 12'b0111_01111101;
        memory[1086] = 12'b1111_01111111;
        memory[1087] = 12'b1111_11011101;
        memory[1088] = 12'b1111_11011101;
        memory[1089] = 12'b1111_01111111;
        memory[1090] = 12'b1111_11011111;
        memory[1091] = 12'b1111_01011111;
        memory[1092] = 12'b0111_01011111;
        memory[1093] = 12'b0111_11111101;
        memory[1094] = 12'b1111_11111111;
        memory[1095] = 12'b0111_01011101;
        memory[1096] = 12'b1111_11111111;
        memory[1097] = 12'b0111_01011101;
        memory[1098] = 12'b1111_11111111;
        memory[1099] = 12'b0111_01111111;
        memory[1100] = 12'b1111_01111111;
        memory[1101] = 12'b1111_11011111;
        memory[1102] = 12'b0111_11011101;
        memory[1103] = 12'b1111_11011111;
        memory[1104] = 12'b0111_01111111;
        memory[1105] = 12'b0111_11011111;
        memory[1106] = 12'b1111_01111111;
        memory[1107] = 12'b1111_11111101;
        memory[1108] = 12'b0111_11011101;
        memory[1109] = 12'b0111_11111101;
        memory[1110] = 12'b1111_01111101;
        memory[1111] = 12'b1111_01011111;
        memory[1112] = 12'b1111_01011111;
        memory[1113] = 12'b1111_11111101;
        memory[1114] = 12'b0111_01111111;
        memory[1115] = 12'b0111_11011101;
        memory[1116] = 12'b1111_11011111;
        memory[1117] = 12'b1111_01111101;
        memory[1118] = 12'b1111_11111101;
        memory[1119] = 12'b0111_11111111;
        memory[1120] = 12'b0111_11111101;
        memory[1121] = 12'b1111_01111111;
        memory[1122] = 12'b0111_11011111;
        memory[1123] = 12'b1111_11011111;
        memory[1124] = 12'b1111_11111101;
        memory[1125] = 12'b0111_11011101;
        memory[1126] = 12'b1111_01011111;
        memory[1127] = 12'b1111_11111101;
        memory[1128] = 12'b0111_11111101;
        memory[1129] = 12'b1111_11111111;
        memory[1130] = 12'b0111_01011111;
        memory[1131] = 12'b1111_01011111;
        memory[1132] = 12'b0111_01011101;
        memory[1133] = 12'b0111_11111111;
        memory[1134] = 12'b1111_01111101;
        memory[1135] = 12'b1111_11111111;
        memory[1136] = 12'b1111_11111111;
        memory[1137] = 12'b0111_11011111;
        memory[1138] = 12'b1111_11011111;
        memory[1139] = 12'b1111_11111101;
        memory[1140] = 12'b1111_01111111;
        memory[1141] = 12'b1111_11011111;
        memory[1142] = 12'b0111_01111111;
        memory[1143] = 12'b0111_11011101;
        memory[1144] = 12'b0111_01111111;
        memory[1145] = 12'b1111_01111101;
        memory[1146] = 12'b1111_01111111;
        memory[1147] = 12'b0111_01011111;
        memory[1148] = 12'b0111_11011101;
        memory[1149] = 12'b0111_11111111;
        memory[1150] = 12'b0111_11111111;
        memory[1151] = 12'b1111_01111111;
        memory[1152] = 12'b1111_01111111;
        memory[1153] = 12'b0111_11011101;
        memory[1154] = 12'b0111_01111111;
        memory[1155] = 12'b0111_01111111;
        memory[1156] = 12'b1111_11111111;
        memory[1157] = 12'b0111_11011101;
        memory[1158] = 12'b0111_11011101;
        memory[1159] = 12'b1111_01111101;

    end
    
    assign data = (read && ena) ? memory[addr] : 12'hzzz;
    
endmodule
