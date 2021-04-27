; 推荐使用vscode查看
.model small
.stack 100h
.data
; 定义字符串和子串变量
mystr       db 'abcdefgabcdefg',0
mysubstr    db 'gab',0
found       db 0
pos         dw -1
.const
.code
start:
main proc far
    mov ax, @data
    mov ds, ax
    lea si, mystr
    lea di, mysubstr

    strend: ; =========判断是否到mystr尾部========
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
        jmp exit

    false: ; =========遍历完str且未找到===========
        mov pos, -1                             ; 复位pos
        jmp exit

    exit: ; ==============退出程序===============
        MOV	AH,4CH
        INT 21H

main endp    
end start