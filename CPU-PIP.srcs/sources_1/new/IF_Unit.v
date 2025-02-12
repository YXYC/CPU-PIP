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

//取指模块：branch + PC +InsMEM
module IF_Unit(
    input wire reset,//复位信号
    input wire CLK,
    input wire [2:0]branch,
    input wire [1:0]cmp,
    input wire branch_W,
    input wire [31:0] Jump_PC,
    //input wire IN_PC_W,//PC写使能

    output wire [31:0] instruct,//对应输出的指令
    output wire [6:0] opcode,//输入控制模块产生控制信号
    output wire [4:0] rd,//写入寄存器堆的地址，如果有的话
    output wire [4:0] rs1,//读出寄存器的地址，如果有的话
    output wire [4:0] rs2,//读出寄存器的地址，如果有的话
    output wire [2:0] funct3,
    output wire [6:0] funct7,
    output wire [31:0] next_PC,
    output wire [31:0] now_PC,//输出即当前指令地址 
    output wire PcControl
    );
    wire PC_control;
    assign PcControl = PC_control;
    
    Branch BranchUnit(
    .branch(branch),
    .cmp(cmp),
    .branch_W(branch_W),
    .PC_control(PC_control)
    );

    PC PC_Unit(
    .reset(reset),//复位信号
    .CLK(CLK),
    .Contol_PC(PC_control),//1：顺序取指 0：分支取指
    .Jump_PC(Jump_PC),//跳转地址值
    .next_PC(next_PC),
    .now_PC(now_PC)//输出即当前指令地址
  );

  InsMEM InsMEM_Unit(
    .PC(now_PC),//要读出指令的地址
    .instruct(instruct),//对应输出的指令
    .opcode(opcode),//输入控制模块产生控制信号
    .rd(rd),//写入寄存器堆的地址，如果有的话
    .rs1(rs1),//读出寄存器的地址，如果有的话
    .rs2(rs2),//读出寄存器的地址，如果有的话
    .funct3(funct3),
    .funct7(funct7)
    );
endmodule
