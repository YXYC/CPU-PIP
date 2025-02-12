`timescale 1ns / 1ps
`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 19:25:27
// Design Name: 
// Module Name: CMP
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

//比较器
module CMP(
            input   wire [31: 0]    A,
            input   wire [31: 0]    B,
            input   wire            Unsigned,//是否为无符号数
            output  wire [1: 0]     out
        );
 wire [31: 0] Ain;
 wire [31: 0] Bin;
 wire equal;
 wire less;
 reg [1: 0] out_reg;
 
 // 有符号数转换为移码
 assign Ain[30: 0] = A[30: 0];
 assign Ain[31]    = (Unsigned == `UNSIGNED) ? A[31] : ~A[31];
 assign Bin[30: 0] = B[30: 0];
 assign Bin[31]    = (Unsigned == `UNSIGNED) ? B[31] : ~B[31];
 // 比较运算
 assign equal = ($unsigned(Ain) == $unsigned(Bin)) ? 1'b1 : 1'b0;
 assign less  = ($unsigned(Ain) < $unsigned(Bin)) ? 1'b1 : 1'b0;
 
 assign out = out_reg;
 always @(*) begin
     if (equal) begin
         out_reg = `CMP_EQ;
     end
     else if (less) begin
         out_reg = `CMP_LE;
     end
     else begin
         out_reg = `CMP_GE;
     end
 end

 endmodule
