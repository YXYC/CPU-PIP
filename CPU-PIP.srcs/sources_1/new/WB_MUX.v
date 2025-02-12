`timescale 1ns / 1ps
`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/23 18:43:28
// Design Name: 
// Module Name: MUX_ALU_SRC_2
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


module WB_MUX(
    input wire CLK, 
    input wire [31:0] imm,
    input wire [31:0] alu,
    input wire [31:0] nextPC,
    input wire [1:0] cmp,
    input wire [31:0] mem,
    input wire [2:0] Reg_Src,
    input wire Reg_W,
    output reg [31:0] WB_OUT,
    output reg Reg_WB,
    output wire [31:0] WB_OUT_W,
    output reg [3:0] state 
    );
    
    
   assign  WB_OUT_W = (Reg_Src == `Reg_Src_imm ) ? imm : 
    (Reg_Src == `Reg_Src_alu ) ? alu:
    (Reg_Src == `Reg_Src_nextPC ) ? nextPC:
    (Reg_Src == `Reg_Src_cmp && cmp == `CMP_LE ) ? 1: //小于将rd置1，否则置0
    (Reg_Src == `Reg_Src_cmp && cmp != `CMP_LE ) ? 0:(Reg_Src == `Reg_Src_mem )?mem:0;
    
    
    
    always @(negedge CLK) begin
    WB_OUT <= WB_OUT_W;
    
    Reg_WB <= 0;
    end
    
     always @(posedge CLK)//时钟上升沿或者复位信号更新指令
  begin
    state <= state+1;
    if(state == 4) Reg_WB <=Reg_W;
    if(state == 5) state <= 1;
  end
    
    
     initial
  begin
    Reg_WB = 0;
    WB_OUT = 0;
    state = 0;
  end
    
endmodule
