`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 18:25:35
// Design Name: 
// Module Name: MEM_bc
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


module MEM_bc(

    );

    parameter period = 10;
    parameter hperiod =5;
    parameter times =10;
    reg [31:0] i;

    reg Data_W;//存储器写使能
    reg [1:0] Byte;//读写位数:00->1字节,01->2字节,10->3字节,11->4字节
    reg CLK;
    reg [31:0] DArr;//写入（读出）存储器的地址
    reg [31:0] DWrite;//写入存储器的数据
    wire [31:0] DataOut;//从存储器中读出的数据

    DateMEM MEM_UNIT(
    .Data_W(Data_W),//存储器写使能
    .Byte(Byte),//读写位数:00->1字节,01->2字节,10->3字节,11->4字节
    .CLK(CLK),
    .DArr(DArr),//写入（读出）存储器的地址
    .DWrite(DWrite),//写入存储器的数据
    .DataOut(DataOut)//从存储器中读出的数据
    );

  initial
  begin
    CLK = 0;
    #period
    Data_W = 1;
    Byte = 2'b11;
    DArr = 32'hffffffe0;
    DWrite = 32'h3;
    
    #period
    #period
    Data_W = 0;
    Byte = 2'b11;
    DArr = 32'hffffffe0;
    #period
    Data_W = 0;
    Byte = 2'b11;
    DArr = 32'hffffffe0;
    #period
    Data_W = 0;
    Byte = 2'b11;
    DArr = 32'hffffffe0;
    #period
    Data_W = 0;
    Byte = 2'b11;
    DArr = 32'hffffffe0;
    
    
    #period
    Data_W = 0;
    Byte = 2'b11;
    DArr = 32'hffffffe4;
    
   end
   always #hperiod CLK = !CLK;
endmodule
