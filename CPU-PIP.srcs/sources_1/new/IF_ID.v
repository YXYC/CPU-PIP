`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 22:40:11
// Design Name: 
// Module Name: IF_ID
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

//IF模块以及ID模块的寄存器
module IF_ID(
  input wire CLK,
  input wire state,

  //IF模块数据输入
  input wire [31:0] instruct,//对应输出的指令
  input wire [6:0] opcode,//输入控制模块产生控制信号
  input wire [4:0] rd,//写入寄存器堆的地址，如果有的话
  input wire [4:0] rs1,//读出寄存器的地址，如果有的话
  input wire [4:0] rs2,//读出寄存器的地址，如果有的话
  input wire [2:0] funct3,
  input wire [6:0] funct7,
  input wire [31:0] next_PC,
  input wire [31:0] now_PC,//输出即当前指令地址 

  //输出到ID模块
  output reg [127:0] IF_Data//指令类型
    );
  
  initial
  begin
    IF_Data[31:0]  = instruct;
    IF_Data[38:32] = opcode;
    IF_Data[43:39] = rd;
    IF_Data[48:44] = rs1;
    IF_Data[53:49] = rs2;
    IF_Data[56:54] = funct3;
    IF_Data[63:57] = funct7;
    IF_Data[95:64] = next_PC;
    IF_Data[127:96]= now_PC;
  end
  
  //时钟下降沿写入数据（IF模块下降沿更新nextPC数据）
  always @(negedge CLK) begin
    IF_Data[31:0] <= instruct;
    IF_Data[38:32] <= opcode;
    IF_Data[43:39] <= rd;
    IF_Data[48:44] <= rs1;
    IF_Data[53:49] <= rs2;
    IF_Data[56:54] <= funct3;
    IF_Data[63:57] <= funct7;
    IF_Data[95:64] <= next_PC;
    IF_Data[127:96]<= now_PC;
  end
  
   

endmodule
