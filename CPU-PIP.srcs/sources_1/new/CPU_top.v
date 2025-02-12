`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 13:48:23
// Design Name: 
// Module Name: CPU_top
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


module CPU_top(
    input clk,
    input reset,
    output wire  [31:0]      PC,
    output wire  [2:0]       branch,
    //output wire  [1:0]       cmp,
    output wire              branch_W,
    output wire  [31:0]      Aluout,
    output wire  [1:0]       CMPout,
    output wire  [31:0]      instruct,
    output wire  [6:0]       opcode,
    output wire  [4:0]       rs1,
    output wire  [4:0]       rs2,
    output wire  [4:0]       rd,
    output wire  [2:0]       funct3,
    output wire  [6:0]       funct7,
    output wire  [31:0]      next_PC,
    output wire  [31:0]      WB_OUT,
    output wire  [31:0]      WB_OUT_W,
    output wire  [31:0]      rd1,
    output wire  [31:0]      rd2,
    output wire  [31:0]      imm,
    output wire  [2:0]       Reg_Src,//写回寄存器数据来源
    output wire              Sign,//输入为有符号数还是无符号数；=>ALU、MUX_WB、CMP + 数据存储器数据载入拓展方式
    output wire  [2:0]       ALuop,//ALU进行操作
    output wire              ALU_Src1,//ALU数据1来源
    output wire              ALU_Src2,//ALU数据2来源
    //wire            Reg_W;//寄存器写使能
    //wire            Contol_PC;//PC值跳转方式
    //wire            CmpSrc1;//比较器来源1
    output wire              CmpSrc2,//比较器来源2
    output wire              Data_W,//存储器写使能
    output wire  [1:0]       Data_Byte,//存储器操作位数
    output wire  [31:0]      DataOut,
    output wire  [31:0]      EXEdebug,
    output wire PcControl,
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
        output wire [31:0] debug32,
        output wire [31:0] Reg_IF,
        output wire [31:0] Reg_ID,
        output wire [31:0] Reg_EXE,
        output wire [31:0] Reg_MEM,
        output wire Reg_W,
        output wire Reg_WB,
        output wire [3:0] state 
    );

    //测试
    
    wire [127:0] IF_Data;
    wire [113:0] ID_data;
    wire [34:0] EXE_Data;
    wire [32:0] MEM_data;
    
    
    assign Reg_IF = IF_Data;
    assign Reg_ID = ID_data;
    assign Reg_EXE = EXE_Data;
    assign Reg_MEM = MEM_data[32:1];
    
    IF_Unit IF(
    .reset(reset),//复位信号
    .CLK(clk),
    .branch(ID_data [111:109]),
    .cmp(EXE_Data[1:0]),
    .branch_W(ID_data [112]),
    .Jump_PC(EXE_Data[33:2]),
    .instruct(instruct),//对应输出的指令
    .opcode(opcode),//输入控制模块产生控制信号
    .rd(rd),//写入寄存器堆的地址，如果有的话
    .rs1(rs1),//读出寄存器的地址，如果有的话
    .rs2(rs2),//读出寄存器的地址，如果有的话
    .funct3(funct3),
    .funct7(funct7),
    .next_PC(next_PC),
    .now_PC(PC),//输出即当前指令地址 
    .PcControl(PcControl)
    );

  IF_ID Reg_IF_ID(
  .CLK(clk),
  //IF模块数据输入
  .instruct(instruct),//对应输出的指令
  .opcode(opcode),//输入控制模块产生控制信号
  .rd(rd),//写入寄存器堆的地址，如果有的话
  .rs1(rs1),//读出寄存器的地址，如果有的话
  .rs2(rs2),//读出寄存器的地址，如果有的话
  .funct3(funct3),
  .funct7(funct7),
  .next_PC(next_PC),
  .now_PC(PC),//输出即当前指令地址 

  //输出到ID模块
  .IF_Data(IF_Data)//指令类型
    );

    ID_Unit ID(
    .opcode(IF_Data[38:32]),//指令类型
    .funct3(IF_Data[56:54]),//指令功能
    .funct7(IF_Data[63:57]),
    .inst(IF_Data[31:0]),//输入指令
    .clk(clk),                       
    //.reg_write_sig,             
    .reg_r1_addr(IF_Data[48:44]),          
    .reg_r2_addr(IF_Data[53:49]),         
    .reg_w1_addr(IF_Data[43:39]),         
    .write_data(WB_OUT),    
    
    .reg_1_data(rd1),         
    .reg_2_data(rd2),
    .Reg_WB(Reg_WB),         
    .imm(imm),//输出对应的立即数
    //控制信号
    .Reg_Src(Reg_Src),//写回寄存器数据来源
    .Sign(Sign),//输入为有符号数还是无符号数；=>ALU、MUX_WB、CMP + 数据存储器数据载入拓展方式
    .ALUop(ALuop),//ALU进行操作
    .ALU_Src1(ALU_Src1),//ALU数据1来源
    .ALU_Src2(ALU_Src2),//ALU数据2来源
    .Reg_W(Reg_W),//寄存器写使能
    //wire Contol_PC,//PC值跳转方式
    //wire CmpSrc1,//比较器来源1
    .CmpSrc2(CmpSrc2),//比较器来源2
    .Data_W(Data_W),//存储器写使能
    .Data_Byte(Data_Byte),//存储器操作位数
    .branch(branch), //判断是哪一种跳转指令
    .branch_W(branch_W),//是否需要分支判断
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

    ID_EXE Reg_ID_EXE(
    .CLK(clk),
    .reg_1_data(rd1),         
    .reg_2_data(rd2),         
    .imm(imm),//输出对应的立即数
    //控制信号
    .Reg_Src(Reg_Src),//写回寄存器数据来源
    .Sign(Sign),//输入为有符号数还是无符号数；=>ALU、MUX_WB、CMP + 数据存储器数据载入拓展方式
    .ALUop(ALuop),//ALU进行操作
    .ALU_Src1(ALU_Src1),//ALU数据1来源
    .ALU_Src2(ALU_Src2),//ALU数据2来源
    //.Reg_W,//寄存器写使能
    //.Contol_PC,//PC值跳转方式
    //.CmpSrc1,//比较器来源1
    .CmpSrc2(CmpSrc2),//比较器来源2
    .Data_W(Data_W),//存储器写使能
    .Data_Byte(Data_Byte),//存储器操作位数
    .branch(branch), //判断是哪一种跳转指令
    .branch_W(branch_W),//是否需要分支判断
    .Reg_W(Reg_W),
    .ID_data(ID_data)
    );

    EXE_Unit EXE(
    .rd1(ID_data [31:0]),
    .rd2(ID_data [63:32]),
    .PC(IF_Data[127:96]),
    .imm(ID_data [95:64]),
    .ALUop(ID_data [102:100]),
    .Sign(ID_data [99]),
    .ALU_Src1(ID_data [103]),
    .ALU_Src2(ID_data [104]),
    .CmpSrc2(ID_data [105]),
    .CMPout(CMPout), 
    .Aluout(Aluout),
    .debug(EXEdebug)
    );

    EXE_MEM Reg_EXE_MEM(
       .CLK(clk),
       .CMPout(CMPout), 
       .Aluout(Aluout),
       .Reg_W(ID_data [113]),
       .EXE_Data(EXE_Data)
    );

    DateMEM MEM(
    .Data_W(ID_data [106]),//存储器写使能
    .Byte(ID_data [108:107]),//读写位数:00->1字节,01->2字节,10->3字节,11->4字节
    .CLK(clk),
    .DArr(EXE_Data[33:2]),//写入（读出）存储器的地址:alu
    .DWrite(rd2),//写入存储器的数据:rd2
    .DataOut(DataOut)//从存储器中读出的数据:WB
    );

    MEM_WB Reg_MEM_WB(
      .CLK(clk),
      .DataOut(DataOut),
      .Reg_W(EXE_Data[34]),
      .MEM_data(MEM_data)
        );
      
    WB_MUX WB(
    .CLK(clk),
    .imm(ID_data [95:64]),
    .alu(EXE_Data[33:2]),
    .nextPC(IF_Data[95:64]),
    .cmp(CMPout),
    .mem(MEM_data[31:0]),
    .Reg_Src(ID_data [98:96]),
    .Reg_W(MEM_data[32]),
    .Reg_WB(Reg_WB),
    .WB_OUT(WB_OUT),
    .WB_OUT_W(WB_OUT_W),
    .state(state)
    );
endmodule
