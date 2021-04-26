; 假设从变量buff开始存放了200个字，编写一个程序统计出其正数、0和负数的个数，
; 结果分别存入n1、n2和n3中。
.model small
.stack 100h
.data
buff dw 70 dup (-2), 64 dup(0), 66 dup(2)
n1 dw 0
n2 dw 0
n3 dw 0
.const
.code
start:
main proc far
    mov ax, @data
    mov ds, ax
    lea si, buff
    mov cx, 200         ; 因为先判断跳出循环，所以cx初始值应为buff长度+1
    
    lp: 
        dec cx
        jz exit
        mov ax, word ptr [si]
        inc si
        inc si
        cmp ax, 0       ; 当前字(有符号数)和0比较，计算[si]-0，改变SF ZF
        jz zero         ; ZF=1, 则为0
        js negtive      ; SF=1, 则为负数
        jns positive    ; ZF,SF=0 则为正数

    zero: ; n2++
        inc word ptr [n2]
        jmp lp

    negtive: ; n3++
        inc word ptr [n3]
        jmp lp

    positive: ; n1++
        inc word ptr [n1]
        jmp lp

    exit: ; ============退出程序============
        MOV	AH,4CH
        INT 21H

main endp    
end start