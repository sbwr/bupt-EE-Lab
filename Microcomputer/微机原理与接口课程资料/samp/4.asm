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
	cmp byte ptr[di], 00h		;�ж�str�Ƿ������һλ
	jnz pro2			;���ǣ�������ж�
	mov ax,di			;���ǣ������ƫ�Ƶ�ַ
	mov bx,si
	sub bx,ax			;20
	sub ax,2
	sub bx,ax
	mov pos,bx		;��pos��ֵ
	mov found,-1			;��found��ffh
	jmp exit			;�˳�

pro2:
	cmp byte ptr[si],00h		;�ж�subtr�Ƿ������һλ 30
	jnz pro3			
	jmp exit			;���ǣ����������

pro3:
	mov al,[si]
	cmp [di],al		;�ж��Ƿ����
	jnz pro5			
	jmp pro4		

pro4:
	inc si			;ͬʱ�Ƚ���һλ
	inc di
	jmp pro1

pro5:
	inc si			;subtr���Ѱ�Һ�str��ͬ��
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