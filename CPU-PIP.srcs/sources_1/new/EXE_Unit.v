`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 11:57:29
// Design Name: 
// Module Name: EXE_Unit
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

//CMP（比较器）+ALU（运算器）+3*MUX（选择器）
module EXE_Unit(
    input    wire [31: 0]    rd1,
    input    wire [31: 0]    rd2,
    input    wire [31: 0]    PC,
    input    wire [31: 0]    imm,
    input    wire [2: 0]     ALUop,
    input    wire            Sign,
    input    wire            ALU_Src1,
    input    wire            ALU_Src2,
    input    wire            CmpSrc2,
    output   wire [1:0]      CMPout, 
    output   wire [31: 0]    Aluout,
    output   wire [31:0]     debug
    );

    wire [31:0] ALUSrc1;
    wire [31:0] ALUSrc2;
    wire [31:0] CMP_Src2;
    assign debug = ALUop;
    
    MUX_ALU_SRC_1 MUX_1(
    .rd1(rd1),
    .PC(PC),
    .ALU_Src1(ALU_Src1),
    .AluSrc1(ALUSrc1)
    );

    MUX_ALU_SRC_2 MUX_2(
    .rd2(rd2),
    .imm(imm),
    .ALU_Src2(ALU_Src2),
    .AluSrc2(ALUSrc2)
    );

    CMP_MUX MUX_3(
   .CmpSrc2(CmpSrc2),//只有输入口2需要做选择
   .imm(imm),
   .rd2(rd2),
   .CMP_Src2(CMP_Src2)
    );

    ALU ALU_Unit(
    .A(ALUSrc1),
    .B(ALUSrc2),
    .ALUop(ALUop),
    .Unsigned(Sign),
    .out(Aluout)
    );

    CMP CMP_Unit(
    .A(rd1), //比较器输入口1恒为rd1
    .B(CMP_Src2),
    .Unsigned(Sign),//是否为无符号数
    .out(CMPout)
    );
endmodule