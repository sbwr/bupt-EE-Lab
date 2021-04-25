; 子程序call, ret的用法
.model small
.stack 100h
.data                   ;定义数据段
array db 100 dup (0)
.const                  ;定义常数段（可选）
.code                   ;定义代码段
start:
main proc far
    mov ax, @data
    mov ds, ax
    mov ax, @stack
    mov ss, ax
    mov sp, 100h

    ; 
    mov ax, 0aaaah
    mov bx, 0

    call myadd

    ; exit
    MOV	AH,4CH
	INT 21H
main endp

    ; 段内子程序
myadd proc near
    add ax, bx  ;
    ret
myadd endp
    
end start