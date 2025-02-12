`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 21:34:12
// Design Name: 
// Module Name: RegFile
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


module RegFile(
        input wire clk,                       //clock input signals
        input wire reg_write_sig,             //indicate whether a write operation is required
        input wire[4:0] reg_r1_addr,          //address of the first register to be read
        input wire[4:0] reg_r2_addr,          //address of the second register to be read
        input wire[4:0] reg_w1_addr,         //address of the first register to be write
        input wire[31:0] write_data,          //date to be written to the register
        output wire [31:0] reg_1_data,         //data that read from the first register
        output wire [31:0] reg_2_data,     //data that read from the second register
        output reg [31:0] debug1, 
        output reg [31:0] debug2, 
        output reg [31:0] debug3, 
        output reg [31:0] debug4, 
        output reg [31:0] debug5, 
        output reg [31:0] debug6, 
        output reg [31:0] debug7, 
        output reg [31:0] debug8, 
        output reg [31:0] debug9, 
        output reg [31:0] debug10, 
        output reg [31:0] debug11,
        output reg [31:0] debug12, 
        output reg [31:0] debug13, 
        output reg [31:0] debug14, 
        output reg [31:0] debug15, 
        output reg [31:0] debug16, 
        output reg [31:0] debug17, 
        output reg [31:0] debug18, 
        output reg [31:0] debug19, 
        output reg [31:0] debug20, 
        output reg [31:0] debug21, 
        output reg [31:0] debug22, 
        output reg [31:0] debug23, 
        output reg [31:0] debug24, 
        output reg [31:0] debug25, 
        output reg [31:0] debug26, 
        output reg [31:0] debug27, 
        output reg [31:0] debug28, 
        output reg [31:0] debug29, 
        output reg [31:0] debug30, 
        output reg [31:0] debug31, 
        output reg [31:0] debug32 
    );
    
    reg[31:0]  x[31:0];                       //registers x[0] to x[31]
    //reg[31:0] debug [31:0];
    assign reg_1_data = x[reg_r1_addr];        //get data from the registers
    assign reg_2_data = x[reg_r2_addr];
    
    
    
    always @ (negedge clk) begin
        if(reg_write_sig) begin              //write data from the registers
            x[reg_w1_addr] <= write_data;
        end
        //debug <= x[reg_w1_addr];
        x[0] = 32'h0; 
        debug1 <= x[0];                       //x[0] is always set to zero
        debug2 <= x[1];
        debug3 <= x[2];
        debug4 <= x[3];
        debug5 <= x[4];
        debug6 <= x[5];
        debug7 <= x[6];
        debug8 <= x[7];
        debug9 <= x[8];
        debug10 <= x[9];
        debug11 <= x[10];
        debug12 <= x[11];
        debug13 <= x[12];
        debug14 <= x[13];
        debug15 <= x[14];
        debug16 <= x[15];
        debug17 <= x[16];
        debug18 <= x[17];
        debug19 <= x[18];
        debug20 <= x[19];
        debug21 <= x[20];
        debug22 <= x[21];
        debug23 <= x[22];
        debug24 <= x[23];
        debug25 <= x[24];
        debug26 <= x[25];
        debug27 <= x[26];
        debug28 <= x[27];
        debug29 <= x[28];
        debug30 <= x[29];
        debug31 <= x[30];
        debug32 <= x[31];
    end
    
    //开始初始化所有寄存器为0
    initial begin 
        x[0] = 32'b0;
        x[1] = 32'h0;
        x[2] = 32'h0;
        x[3] = 32'h0;
        x[4] = 32'h0;
        x[5] = 32'h0;
        x[6] = 32'h0;
        x[7] = 32'h0;
        x[8] = 32'h0;
        x[9] = 32'h0;
        x[10] = 32'h0;
        x[11] = 32'h0;
        x[12] = 32'h0;
        x[13] = 32'h0;
        x[14] = 32'h0;
        x[15] = 32'h0;
        x[16] = 32'h0;
        x[17] = 32'h0;
        x[18] = 32'h0;
        x[19] = 32'h0;
        x[20] = 32'h0;
        x[21] = 32'h0;
        x[22] = 32'h0;
        x[23] = 32'h0;
        x[24] = 32'h0;
        x[25] = 32'h0;
        x[26] = 32'h0;
        x[27] = 32'h0;
        x[28] = 32'h0;
        x[29] = 32'h0;
        x[30] = 32'h0;
        x[31] = 32'h0;
    end
    
endmodule
