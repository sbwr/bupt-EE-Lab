data segment
	pos dw 0
	found db 0
	str db "cde",00h		;di
	subtr db "abcccccdefg",00h	;si
data ends

code segment
	assume cs:code,ds:data	;10
main:
	mov		ax,data
	mov		ds,ax
	lea    di,str
	lea    si,subtr		
	call   pro1

pro1:
	cmp byte ptr[di], 00h		;判断str是否是最后一位
	jnz pro2			;不是，则继续判断
	mov ax,di			;若是，则计算偏移地址
	mov bx,si
	sub bx,ax			;20
	sub ax,2
	sub bx,ax
	mov pos,bx		;给pos赋值
	mov found,-1			;将found置ffh
	jmp exit			;退出

pro2:
	cmp byte ptr[si],00h		;判断subtr是否是最后一位 30
	jnz pro3			
	jmp exit			;若是，则结束程序

pro3:
	mov al,[si]
	cmp [di],al		;判断是否相等
	jnz pro5			
	jmp pro4		

pro4:
	inc si			;同时比较下一位
	inc di
	jmp pro1

pro5:
	inc si			;subtr向后，寻找和str相同的
	mov di,0
	jmp pro2

exit:
	mov dx,pos
	mov ah,09h
	int 21h

	mov dl,found
	mov ah,02h
	int 21h

	mov ah,4ch
	int 21h

code ends
end main