; 测试MOV等传送类指令
.386 ; 使用伪指令指明处理器类型为80386
.model small
.stack 100h
.data
.code
start:
mov ax, @data
mov ds, ax

mysegment:
mov ax, 0FFFFh
mov bl, 0aah

; =====80386的指令 16位机不支持=======
movsx ax, bl
movzx cx, bl

; =====push/pop======
push ax
pop bx
pushf   ; 标志寄存器进栈

; =====xchg=====
mov bx, 0aaaah
xchg ax, bx

; =====累加器传送指令=====
; 只限于使用ax, al
; in al, <端口地址>
mov dx, ax
in al, dx ; 端口地址必须放在dx寄存器中

; =====地址传送指令=====
lea ax, mysegment


int 21h
end start