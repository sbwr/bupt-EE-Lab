.model small
.data
Hello dd 0AAAAAAAAh ; 用于测试第13行lea功能
FIRST dd 0f365002h
SECOND dd 0E024005h
THIRD dd 0D398008h
.stack 100h
.code
start:
mov ax, @data
mov ds, ax

; 将加数的地址赋值给寄存器，该值为偏移量（相对段址ds）
LEA BX,FIRST
LEA SI,SECOND
LEA DI,THIRD
; 加低16位
MOV AX,[BX]
ADD AX,[SI] ; add ax, [bx]错误，为什么？
MOV [DI],AX ; 结果存入内存
; 加高16位
MOV AX,[BX+2]
ADC AX,[SI+2]
MOV[DI+2], AX ; 结果存入内存

int 21h
end start