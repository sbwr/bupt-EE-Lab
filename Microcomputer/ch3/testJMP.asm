; 第12行：测试jmp段内转移
.model small
.data                   ;定义数据段
array db 100 dup (0)
.const ;定义常数段（可选）
.code                   ;定义代码段
start:
    mov ax, @data
    mov ds, ax              ;初始化ds

    ;-------------------my program-----------------
        jmp lp
        mov cx, 100
        lea si, array
        lp: 
        ; inc word ptr [si]
        inc si
        inc si
        mov ax, cx
        loop lp
    ;------------------end of program--------------

    int 21h                 ;返回DOS
end start