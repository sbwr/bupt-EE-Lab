; 示例程序：helloworld
stack segment
    db 100 dup(0) ;定义堆栈大小 db:define byte每个操作数大小为一字节
stack ends
data segment
    msg  db "Hello!",0dh,0ah,'$'';定义消息 若干个byte组成
    const1 = 4c00h
data ends
code segment
main proc far
assume cs:code,ds:data,ss:stack ;定义段名称给段寄存器
mov ax,data
mov ds,ax
mov ah,09h
mov dx,offset msg
int 21h
mov ax,const1
int 21h
main endp
code ends
end main