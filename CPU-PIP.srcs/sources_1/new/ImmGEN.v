`timescale 1ns / 1ps
`include "define.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/21 13:48:22
// Design Name: 
// Module Name: ImmGEN
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


module ImmGEN(
    input wire [31:0] inst,//输入指令
    output reg [31:0] imm//输出对应的立即数
  );
  
  wire [31:0] I_imm;
  wire [31:0] S_imm;
  wire [31:0] B_imm;
  wire [31:0] U_imm;
  wire [31:0] J_imm;


  assign I_imm = {{21{inst[31]}},inst[30:25],inst[24:21],inst[20]};
  assign S_imm = {{21{inst[31]}},inst[30:25],inst[11:8],inst[7]};
  assign B_imm = {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0};
  assign U_imm = {inst[31],inst[30:20],inst[19:12],12'b0};
  assign J_imm = {{12{inst[31]}},inst[19:12],inst[20],inst[30:25],inst[24:21],1'b0};

  always @(inst)
  begin
    case(inst[6:0]) 
      //U类型：
    `Type_U_lui :
      begin
        imm=U_imm;
      end

      `Type_U_auipc:
      begin
        imm=U_imm;
      end

      //jal:
      `Type_J_jal:
      begin
        imm=J_imm;
      end

      //jalr and I:
      `Type_J_jalr :
      begin
        imm = I_imm;
      end

      `Type_I_imm :
      begin
        imm = I_imm;
      end
      
      `Type_I_load:
      begin
        imm = I_imm;
      end

      //B:
      `Type_B:
      begin
        imm = B_imm;
      end

      //S:
      `Type_S:
      begin
        imm =S_imm;
      end
      
      default:
      begin
        imm[31: 0] <= 32'b0;//无对应立即数
      end
      endcase
    end
  endmodule

