`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/04/24 00:06:41
// Design Name:
// Module Name: PC
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

//指令计数器，有两种指令计数模式：一种是程序正常进行自增，一种是程序跳转
//时钟上升沿：写入信号 时钟下降沿：更新信号
//顺序取值在PC内实现自加即可，但分支取值需要知道相应的跳转地址值
module PC(
    input wire reset,//复位信号
    input wire CLK,
    //input wire IN_PC_W,//PC写使能
    input wire Contol_PC,//1：顺序取指 0：分支取指
    input wire [31:0] Jump_PC,//跳转地址值
    output reg [31:0] next_PC,
    output reg [31:0] now_PC//输出即当前指令地址
  );
  reg [2:0] PC_W;//PC写使能
  //reg [12:0] next_PC;//下一指令值
  //初始化初始值为0
  
  
  initial
  begin
    PC_W = 3'b111; 
    now_PC =32'hfffffffc;
  end

  always@(negedge CLK)//时钟下降沿写入新地址
  begin
   PC_W <= PC_W+1; 
   if(PC_W == 4) PC_W <= 0;
    case (Contol_PC)
      1'b0:
        next_PC <= now_PC+4;//顺序取指
      1'b1:
        next_PC <= Jump_PC;//分支取指
      default:
        next_PC <= now_PC+4;
    endcase
  end

  always @(posedge CLK or posedge reset)//时钟上升沿或者复位信号更新指令
  begin
    if(reset) now_PC <= 0;
    else if(PC_W == 0) begin 
    now_PC <= next_PC;
    PC_W <= 0;
    end
  end
endmodule
