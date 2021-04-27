; 使用跳转表实现多分支程序
.model small
.stack 100h
.data
item db 2
; 记录分支程序ip
table dw routine0
      dw routine1
      dw routine2
.const
.code
start:
main proc far
    mov ax, @data
    mov ds, ax

    push ds
    xor ax,ax
    push ax
    mov ax, @data
    mov ds,ax
    mov bx,offset table
    mov al,item
    shl al,1            ; 逻辑左移1位，相当于x2
    xor ah,ah           ; ah=0
    add bx,ax
    jmp word ptr[bx]

    routine0:
    ; 分支程序，显示'0'
    ; int21h 02功能就是显示，要显示的字符在dl中
    mov dl,'0'
    mov ah,02
    int 21h
    ret
    routine1:
    mov dl,'1'
    mov ah,02
    int 21h
    ret
    routine2:
    mov dl,'2'
    mov ah,02
    int 21h
    ret

    exit: ; ============退出程序============
        MOV	AH,4CH
        INT 21H

main endp    
end start