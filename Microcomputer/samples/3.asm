DATA SEGMENT
	STR		db	'hahahahaaastop',0
	SUBSTR1	db	'abs',0			;substr�Ǳ����ؼ��� 
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
	PUSH	SI			;Ϊ���������һ�β���ʱ������ 
COMPARE:
	MOV		AL,[SI]		;cmpֻ�� mem,reg ���� reg,mem ���� mem,mem 
	CMP 	AL,[DI]	
	JE		EQUAL
	JMP		UEQUAL
EQUAL:
	INC		SI			;��λ��ȾͱȽ���һλ�� 
	INC		DI
	MOV		AL,[DI]		;��һλ�����substr��һλΪ0��֤��substr��str����  
	CMP		AL,0		
	JE		FEQUAL
	JMP		COMPARE
UEQUAL:
	INC		CX
	MOV		AL,[SI]		;��һλ������strΪ0��֤��substr����str����
	CMP		AL,0
	JE		EXIT
	POP		SI			;�����si���ø㰡��Ҫ�ظ�cx�μ�һ 
	INC		SI	
	PUSH	SI			;���si���ø�����⣬ÿ�θ����ջ����ջ���Լ� 
	LEA 	DI,SUBSTR1	;substr�ع��һλ 
	JMP		COMPARE
FEQUAL:
	MOV		BYTE PTR FOUND,-1 
	MOV		POS,CX
EXIT:
	MOV		AX,POS		;pos��ax 
    CALL	DSPAXS    
    
	MOV		AL,FOUND
	CBW					;ax���ffal 
	CALL	DSPAXS
	
	MOV		AH,4CH		;�ܱ�׼�ķ��� 
	INT		21H
;==================================================
 ; ��Ҫ��ʾ���з��������� ax ��
 ;dspaxsȥ��Ϊ���� 
      DSPAXS  PROC      NEAR		;���ڵ��� 
      
              PUSH      AX			;����ջ 
              TEST      AX,8000H	;���λΪ1 �Ͳ���ת 
              JNS       @DSPAXS1	;sf=0��ת 
              
              PUSH      AX			;����ջ 
              PUSH      DX			;dx��ջ 
              MOV       AH,2		;���dl 
              MOV       DL,'-'
              INT       21H
              POP       DX
              POP       AX
              
              NEG       AX			;�� 
   @DSPAXS1:
              CALL      DSPAX
              POP       AX			;��ջ���һ�� 
              RET
      DSPAXS  ENDP
 
DSPAX  PROC    NEAR		
              PUSH      AX			;ȫ��ջ 
              PUSH      BX
              PUSH      CX
              PUSH      DX
              PUSHF					;��־����������ջ 
              XOR       CX,CX		;��0 
              MOV       BX,10
    @DSPAX1:
              XOR       DX,DX		;dx��0 
              DIV       BX			;al=ax/bx,ah=ax%bx 
              INC       CX			;cx�Լ� 
              OR        DX,30H		; dx���30h 
              PUSH      DX			;��ջ 
              CMP       AX,0		;��0��ѭ�� 
              JNE       @DSPAX1
              
              MOV       AH,2		;
   @DISPAX2:
              POP       DX			;dx��ջ����ʾ �ָ����� 
              INT       21H
              LOOP      @DISPAX2	;ִ�в�cx�Լ�ֱ��cx=0 
              
              MOV       DL,32		;����ո� 
              INT       21H
              
              POPF					;ȫ���ջ 
              POP       DX
              POP       CX
              POP       BX
              POP       AX
              RET
       DSPAX  ENDP
;==============================================   
CODE ENDS
END START