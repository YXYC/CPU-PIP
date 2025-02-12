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


module MUX_ALU_SRC_2(
    input wire [31:0] rd2,
    input wire [31:0] imm,
    input wire ALU_Src2,
    output wire [31:0] AluSrc2
    );
    assign AluSrc2 = (ALU_Src2 == 1) ? rd2 : imm;
endmodule
