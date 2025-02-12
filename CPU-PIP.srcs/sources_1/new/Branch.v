`timescale 1ns / 1ps
`include "define.vh"
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


module Branch(
    input wire [2:0]branch,
    input wire [1:0]cmp,
    input wire branch_W,
    output wire PC_control
    );

    assign PC_control =  (branch_W==1&&branch == `branch_jalr || branch_W==1&&branch == `branch_jal) ? 1'b1://J型指令直接跳转无需判断
                         (branch_W==1&&branch == `branch_beq && cmp == `CMP_EQ) ?1'b1://相等则跳转
                         (branch_W==1&&branch == `branch_bne && cmp != `CMP_EQ) ?1'b1://不相等则跳转
                         (branch_W==1&&branch == `branch_blt && cmp == `CMP_LE) ?1'b1://小于则跳转
                         (branch_W==1&&branch == `branch_bge && cmp != `CMP_LE) ?1'b1://不小于则跳转
                         (branch_W==1&&branch == `branch_bltu && cmp == `CMP_LE)?1'b1://小于则跳转（无符号）
                         (branch_W==1&&branch == `branch_bgeu && cmp != `CMP_LE)?1'b1:1'b0;//不小于则跳转（无符号）
endmodule