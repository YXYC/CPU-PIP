`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 22:40:11
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
  input  wire        CLK,
  input  wire [31:0] DataOut,
  input  wire Reg_W,
  output reg [32:0] MEM_data
    );
  
    always @(negedge CLK) begin
      MEM_data[31:0] <= DataOut;
      MEM_data[32]  <=Reg_W;
    end
     initial
  begin
     MEM_data = 33'b0;
  end
endmodule
