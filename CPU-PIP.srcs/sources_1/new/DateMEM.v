`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 16:49:41
// Design Name: 
// Module Name: DateMEM
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


module DateMEM(
    input wire Data_W,//存储器写使能
    input wire [1:0] Byte,//读写位数:00->1字节,01->2字节,10->3字节,11->4字节
    input wire CLK,
    input wire [31:0] DArr,//写入（读出）存储器的地址:alu
    input wire [31:0] DWrite,//写入存储器的数据:rd2
    output wire [31:0] DataOut//从存储器中读出的数据:WB
    );

    wire [31:0] DBWrite;//写入IP核的数据
    wire [31:0] DBout;//从IP核中读取的数据

    //由字节数分割数据
    assign DBWrite = (Byte == 2'b00) ? {24'b0,DWrite[7:0]}:
                     (Byte == 2'b01) ? {16'b0,DWrite[15:0]}:
                     (Byte == 2'b10) ? {8'b0,DWrite[23:0]}:
                     (Byte == 2'b11) ? DWrite[31:0]:0;
    
    assign DataOut = (Byte == 2'b00) ? {24'b0,DBout[7:0]}:
                     (Byte == 2'b01) ? {16'b0,DBout[15:0]}:
                     (Byte == 2'b10) ? {8'b0,DBout[23:0]}:
                     (Byte == 2'b11) ? DBout[31:0]:0;
     
     dist_mem_gen_1 RAM(
     .a(DArr[17:2]),.d(DBWrite),.clk(CLK),.we(Data_W),.spo(DBout));//数据宽度为32，四个字节，PC右移两位即除四
     
endmodule
