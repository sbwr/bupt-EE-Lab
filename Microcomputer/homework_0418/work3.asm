; 假设从变量buff开始存放了200个字，编写一个程序统计出其正数、0和负数的个数，并把它们分别存入n1、n2和n3中。
.model small
.stack 100h
.data                           ; 定义数据段
BUFF DW 102 DUP(1),54 DUP(0),44 DUP(-1) 
.const                          ; 定义常数段（可选）
.code                           ; 定义代码段
start:
main proc far
    mov ax, @data
    mov ds, ax

    head: ; =========寻找字符串头部的空格==========
        mov ah,[si]             ; 将偏移量为si的值赋给ah
        inc si                  ; 偏移量递增
        cmp ah, ' '             ; 
        jz  movehead            ; 找到空格则zf=1，在movehead中将字符串起始位置后移
        jnz rear                ; 头部空格全部找到，开始找尾部

    movehead: ; =======改变字符串起始偏移地址，存在bx中=======
        mov bx,si               ; 存放新的字符串起始地址
        jmp head

    rear: ; =========寻找字符串尾部的空格==========
        mov ah,[di]             ; 将偏移量为si的值赋给ah
        dec di                  ; 偏移量递增
        cmp ah, ' '             ; 
        jz  moverear            ; 找到空格则zf=1，在moverear中改变结尾位置
        jnz exit                ; 尾部空格全部找到，结束

    moverear: ; =======改变字符串末尾位置，' '->'0'=======
        mov byte ptr [di],'0'
        jmp rear

    exit: ; ============退出程序============
        mov si,bx               ; 将新的起始位置赋给si
        MOV	AH,4CH
        INT 21H
main endp    
end start