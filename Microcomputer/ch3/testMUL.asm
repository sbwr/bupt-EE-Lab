; 探索乘除法的用法
.model small
.data                   ;定义数据段
array db 100 dup (0)
.const                  ;定义常数段（可选）
.code                   ;定义代码段
start:
    mov ax, @data
    mov ds, AX

    ; test mul,imul
    mov ax, 0aaaah
    mov bx, 2
    ; mul: ax * src, 低八位存入ax(5554h)，高八位存入dx(0001h)，cf=of=1:高八位不为零，
    mul bx
    ; imul: 有符号数；dosbox编译执行时不改变flag？
    imul bx

    ; test DIV
    mov bx, 4
    div bx
    idiv bx
    test ax, bx

    MOV	AH,4CH
	INT 21H
end start