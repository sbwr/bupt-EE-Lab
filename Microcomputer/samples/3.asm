DATA SEGMENT
	STR		db	'hahahahaaastop',0
	SUBSTR1	db	'abs',0			;substr是保留关键字 
	FOUND	db	0
	POS		dw	-1
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
	MOV		AX,DATA
	MOV		DS,AX
	LEA		SI,STR
	LEA 	DI,SUBSTR1 
	MOV		CX,0
	PUSH	SI			;为了让下面第一次不等时候用上 
COMPARE:
	MOV		AL,[SI]		;cmp只能 mem,reg 或者 reg,mem 不能 mem,mem 
	CMP 	AL,[DI]	
	JE		EQUAL
	JMP		UEQUAL
EQUAL:
	INC		SI			;该位相等就比较下一位嘛 
	INC		DI
	MOV		AL,[DI]		;这一位相等且substr下一位为0就证明substr在str里面  
	CMP		AL,0		
	JE		FEQUAL
	JMP		COMPARE
UEQUAL:
	INC		CX
	MOV		AL,[SI]		;这一位不等且str为0就证明substr不在str里面
	CMP		AL,0
	JE		EXIT
	POP		SI			;这里的si不好搞啊，要重复cx次加一 
	INC		SI	
	PUSH	SI			;解决si不好搞的问题，每次改完进栈。出栈再自加 
	LEA 	DI,SUBSTR1	;substr回归第一位 
	JMP		COMPARE
FEQUAL:
	MOV		BYTE PTR FOUND,-1 
	MOV		POS,CX
EXIT:
	MOV		AX,POS		;pos给ax 
    CALL	DSPAXS    
    
	MOV		AL,FOUND
	CBW					;ax变成ffal 
	CALL	DSPAXS
	
	MOV		AH,4CH		;很标准的返回 
	INT		21H
;==================================================
 ; 将要显示的有符号数置于 ax 中
 ;dspaxs去负为负号 
      DSPAXS  PROC      NEAR		;段内调用 
      
              PUSH      AX			;先入栈 
              TEST      AX,8000H	;最高位为1 就不跳转 
              JNS       @DSPAXS1	;sf=0跳转 
              
              PUSH      AX			;再入栈 
              PUSH      DX			;dx入栈 
              MOV       AH,2		;输出dl 
              MOV       DL,'-'
              INT       21H
              POP       DX
              POP       AX
              
              NEG       AX			;求补 
   @DSPAXS1:
              CALL      DSPAX
              POP       AX			;出栈最后一次 
              RET
      DSPAXS  ENDP
 
DSPAX  PROC    NEAR		
              PUSH      AX			;全入栈 
              PUSH      BX
              PUSH      CX
              PUSH      DX
              PUSHF					;标志及储存器进栈 
              XOR       CX,CX		;归0 
              MOV       BX,10
    @DSPAX1:
              XOR       DX,DX		;dx归0 
              DIV       BX			;al=ax/bx,ah=ax%bx 
              INC       CX			;cx自加 
              OR        DX,30H		; dx变成30h 
              PUSH      DX			;入栈 
              CMP       AX,0		;得0自循环 
              JNE       @DSPAX1
              
              MOV       AH,2		;
   @DISPAX2:
              POP       DX			;dx出栈并显示 分隔符号 
              INT       21H
              LOOP      @DISPAX2	;执行并cx自减直到cx=0 
              
              MOV       DL,32		;输出空格 
              INT       21H
              
              POPF					;全体出栈 
              POP       DX
              POP       CX
              POP       BX
              POP       AX
              RET
       DSPAX  ENDP
;==============================================   
CODE ENDS
END START