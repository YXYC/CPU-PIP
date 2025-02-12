`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 11:37:14
// Design Name: 
// Module Name: Branch
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

//译码模块（control）+ 寄存器堆（RegisterFile） + ImmGen（立即数拓展模块）
module ID_Unit(
    input wire [6:0] opcode,//指令类型
    input wire [2:0] funct3,//指令功能
    input wire [6:0] funct7,
    input wire [31:0] inst,//输入指令
    input wire clk,                       
    //input wire reg_write_sig,             
    input wire[4:0] reg_r1_addr,          
    input wire[4:0] reg_r2_addr,         
    input wire[4:0] reg_w1_addr,         
    input wire[31:0] write_data,    
    input wire       Reg_WB,
    //output wire [31:0] debug [31:0],
    output wire [31:0] reg_1_data,         
    output wire [31:0] reg_2_data,         
    output wire [31:0] imm,//输出对应的立即数
    //控制信号
    output wire [2:0]Reg_Src,//写回寄存器数据来源
    output wire Sign,//输入为有符号数还是无符号数；=>ALU、MUX_WB、CMP + 数据存储器数据载入拓展方式
    output wire [2:0] ALUop,//ALU进行操作
    output wire ALU_Src1,//ALU数据1来源
    output wire ALU_Src2,//ALU数据2来源
    output wire Reg_W,//寄存器写使能
    //output wire Contol_PC,//PC值跳转方式
    //output wire CmpSrc1,//比较器来源1
    output wire CmpSrc2,//比较器来源2
    output wire Data_W,//存储器写使能
    output wire [1:0] Data_Byte,//存储器操作位数
    output wire [2:0] branch, //判断是哪一种跳转指令
    output wire branch_W,//是否需要分支判断
    output wire [31:0] debug1, 
        output wire [31:0] debug2, 
        output wire [31:0] debug3, 
        output wire [31:0] debug4, 
        output wire [31:0] debug5, 
        output wire [31:0] debug6, 
        output wire [31:0] debug7, 
        output wire [31:0] debug8, 
        output wire [31:0] debug9, 
        output wire [31:0] debug10, 
        output wire [31:0] debug11,
        output wire [31:0] debug12, 
        output wire [31:0] debug13, 
        output wire [31:0] debug14, 
        output wire [31:0] debug15, 
        output wire [31:0] debug16, 
        output wire [31:0] debug17, 
        output wire [31:0] debug18, 
        output wire [31:0] debug19, 
        output wire [31:0] debug20, 
        output wire [31:0] debug21, 
        output wire [31:0] debug22, 
        output wire [31:0] debug23, 
        output wire [31:0] debug24, 
        output wire [31:0] debug25, 
        output wire [31:0] debug26, 
        output wire [31:0] debug27, 
        output wire [31:0] debug28, 
        output wire [31:0] debug29, 
        output wire [31:0] debug30, 
        output wire [31:0] debug31, 
        output wire [31:0] debug32 
    );

    //wire Reg_W;//存储器写使能

    ControlUnit Contol(
    .clk(clk),
    .opcode(opcode),//指令类型
    .funct3(funct3),//指令功能
    .funct7(funct7),

    //控制信号
    .Reg_Src(Reg_Src),//写回寄存器数据来源
    .Sign(Sign),//输入为有符号数还是无符号数；=>ALU、MUX_WB、CMP + 数据存储器数据载入拓展方式

    .ALUop(ALUop),//ALU进行操作
    .ALU_Src1(ALU_Src1),//ALU数据1来源
    .ALU_Src2(ALU_Src2),//ALU数据2来源
    .Reg_W(Reg_W),//寄存器写使能
    //output wire Contol_PC,//PC值跳转方式
    //output wire CmpSrc1,//比较器来源1
    .CmpSrc2(CmpSrc2),//比较器来源2
    .Data_W(Data_W),//存储器写使能
    .Data_Byte(Data_Byte),//存储器操作位数
    .branch(branch), //判断是哪一种跳转指令
    .branch_W(branch_W)//是否需要分支判断
  );

  ImmGEN ImmGEN_Unit(
    .inst(inst),//输入指令
    .imm(imm)//输出对应的立即数
  );
  
  RegFile RegFiles(
        .clk(clk),                       //clock input signals
        .reg_write_sig(Reg_WB),             //indicate whether a write operation is required
        .reg_r1_addr(reg_r1_addr),          //address of the first register to be read
        .reg_r2_addr(reg_r2_addr),          //address of the second register to be read
        .reg_w1_addr(reg_w1_addr),         //address of the first register to be write
        .write_data(write_data),          //date to be written to the register
        .reg_1_data(reg_1_data),         //data that read from the first register
        .reg_2_data(reg_2_data),         //data that read from the second register
         .debug1(debug1),
       .debug2(debug2),
       .debug3(debug3),
       .debug4(debug4),
       .debug5(debug5),
       .debug6(debug6),
       .debug7(debug7),
       .debug8(debug8),
       .debug9(debug9),
       .debug10(debug10),
       .debug11(debug11),
       .debug12(debug12),
       .debug13(debug13),
       .debug14(debug14),
       .debug15(debug15),
       .debug16(debug16),
       .debug17(debug17),
       .debug18(debug18),
       .debug19(debug19),
       .debug20(debug20),
       .debug21(debug21),
       .debug22(debug22),
       .debug23(debug23),
       .debug24(debug24),
       .debug25(debug25),
       .debug26(debug26),
       .debug27(debug27),
       .debug28(debug28),
       .debug29(debug29),
       .debug30(debug30),
       .debug31(debug31),
       .debug32(debug32)
    );
endmodule
