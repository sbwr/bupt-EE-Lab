;强制转换类型smp
;表达式赋值伪指令smp
.model small
.stack 100h             ;定义堆栈段
.const                  ;定义常数段（可选）
AConst EQU, 00h
.data                   ;定义数据段
var dw 1234h
.code                   ;定义代码段
start:
mov ax, @data
mov ds, ax              ;初始化ds

;-------------------my program-----------------
mov al, byte ptr var    ;强行转换为字节,(al)=34h
mov ah, byte ptr var    ;(ah)=34h
; mov eax, dword ptr var
; mov ax, AConst
;------------------end of program--------------

int 21h                 ;返回DOS
end start