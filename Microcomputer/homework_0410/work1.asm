
.model small
.stack 100h             ;定义堆栈段
.const                  ;定义常数段（可选）
.data  union            ;定义数据段    DATA SEGMENT   
B1 db 20 dup (0)
W1 dw 10 dup (0)
data ends
.code                   ;定义代码段
start:
mov ax, @data
mov ds, ax              ;初始化ds

;-------------------my program-----------------
; mov eax, dword ptr var
; mov ax, AConst
mov ax, b1
mov ax, word ptr w1
;------------------end of program--------------

int 21h                 ;返回DOS
end start