`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 15:06:31
// Design Name: 
// Module Name: ALU_bc
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


module ALU_bc(

    );
  parameter period = 10;
  parameter hperiod =5;
  parameter times =10;
  reg clk;
  reg [31:0] i;
  reg [31: 0]    A;
  reg [31: 0]    B;
  reg [2: 0]     ALUop;
  reg            Unsigned;
  wire [31: 0]    out;
  ALU uut(
             A,
             B,
             ALUop,
             Unsigned,
             out
        );
  initial
  begin
       A = 0;
       B=32'hffffffe0;
       ALUop = 0;
       Unsigned =1;
  end
  always #hperiod clk = !clk;
endmodule