//指令集类型
`define Type_I_imm  7'b0010011//I型立即数运算
`define Type_I_load  7'b0000011//I型载入数据存储器
`define Type_U_lui  7'b0110111//U型高位立即数载入
`define Type_U_auipc 7'b0010111//U型高位立即数加PC
`define Type_J_jal   7'b1101111//J型直接跳转
`define Type_J_jalr  7'b1100111//J型间接跳转
`define Type_B       7'b1100011//B型指令
`define Type_S       7'b0100011//S型指令
`define Type_R       7'b0110011//R型指令
//=>内部环境同步指令即断点检测指令未添加，共37条

//I型立即数类型
`define I_imm_addi 3'b000
`define I_imm_slti 3'b010
`define I_imm_sltiu 3'b011
`define I_imm_xori 3'b100
`define I_imm_ori 3'b110
`define I_imm_ani 3'b111

`define I_imm_srli 10'b0000000101
`define I_imm_slli 10'b0000000001
`define I_imm_srai 10'b0100000101

//I型载入数据型类型
`define I_load_lb 3'b000
`define I_load_lh 3'b001
`define I_load_lw 3'b010
`define I_load_lbu 3'b100
`define I_load_lhu 3'b101

//B型指令
`define B_beq 3'b000
`define B_bne 3'b001
`define B_blt 3'b100
`define B_bltu 3'b110
`define B_bge 3'b101
`define B_bgeu 3'b111

//S型指令
`define S_sb 3'b000
`define S_sh 3'b001
`define S_sw 3'b010

//R型指令
`define R_add  10'b0000000000
`define R_sub  10'b0100000000
`define R_sll  10'b0000000001
`define R_slt  10'b0000000010
`define R_sltu 10'b0000000011
`define R_xor  10'b0000000100
`define R_srl  10'b0000000101
`define R_sra  10'b0100000101
`define R_or   10'b0000000110
`define R_and  10'b0000000111

//ALU计算类型：
// 符号
`define UNSIGNED    1'b0 //无符号
`define SIGNED      1'b1//有符号

`define ADD     4'b000//加
`define SUB     4'b010//减
`define AND     4'b110//与
`define OR      4'b100//或
`define XOR     4'b101//异或
`define SLL     4'b001//逻辑左移
`define SRL     4'b011//逻辑右移
`define SRA     4'b111//算数右移

`define CMP_EQ 2'b00 //等于
`define CMP_LE 2'b01 //小于
`define CMP_GE 2'b10 //大于

//branch控制跳转的方式 => 判断是何种跳转方式，进而判断是否需要改变PC值
`define branch_jal  3'b000
`define branch_jalr 3'b001
`define branch_beq 3'b010
`define branch_bne 3'b011
`define branch_blt 3'b100
`define branch_bge 3'b101
`define branch_bltu 3'b110
`define branch_bgeu 3'b111

//Reg_Src:写回到寄存器的值
`define Reg_Src_alu  3'b000
`define Reg_Src_cmp  3'b001
`define Reg_Src_imm  3'b010
`define Reg_Src_mem  3'b011
`define Reg_Src_nextPC 3'b100