; 了解串处理操作
; 在string内搜索字母c
.model small
.stack 100h
.data                   ;定义数据段
string db "CABD"
strlen dw 4
.const                  ;定义常数段（可选）
.code                   ;定义代码段
start:
main proc far
    mov ax, @data
    mov ds, ax
    mov es, ax
    mov ax, @stack
    mov ss, ax
    mov sp, 100h

    lea di,string       ; 注意要初始化es，es:di才是有意义的
    mov al,'C'          ; C的ASCII码，mov al,‘C’
    mov cx,strlen       ; string长度
    cld                 ; DF=0，地址递增
    lp: scasb           ; 搜索，若找到相等内容，zf=1
        jz found        ; 发现C,为0（ZF=1），
        dec cx          ; 不是C
        jnz lp

        ; not found
        MOV	AH,4CH
        INT 21H
    found:
        ; found, exit
        MOV	AH,4CH
        INT 21H
main endp    
end start