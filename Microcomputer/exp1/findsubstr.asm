; 推荐使用vscode查看


; ==============定义字符串和子串变量===============
mystr       db 'abcdefgabcdefg',0
mysubstr    db 'ab',0
found       db 0
pos         dw -1
strmaxlen   dw 200h                             ; 字符串长度上限
submaxlen   dw 80h                              ; 子串长度上限
.const
.code
start:
main proc far
    mov ax, @data
    mov ds, ax
    lea si, mystr
    lea di, mysubstr
    dec strmaxlen                               ; 与si计数统一

    strend: ; =========判断是否到mystr尾部========
        cmp si, strmaxlen                       
        jz  false                                ; 若si > 字符串长度上限
        mov al, [si]
        cmp al, 0
        jz  false
        jmp compare

    compare: ; =========比较si, di当前位==========
        mov al, [si]
        cmp al, [di]
        jz  substrhead                          ; 该位相等，判断其是否是子串首位
        jmp restart                             ; 该位不等，回到子串首位

    substrhead: ; =====判断di是否在substr首部=====
        cmp di, offset mysubstr
        jz  storepos                            ; 若相同位为substr首位，记录str位置
        jmp substrend                           ; 非子串首位，

    substrend: ; ======判断di是否在substr尾部=====
        inc di                                  ; 判断di下一位是否是结束标志00h
        mov al, [di]
        cmp al, 0
        jz  true                                ; substr结束，已找到完整子串
        inc si                                  ; substr未结束，继续判断str下一位
        cmp di, submaxlen                       ; 判断是否到长度上限
        jz  true                                ; 已到达上限，强制结束比较
        jmp strend

    restart: ; =====重新从substr第一位开始比较=====
        lea di, mysubstr                        ; 回到子串第一位重新开始寻找
        inc si                                  ; 继续判断str下一位
        jmp strend        
    
    storepos: ; =保存si到pos，记录str中子串开始位置=
        mov pos, si
        jmp substrend

    true: ; ============已找到子串===============
        mov found, 0ffh
        mov dx, found
        mov ah, 9h
        int 21h
        jmp exit

    false: ; =========遍历完str且未找到===========
        mov pos, -1                             ; 复位pos
        jmp exit

    exit: ; ==============退出程序===============
        mov ah, 4ch
        int 21h

main endp    
end start