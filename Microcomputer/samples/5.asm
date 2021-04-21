data segment
	pos db 00h
	found db 00h
	str db "cde",00h		//di
	subtr db "abcdefg",00h	//si
data ends
code segment 'code'
main proc near
	assume cs:code,ds:data
	lea    di,str
	lea    si,subtr		
	call   pro1
pro1:
	cmp bytr ptr[di], 00h		//判断str是否是最后一位
	jnz pro2			//不是，则继续判断
	mov ax,di			//若是，则计算偏移地址
	mov bx,si
	sub bx,ax
	sub ax,2
	sub bx,ax
	mov si,0
	mov [si],bx		//给pos赋值
	mov si,1
	mov [si],ffh		//将found置ffh
	jmp exit			//退出

pro2:
	cmp bytr ptr[si], 00h		//判断subtr是否是最后一位
	jnz pro3			
	jmp exit			//若是，则结束程序

pro3:
	mov ax,bytr ptr[si]
	cmp bytr ptr[di],ax		//判断是否相等
	jnz pro5			
	jmp pro4		

pro4:
	inc si			//同时比较下一位
	inc di
	jmp pro1

pro5:
	inc si			//subtr向后，寻找和str相同的
	mov ax,0
	jmp pro2

exit:
	mov si,0
	mov dl, bytr ptr[si]
	mov ah,2
	int 21h
	inc si
	mov dl, bytr ptr[si]
	mov ah,2
	int 21h
	mov ah,4ch
	int 21h

main endp
code ends
end main
	


	