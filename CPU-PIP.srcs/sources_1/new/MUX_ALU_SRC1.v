`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/23 18:43:28
// Design Name: 
// Module Name: MUX_ALU_SRC_2
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


module MUX_ALU_SRC_1(
    input wire [31:0] rd1,
    input wire [31:0] PC,
    input wire ALU_Src1,
    output wire [31:0] AluSrc1
    );
    assign AluSrc1 = (ALU_Src1 == 1) ? PC : rd1;
endmodule
