data segment
VAR DW 0aaaah
data ends
code segment
    ;assum ds:data 并不能将ds指向data，还需要语句块1.
    assume cs:code,ds:data
    start:
    ;===========语句块1===========
    ; 指定ds，无此语句无法正确使用var
    	MOV		AX,DATA
	    MOV		DS,AX
    ;===========语句块1===========

        ; 使用var
        mov ax, var

        int 21h
    code ends
end start