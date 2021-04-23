; stack segment
;     db 100 dup(0) ;定义堆栈大小
; stack ends
; data segment
; data ends
code segment
    assume cs:code;,ds:data,ss:stack ;ds,ss在哪里被赋值有什么区别
    start:
        ; ss:sp 赋初值1000h:10h
        mov ax, 1000h
        mov ss, ax
        mov sp, 10h ; 设sp=10h栈空，即栈容量10h字节

        mov ax, 0ffffh
        mov ds:[0h], ax ; 不加基址ds会被编译器理解为直接寻址？
        mov ax, 0aaaah

        ; 入栈 & 出栈
        push ds:[0h] ; 从内存入栈 0ffffh 至 1000:8
        push ax ; 从段寄存器入栈 0aaaah 至 1000:6
        pop bx
        pop cx

        int 21h
    code ends
end start