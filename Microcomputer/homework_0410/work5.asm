; 题目见work5.md
.model small
.data                   ;定义数据段    DATA SEGMENT 
.const ;定义常数段（可选）
.data ;定义数据段  
B1 db 20 dup (0)
W1 dw 10 dup (0)
.code                   ;定义代码段
start:
    mov ax, @data
    mov ds, ax              ;初始化ds

    ;-------------------my program-----------------
        ; mov cl, 1
        ; shl ax, cl

        ; 初始化四个段寄存器
        mov ax, 02aaah
        mov bx, 0aaaah
        mov cx, 0aaaah
        mov dx, 0aaa1h

        MOV CL, 4
        SHL DX, CL ; dx逻辑左移4位，变为aa10
        MOV BL, AH ; bl = 2a
        SHL AX, CL ;
        SHR BL, CL ; bl逻辑右移4位，变为02
        OR  DL, BL ; dl = dl or bl = 10 or 02 = 12
        ; 结果来源于dl低四位和ah高四位
    ;------------------end of program--------------

    int 21h                 ;返回DOS
end start