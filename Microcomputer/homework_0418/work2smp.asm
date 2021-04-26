;消空
code  segment
      assume cs:code
      org 100h
start:
      jmp bbb
str1  db 254 dup(' ')
str2  db 254 dup(' ')
num   db ?
msg1  db 10,13,'please input string:','$'
lfcr  db 10,13,'$'
 
bbb:
      push cs
      pop ds
      lea dx,msg1
      mov ah,9
      int 21h
 
      MOV cx,0
      lea di,str1
again1:
      mov ah,1
      int 21h
      cmp al,13
      je line1
      mov byte ptr[di],al
      inc cx
      inc di
      jmp again1
line1:
;      mov byte ptr[num],cl
      mov byte ptr[di+1],'$'
       
      lea dx,lfcr
      mov ah,9
      int 21h
      lea dx,str1
      mov ah,9
      int 21h
       
      lea si,str1
      lea di,str2
again2:
      mov al,byte ptr[si]
      cmp al,' '
      je line2
      mov byte ptr[di],al
      inc di
line2:
      inc si
      loop again2
      mov byte ptr[di+1],'$'
 
      lea dx,lfcr
      mov ah,9
      int 21h
      lea dx,str2
      mov ah,9
      int 21h
 
      mov ah,4ch
      int 21h
code  ends
      end start