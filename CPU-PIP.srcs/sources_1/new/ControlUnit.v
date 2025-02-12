`timescale 1ns / 1ps
`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/05/22 18:51:48
// Design Name:
// Module Name: ControlUnit
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


module ControlUnit(
    input wire clk,
    input wire [6:0] opcode,//指令类型
    input wire [3:0] funct3,//指令功能
    input wire [7:0] funct7,
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
    output wire branch_W//是否需要分支判断
  );
  
  //reg [2:0] State;//1:取指 2：译码 3：执行 4：写入 0：写回
  assign ALUop = (opcode[6:0]==`Type_I_imm && funct3[2:0]==`I_imm_xori||opcode[6:0]==`Type_R&&{funct7,funct3}==`R_xor) ? `XOR:
         (opcode[6:0]==`Type_I_imm && funct3[2:0]==`I_imm_ani||opcode[6:0]==`Type_R&&{funct7,funct3}==`R_and) ? `AND :
         (opcode[6:0]==`Type_I_imm && funct3[2:0]==`I_imm_ori||opcode[6:0]==`Type_R&&{funct7,funct3}==`R_or) ? `OR :
         (opcode[6:0]==`Type_I_imm && {funct7,funct3}==`I_imm_srli||opcode[6:0]==`Type_R&&{funct7,funct3}==`R_srl) ? `SRL:
         (opcode[6:0]==`Type_I_imm && {funct7,funct3}==`I_imm_slli||opcode[6:0]==`Type_R&&{funct7,funct3}==`R_sll) ? `SLL:
         (opcode[6:0]==`Type_I_imm && {funct7,funct3}==`I_imm_srai||opcode[6:0]==`Type_R&&{funct7,funct3}==`R_sra) ? `SRA:
         (opcode[6:0]==`Type_R&&{funct7,funct3}==`R_sub)?`SUB:`ADD;

  assign ALU_Src1 = (opcode[6:0]==`Type_B || opcode[6:0]==`Type_U_auipc || opcode[6:0] == `Type_J_jal) ? 1'b1 : 1'b0;//1:输入为PC;2:输入为rd1
  assign ALU_Src2 = (opcode[6:0]==`Type_R) ? 1'b1 : 1'b0;//1:输入为rd2;0:输入为imm
  assign Reg_W   = (opcode[6:0]==`Type_B || opcode[6:0]==`Type_S) ? 1'b0 : 1'b1;//B型指令和S型指令为0，其余都有写入寄存器的操作
  //assign Contol_PC = (opcode[6:0]==`Type_B ||opcode[6:0] == `Type_J_jal||opcode[6:0] == `Type_J_jalr) ? 1'b1:1'b0;//除B型指令和J型指令，其余指令均为直接跳转
  assign CmpSrc2 = (opcode[6:0]==`Type_I_imm && funct3[2:0]==`I_imm_slti || opcode[6:0]==`Type_I_imm && funct3[2:0]==`I_imm_sltiu) ? 1'b1:1'b0;//比较器2输入，1：imm，0：rd2
  assign Data_W =(opcode[6:0]==`Type_S)?1'b1:1'b0;//只有S型指令能写入存储器    
  assign Sign =((opcode[6:0]==`Type_B&&(funct3[2:0]==`B_bltu||funct3[2:0]==`B_bgeu))||(opcode[6:0]==`Type_I_load&&(funct3[2:0]==`I_load_lbu||funct3[2:0]==`I_load_lhu))||(opcode[6:0]==`Type_I_imm && funct3[2:0]==`I_imm_sltiu)||(opcode[6:0]==`Type_R && funct3[2:0]==`R_sltu))?1'b0:1'b1;
  assign Reg_Src = (opcode[6:0]==`Type_U_lui) ? `Reg_Src_imm
         :  ((opcode[6:0]==`Type_U_auipc)||(opcode[6:0]==`Type_I_imm&&(funct3[2:0]!=`I_imm_slti&&funct3[2:0]!=`I_imm_sltiu))||(opcode[6:0]==`Type_R&&(funct3[2:0]!=`R_slt&&funct3[2:0]!=`R_sltu)))?`Reg_Src_alu
         :  (opcode[6:0] == `Type_J_jal||opcode[6:0] == `Type_J_jalr) ?`Reg_Src_nextPC
         :  (opcode[6:0] == `Type_I_load) ? `Reg_Src_mem : `Reg_Src_cmp;
  //写回寄存器：lui：mim；auipc+I_imm(除去两个比较)+R(除去两个比较)：alu；jal+jalr：nextPC；I_load：mem
  assign branch = (opcode[6:0] == `Type_J_jal) ? `branch_jal
         :(opcode[6:0] == `Type_J_jalr) ? `branch_jalr
         :(opcode[6:0] == `Type_B && funct3[2:0] == `B_beq) ? `branch_beq
         :(opcode[6:0] == `Type_B && funct3[2:0] == `B_bne) ? `branch_bne
         :(opcode[6:0] == `Type_B && funct3[2:0] == `B_blt) ? `branch_blt
         :(opcode[6:0] == `Type_B && funct3[2:0] == `B_bge) ? `branch_bge
         :(opcode[6:0] == `Type_B && funct3[2:0] == `B_bltu) ? `branch_bltu
         :(opcode[6:0] == `Type_B && funct3[2:0] == `B_bgeu) ? `branch_bgeu:3'b0;

  assign branch_W =((opcode[6:0] == `Type_J_jal)||(opcode[6:0] == `Type_J_jalr)||(opcode[6:0] == `Type_B))?1'b1:1'b0;
  assign Data_Byte = ((opcode[6:0]==`Type_I_load&&funct3[2:0]==`I_load_lb)||(opcode[6:0]==`Type_I_load&&funct3[2:0]==`I_load_lbu)||(opcode[6:0]==`Type_S&&funct3[2:0]==`S_sb)) ? 2'b00
:((opcode[6:0]==`Type_I_load&&funct3[2:0]==`I_load_lh)||(opcode[6:0]==`Type_I_load&&funct3[2:0]==`I_load_lhu)||(opcode[6:0]==`Type_S&&funct3[2:0]==`S_sh)) ?2'b01:2'b11;

endmodule
