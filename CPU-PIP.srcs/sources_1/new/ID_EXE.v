`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 22:40:11
// Design Name: 
// Module Name: ID_EXE
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


module ID_EXE(
    input CLK,
    input wire [31:0] reg_1_data,         
    input wire [31:0] reg_2_data,         
    input wire [31:0] imm,//输出对应的立即数
    //控制信号
    input wire [2:0]Reg_Src,//写回寄存器数据来源
    input wire Sign,//输入为有符号数还是无符号数；=>ALU、MUX_WB、CMP + 数据存储器数据载入拓展方式
    input wire [2:0] ALUop,//ALU进行操作
    input wire ALU_Src1,//ALU数据1来源
    input wire ALU_Src2,//ALU数据2来源
    //input wire Reg_W,//寄存器写使能
    //input wire Contol_PC,//PC值跳转方式
    //input wire CmpSrc1,//比较器来源1
    input wire CmpSrc2,//比较器来源2
    input wire Data_W,//存储器写使能
    input wire [1:0] Data_Byte,//存储器操作位数
    input wire [2:0] branch, //判断是哪一种跳转指令
    input wire branch_W,//是否需要分支判断
    input wire Reg_W,
    output reg [113:0] ID_data
    );

    always @(negedge CLK) begin
      ID_data [31:0] <= reg_1_data;
      ID_data [63:32] <= reg_2_data;
      ID_data [95:64] <= imm;
      ID_data [98:96] <= Reg_Src;
      ID_data [99] <= Sign;
      ID_data [102:100] <= ALUop;
      ID_data [103] <= ALU_Src1;
      ID_data [104] <= ALU_Src2;
      ID_data [105] <= CmpSrc2;
      ID_data [106] <= Data_W;
      ID_data [108:107] <= Data_Byte;
      ID_data [111:109] <= branch;
      ID_data [112] <= branch_W;
      ID_data [113] <= Reg_W;
    end
    
    initial
  begin
   ID_data = 114'b0;
  end
    
endmodule
