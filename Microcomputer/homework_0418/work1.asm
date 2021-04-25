; 将string中的小写字母转换成大写字母。
; 已知字符串string的内容为英文小写字母、数字、符号（如*、#、！等）组成，
; 末尾是$符，
.model small
.stack 100h
.data                   ;定义数据段
string db "Aabcd1%$"
endchar db "$"
; strlen dw 4
.const                  ;定义常数段（可选）
.code                   ;定义代码段
start:
main proc far
    mov ax, @data
    mov ds, ax
    mov es, ax

    lea si,string       ; 注意要初始化es，es:di才是有意义的

    lp: 
        ; ========检验字符是否结束，跳出循环==========
        lea di, endchar
        cmpsb           ; 偏移量si改变了
        jz exit
        dec si          ; 改回si 考虑优化

        ; ======检验字符是否是小写字母======
        mov ah,[si]     ; 将偏移量为si的值赋给ah
        cmp ah,'a'      ; 小于a不处理     
        jb next         
        cmp ah,'z'      ; 大于z不处理
        ja next

        ; ============小写->大写============
        sub ah,20h      ; 利用ascii进行大小写转换
        mov [si],ah

    next:
        inc si          ; 偏移量递增
        loop lp
        mov byte ptr [si+1],'$' ;字符串末尾加上结束符

    exit:
        MOV	AH,4CH
        INT 21H
main endp    
end start