`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/05/24 14:25:00
// Design Name:
// Module Name: CPU_BC
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 001 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module CPU_BC(

  );
  parameter period = 2;
  parameter hperiod =1;
  parameter times =10;
  reg [31:0] i;
  reg reset;//复位信号
  reg clk;
  wire  [31:0]      PC;
  wire              branch;
  wire  [1:0]       cmp;
  wire              branch_W;
  wire  [31:0]      Aluout;
  wire  [1:0]       CMPout;
  wire  [31:0]      instruct;
  wire  [6:0]       opcode;
  wire  [4:0]       rs1;
  wire  [4:0]       rs2;
  wire  [4:0]       rd;
  wire  [2:0]       funct3;
  wire  [6:0]       funct7;
  wire  [31:0]      next_PC;
  wire  [31:0]      WB_OUT;
  wire  [31:0]      WB_OUT_W;
  wire  [31:0]      rd1;
  wire  [31:0]      rd2;
  wire  [31:0]      imm;
  wire  [2:0]       Reg_Src;//写回寄存器数据来源
  wire              Sign;//输入为有符号数还是无符号数；=>ALU、MUX_WB、CMP + 数据存储器数据载入拓展方式
  wire  [2:0]       ALuop;//ALU进行操作
  wire              ALU_Src1;//ALU数据1来源
  wire              ALU_Src2;//ALU数据2来源
  //wire            Reg_W;//寄存器写使能
  //wire            Contol_PC;//PC值跳转方式
  //wire            CmpSrc1;//比较器来源1
  wire              CmpSrc2;//比较器来源2
  wire              Data_W;//存储器写使能
  wire  [1:0]       Data_Byte;//存储器操作位数
  wire  [31:0]      DataOut;
  wire  [31:0]      EXEdebug;
   wire PcControl;
  wire [31:0] debug1; 
wire [31:0] debug2;
wire [31:0] debug3; 
wire [31:0] debug4; 
wire [31:0] debug5; 
wire [31:0] debug6; 
wire [31:0] debug7; 
wire [31:0] debug8; 
wire [31:0] debug9; 
wire [31:0] debug10; 
wire [31:0] debug11;
wire [31:0] debug12; 
wire [31:0] debug13; 
wire [31:0] debug14; 
wire [31:0] debug15; 
wire [31:0] debug16; 
wire [31:0] debug17; 
wire [31:0] debug18; 
wire [31:0] debug19; 
wire [31:0] debug20; 
wire [31:0] debug21; 
wire [31:0] debug22; 
wire [31:0] debug23; 
wire [31:0] debug24; 
wire [31:0] debug25; 
wire [31:0] debug26; 
wire [31:0] debug27;
wire [31:0] debug28; 
wire [31:0] debug29; 
wire [31:0] debug30; 
wire [31:0] debug31; 
wire [31:0] debug32;
wire [31:0] Reg_IF;
wire [31:0] Reg_ID;
wire [31:0] Reg_EXE;
wire [31:0] Reg_MEM;
wire Reg_W;
wire Reg_WB;
wire [3:0] state;
  CPU_top uut(
    clk,
    reset,
   PC,
   branch,
   //cmp,
    branch_W,
   Aluout,
   CMPout,
   instruct,
   opcode,
   rs1,
   rs2,
   rd,
   funct3,
   funct7,
   next_PC,
   WB_OUT,
   WB_OUT_W,
   rd1,
   rd2,
   imm,
   Reg_Src,//写回寄存器数据来源
   Sign,//输入为有符号数还是无符号数；=>ALU、MUX_WB、CMP + 数据存储器数据载入拓展方式
   ALuop,//ALU进行操作
   ALU_Src1,//ALU数据1来源
   ALU_Src2,//ALU数据2来源
    //wire            Reg_W;//寄存器写使能
    //wire            Contol_PC;//PC值跳转方式
    //wire            CmpSrc1;//比较器来源1
   CmpSrc2,//比较器来源2
   Data_W,//存储器写使能
   Data_Byte,//存储器操作位数
   DataOut,
   EXEdebug,
   PcControl,
   debug1, 
debug2, 
debug3, 
debug4, 
debug5, 
debug6, 
debug7, 
debug8, 
debug9, 
debug10, 
debug11,
debug12, 
debug13, 
debug14, 
debug15, 
debug16, 
debug17, 
debug18, 
debug19, 
debug20, 
debug21, 
debug22, 
debug23, 
debug24, 
debug25, 
debug26, 
debug27, 
debug28, 
debug29, 
debug30, 
debug31, 
debug32,
Reg_IF,
Reg_ID,
Reg_EXE,
Reg_MEM,
Reg_W,
Reg_WB,
state
    );
  initial
  begin
       clk = 0;
       reset = 0;
  end
  always #hperiod clk = !clk;
endmodule



