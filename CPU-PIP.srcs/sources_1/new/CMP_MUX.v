`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 13:32:10
// Design Name: 
// Module Name: CMP_MUX
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


module CMP_MUX(
  input CmpSrc2,//只有输入口2需要做选择
  input [31:0]imm,
  input [31:0]rd2,
  output [31:0]CMP_Src2
    );
  assign CMP_Src2 = (CmpSrc2 == 1) ? imm : rd2;
endmodule
