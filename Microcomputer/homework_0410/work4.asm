stack segment
    db 100 dup(0) ;定义堆栈大小 db:define byte每个操作数大小为一字节
stack ends
data segment
    ; VAR DW 'AB', 256, -1, 5 DUP (?, 1, 2) 
    var dw 0ffh, 0eeh
data ends
code segment
main proc far
assume cs:code,ds:data;,ss:stack ;定义段名称给段寄存器
mov ax,data
mov ds,ax

mov ax, offset VAR
mov ax, [offset VAR+4]
mov bx, offset var+4
mov al, [offset var+4]

int 21h
main endp
code ends
end main