; 把字符串String两端的空格删除（字符串以0结束）。（提示：空格可能是多个）
.model small
.stack 100h
.data                           ; 定义数据段
string db "  abc0 "             ; 数据段中存入字符串
strlen db 7                     ; 字符串长度
.const                          ; 定义常数段（可选）
.code                           ; 定义代码段
start:
main proc far
    mov ax, @data
    mov ds, ax
    mov es, ax
    lea si, string              ; 注意要初始化es，es:di才是有意义的
    lea di, string+7
    ; mov byte ptr [si+1],'$' ;字符串末尾加上结束符

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
        dec di                  ; 偏移量递减
        mov ah,[di]             ; 将偏移量为si的值赋给ah
        cmp ah, ' '             ; 
        jz  moverear            ; 找到空格则zf=1，在moverear中改变结尾位置
        jnz exit                ; 尾部空格全部找到，结束

    moverear: ; =======改变字符串末尾位置，' '->'0'=======
        ; mov byte ptr [di],'0'
        mov byte ptr [di],'$'
        jmp rear

    exit: ; ============显示字符串并退出程序============
        ; 显示字符串
        mov dx, bx
        mov ah, 9h              ; 九号中断，显示字符串
        int 21h

        mov	ah, 4ch
        int 21h
main endp    
end start
