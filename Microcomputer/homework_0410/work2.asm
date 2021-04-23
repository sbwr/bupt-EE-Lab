stack segment stack
    db 100 dup(0) ;定义堆栈大小 db:define byte每个操作数大小为一字节
stack ends
data union
B1 db 20 dup (0)
W1 dw 10 dup (0)
data ends
code segment
main proc far
assume cs:code,ds:data,ss:stack ;定义段名称给段寄存器
mov ax,data
mov ds,ax

mov ax, B1
mov ax, w1

int 21h
main endp
code ends
end main