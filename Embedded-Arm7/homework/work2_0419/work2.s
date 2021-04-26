; r0-r3赋初值
; r1r0, r3r2分别连接为两个64位数
mov  r1, #0
mov  r0, #0
mov  r3, #0
mov  r2, #0xFFFFFFFF

LOOP:
    bl  add64       ; 完成一次加法
    sub r2, r2, #1  ; 第二个加数-1
    cmp r2, #0
    bne LOOP        ; 条件跳转, 看CPSR标志位

; 结束程序
nop
nop
nop
swi 0x123456        ; 使用软中断结束执行

; 64位加法 r1r0 + r3r2
; 结果记录在r1r2
add64:
    adds r0, r0, r2
    adc  r1, r1, r3
    mov  pc, lr     ; 子程序结束，回到主程序

.end