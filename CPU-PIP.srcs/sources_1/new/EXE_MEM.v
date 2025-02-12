`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 22:40:11
// Design Name: 
// Module Name: EXE_MEM
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


module EXE_MEM(
  input   wire            CLK,
  input   wire [1:0]      CMPout, 
  input   wire [31: 0]    Aluout,
  input   wire Reg_W,
  output  reg  [34:0]     EXE_Data
    );

    always @(negedge CLK) begin
      EXE_Data[1:0] <= CMPout;
      EXE_Data[33:2] <= Aluout; 
      EXE_Data [34] <= Reg_W;
    end
    initial
  begin
    EXE_Data = 35'b0;
  end
     
endmodule