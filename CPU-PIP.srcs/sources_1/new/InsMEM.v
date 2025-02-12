`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 22:14:00
// Design Name: 
// Module Name: Instruction memory
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

//指令存储器，输入为目标指令地址，输出为目标指令，输出为采用调用IP核BlockRom的方式，在每个时钟周期下降沿读出指令
//读出指令后，对指令进行分解
module InsMEM (
    input wire [31:0] PC,//要读出指令的地址
    output reg [31:0] instruct,//对应输出的指令
    output reg [6:0] opcode,//输入控制模块产生控制信号
    output reg [4:0] rd,//写入寄存器堆的地址，如果有的话
    output reg [4:0] rs1,//读出寄存器的地址，如果有的话
    output reg [4:0] rs2,//读出寄存器的地址，如果有的话
    output reg [2:0] funct3,
    output reg [6:0] funct7
    );
    //reg [3:0] flag;
    wire [31:0] instruct_data;
    //对指令进行分割
    always@(*)begin
    instruct=instruct_data;
     opcode [6:0] = instruct_data[6:0] ;
     rd [4:0] =instruct_data[11:7];
     rs1 [4:0]=instruct_data[19:15];
     rs2 [4:0]=instruct_data[24:20];
     funct3[2:0]=instruct_data[14:12];
     funct7[6:0]=instruct_data[31:25];
    end
    dist_mem_gen_0 ROM(.a(PC[11:2]),.spo(instruct_data));//数据宽度为32，四个字节，PC右移两位即除四
endmodule