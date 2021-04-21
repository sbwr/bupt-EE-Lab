;简化段定义格式
.model small
.stack 100h ;定义堆栈段
.const ;定义常数段（可选）
.data ;定义数据段
msg db 'Hello! –using new directives', 0dh,0ah,'$'
.code ;定义代码段
start:mov ax, @data
mov ds, ax ;初始化ds
mov dx, offset msg ;操作数为msg的偏移属性
mov ah, 09h
int 21h
mov ax,4c00h
int 21h ;返回DOS
end start