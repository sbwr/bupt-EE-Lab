; 把字符串String两端的空格删除（字符串以0结束）。（提示：空格可能是多个）
.model small
.stack 100h
.data                           ;定义数据段
string db "  Aabcd1%  0"
.const                          ;定义常数段（可选）
.code                           ;定义代码段
start:
main proc far
    mov ax, @data
    mov ds, ax
    mov es, ax

    lea si,string               ; 注意要初始化es，es:di才是有意义的

    lp: 
        ; ========检验字符是否结束==========
        mov ah,[si]             ; 将偏移量为si的值赋给ah
        cmp ah, '0'             ; 比较该位字符和结束符号￥
        jz exit                 ; 相同则zf=1，退出程序

        ; ========寻找字符串头部的空格==========
        mov ah,[si]             ; 将偏移量为si的值赋给ah
        cmp ah, ' '             ; 
        jz  later               ; 相同则zf=1，

    later: ; =======改变字符串起始偏移地址，存在bx中=======
        inc si                  ; 偏移量递增
        mov bx,si               ; 存放字符串起始地址
        jmp lp

    next: ; ======递增si，处理字符串每一位======
        inc si                  ; 偏移量递增
        jmp lp
        mov byte ptr [si+1],'$' ;字符串末尾加上结束符

    exit: ; ============退出程序============
        MOV	AH,4CH
        INT 21H
main endp    
end start