; 探索sub,sbb,cmp等减法的用法
; 观察flag
.model small
.data                   ;定义数据段
array db 100 dup (0)
.const                  ;定义常数段（可选）
.code                   ;定义代码段
start:
    mov ax, @data
    mov ds, ax

    ; test cmp: dst - src
    ; unsigned
    mov ax, 0aaaah
    mov bx, 0
    cmp ax, bx  ; dst > src 时cf=0
    cmp bx, ax  ; dst < src 时cf=1
    cmp bx, 0   ; dst, src 操作数相等时cf=0, zf=1

    ; signed
    cmp bx, -1
    mov ax, -0aaaah
    cmp ax, 0


    ; exit
    MOV	AH,4CH
	INT 21H
end start