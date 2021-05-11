data segment
 buf dw 3,4,8,7,2,0,9,1,6,5
 N=($-buf)/2 ; 计算数组大小，“$”是汇编语言中的一个预定义符号，等价于当前正汇编到的段的当前偏移值
data ends
code segment
 assume cs:code,ds:data
start:
 mov ax,data
 mov ds,ax
 mov bx,0
 mov dx,0
 mov cx,N
L1: ;------------ 外层循环，
; 先入栈寄存器，保护现场，以便内层循环使用寄存器
 push cx
 push bx
 mov si,bx 
L2: 
 mov ax,buf[si]
 cmp ax,buf[bx+2]
 jl NEXT           ;   小于则跳转，不执行交换指令
 ;  大于则交换数值
 xchg ax,buf[bx+2]
 mov buf[si],ax
NEXT:
 add bx,2
 loop L2
 pop bx
 pop cx
 add bx,2
 loop L1
 
;  显示排序后数组

 mov ax,4c00h
 int 21h
code ends
 end start