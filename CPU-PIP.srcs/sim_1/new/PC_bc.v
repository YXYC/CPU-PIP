`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/05/22 17:34:43
// Design Name:
// Module Name: PC_bc
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

//取值模块检测
module IF_bc(

  );

  parameter period = 10;
  parameter hperiod =5;
  parameter times =10;
  reg [31:0] i;
      reg reset;//复位信号
      reg CLK;
      reg Contol_PC;//1：顺序取指 0：分支取指
      reg [11:0] Jump_PC;//跳转地址值
      wire [11:0] now_PC;//输出即当前指令地址
      wire [11:0] next_PC;

      PC PC_UNIT(
        . reset(reset),//复位信号
        . CLK(CLK),
        . Contol_PC(Contol_PC),//1：顺序取指 0：分支取指
        . Jump_PC(Jump_PC),//跳转地址值
        . next_PC(next_PC),
        . now_PC(now_PC)//输出即当前指令地址
      );

  wire [31:0] instruct;//对应输出的指令
  wire [6:0] opcode;//输入控制模块产生控制信号
  wire[4:0] rd;//写入寄存器堆的地址，如果有的话
  wire [4:0] rs1;//读出寄存器的地址，如果有的话
  wire [4:0] rs2;//读出寄存器的地址，如果有的话
  wire [2:0] funct3;
  wire [6:0] funct7;

  InsMEM  InsMEM_UNIT(
      . clk(CLK),
      . PC(now_PC),//要读出指令的地址
      . instruct(instruct),//对应输出的指令
      . opcode(opcode),//输入控制模块产生控制信号
      . rd(rd),//写入寄存器堆的地址，如果有的话
      . rs1(rs1),//读出寄存器的地址，如果有的话
      . rs2(rs2),//读出寄存器的地址，如果有的话
      . funct3(funct3),
      . funct7(funct7)
    );

  initial
  begin
    CLK = 0;
    reset = 0;
    #period
    //reset = 1;
    for ( i= 0;i<100 ; i=i+1) begin
        #period
        reset = 0;
        i = i;
        if(i == 50) reset = 1;
    end
   end
   always #hperiod CLK = !CLK;
endmodule
