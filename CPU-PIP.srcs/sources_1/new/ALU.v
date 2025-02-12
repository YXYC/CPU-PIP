`timescale 1ns / 1ps
`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/21 14:22:32
// Design Name: 
// Module Name: ALU
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

//ALU计算模块
//可以实现基本比较（有符号比较以及无符号比较）以及运算
module ALU (
            input    wire [31: 0]    A,
            input    wire [31: 0]    B,
            input    wire [2: 0]     ALUop,
            input    wire            Unsigned,
            output   wire [31: 0]    out
        );
 // 计算结果
 wire [31: 0]        addOut;
 wire [31: 0]        subOut;
 wire [31: 0]        andOut;
 wire [31: 0]        orOut;
 wire [31: 0]        xorOut;
 wire [31: 0]        sllOut;
 wire [31: 0]        srlOut;
 wire [31: 0]        sraOut;
 wire                trash_bit;
 // 输出寄存器
 reg [31: 0]         out_reg;
 /***************************************************************
                         运算
 ****************************************************************/
 // 减法复用加法器: 减数取反末位加一
 wire [32: 0] addA;
 wire [32: 0] addB;
 wire         subOpe;
 assign subOpe = (ALUop == `SUB);
 assign addA   = {A[31: 0], subOpe};
 assign addB   = (subOpe) ? {(~B), 1'b1} : {B, 1'b0};
 // 计算输出
 assign {addOut[31: 0], trash_bit} = addA[32: 0] + addB[32: 0];
 assign andOut[31: 0]              = A[31: 0] & B[31: 0];
 assign orOut[31: 0]               = A[31: 0] | B[31: 0];
 assign xorOut[31: 0]              = A[31: 0] ^ B[31: 0];
 assign sllOut[31: 0]              = (Unsigned == `UNSIGNED) ? B[31: 0] : A[31: 0] << $unsigned(B[4: 0]);  // Lui指令特殊处理
 assign srlOut[31: 0]              = A[31: 0] >> $unsigned(B[4: 0]);
 assign sraOut[31: 0]              = $signed(A[31: 0]) >>> $unsigned(B[4: 0]);
 /***************************************************************
                         输出选择
 ****************************************************************/
 assign out = out_reg;
 always @(*) begin
     case (ALUop)
         `AND: begin
             out_reg[31: 0] = andOut[31: 0];
         end
         `OR: begin
             out_reg[31: 0] = orOut[31: 0];
         end
         `XOR: begin
             out_reg[31: 0] = xorOut[31: 0];
         end
         `SLL: begin
             out_reg[31: 0] = sllOut[31: 0];
         end
         `SRL: begin
             out_reg[31: 0] = srlOut[31: 0];
         end
         `SRA: begin
             out_reg[31: 0] = sraOut[31: 0];
         end
         default: begin  // ADD or SUB
             out_reg[31: 0] = addOut[31: 0];
         end
     endcase
 end
 endmodule