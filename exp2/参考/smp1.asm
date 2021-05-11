;https://www.cnblogs.com/lucio_yz/p/4418066.html
DATAS SEGMENT
COUNT DW 20
BEGINC DW 0
X DB 4,3,5,7,9,0,3,7,8,9,5,4,5,7,1,6,3,6,1,0
Y DB 5,9,7,3,1,6,3,5,4,0,0,1,3,7,2,5,4,5,3,1
Z DB 20 DUP(?)
ENT db ';',0ah,0dh,'$'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX

    ;X排序
    MOV SI,OFFSET X
    MOV DI,OFFSET X;数组起始地址
    MOV BX,OFFSET X
    ADD BX,COUNT
    DEC BX;数组结束地址
    CALL QSORT;调用排序函数
    MOV DL,'X';输出空格
    CALL OUTPUT
    MOV DL,':';输出空格
    CALL OUTPUT
    MOV CX,COUNT
    CALL SHOW;调用输出函数
    MOV DX,OFFSET ENT;输出回车
    MOV AH,09H
    INT 21H
    
    ;Y排序
    MOV SI,OFFSET Y
    MOV DI,OFFSET Y;数组起始地址
    MOV BX,OFFSET Y
    ADD BX,COUNT
    DEC BX;数组结束地址
    CALL QSORT;调用排序函数
    MOV DL,'Y';输出空格
    CALL OUTPUT
    MOV DL,':';输出空格
    CALL OUTPUT
    MOV CX,COUNT
    CALL SHOW;调用输出函数
    MOV DX,OFFSET ENT;输出回车
    MOV AH,09H
    INT 21H
    
    ;从后向前遍历
    XOR DI,DI;X的地址增量
    ADD DI,COUNT
    DEC DI
    XOR BX,BX;Y的地址增量
    ADD BX,COUNT
    DEC BX
    XOR SI,SI;Z的地址增量
COMPARE:
    CMP DI,BEGINC
    JE QUITC;DI<0
    CMP BX,BEGINC
    JE QUITC;BX<0
    
    MOV DH,X[DI]
    CMP DH,Y[BX]
    JE MOVEALL 
    JA MOVEX;x的元素大于y的元素，x的指针前移
    JB MOVEY
MOVEALL:;元素相等
    MOV DH,X[DI]
    MOV Z[SI],DH;元素相同，移入Z中
    DEC DI
    DEC BX
    INC SI
    JMP COMPARE
MOVEX:;X的指针前移
    DEC DI
    JMP COMPARE
MOVEY:;Y的指针前移
    DEC BX
    JMP COMPARE
QUITC:
    MOV DH,X[DI]
    CMP DH,Y[BX]
    JE MOVE
    JNE OUTPUTZ
MOVE:
    MOV DH,X[DI]
    MOV Z[SI],DH;元素相同，移入Z中
    INC SI
OUTPUTZ:    
    MOV CX,SI
    MOV SI,OFFSET Z
    MOV DL,'Z';输出空格
    CALL OUTPUT
    MOV DL,':';输出空格
    CALL OUTPUT

    CALL SHOW;调用输出函数
    MOV DL,';';输出回车
    CALL OUTPUT
    
    MOV AH,4CH
    INT 21H
QSORT PROC NEAR;排序函数
    PUSH DI;调取左值
    PUSH BX;调取右值
    CMP DI,BX
    JNB DONE;DI>=BX
    PUSH DI;保存左值
    PUSH BX;保存右值
    CALL PARTITION;进行一趟排序，将数据分成两段,中轴地址在AX
    POP BX
    POP DI
    
    PUSH BX;保存右值
    MOV BX,AX;a[i]=key,ax中存放枢轴的地址
    DEC BX
    PUSH DI;保存左值
    PUSH BX;i-1
    CALL QSORT;Qsort(a,left,i-1);   
    
    POP BX
    POP DI
    POP BX;消除上一次
    
    MOV DI,AX
    INC DI
    PUSH DI
    PUSH BX
    CALL QSORT;Qsort(a,i+1,right);
    
    POP BX
    POP DI
DONE:;快排结束
    POP BX
    POP DI
    RET
QSORT   ENDP

PARTITION PROC NEAR
    MOV CL,[DI];CL中存放左值，即为key
AG: 
    CMP DI,BX;while left<right
    JNB QUIT;DI>=BX
A:   
    CMP DI,BX;left<right
       JNB SWAP1;DI>=BX跳转  
    CMP [BX],CL;and key<=a[j]
    JB SWAP1;a[j]<=key,即找到了小数,交换到左边
    DEC BX;j--
    JMP A;while
SWAP1:;a[i]=a[j]
    MOV CH,[BX];[di]与[bx]交换
    MOV AH,[DI]
    MOV [DI],CH
    MOV [BX],AH
B:    
    CMP DI,BX;left<right
       JNB SWAP2;DI>=BX跳转  
    CMP [DI],CL;and key>=a[j]
    JA SWAP2;a[j]<=key,即找到了大数,交换到右边
    INC DI;i++
    JMP B
SWAP2:;A[I]=A[J]
    MOV CH,[BX]
    MOV AH,[DI]
    MOV [DI],CH
    MOV [BX],AH
    JMP AG;一趟完成，循环
QUIT:
    MOV AX,DI;中轴地址给Ax
    RET
PARTITION ENDP

SHOW PROC NEAR
    XOR AL,AL
    ADD AL,[SI]
    ADD AL,'0'
    MOV DL,AL;输出数组一个数
    INC SI
    CALL OUTPUT
    MOV DL,' ';输出空格
    CALL OUTPUT
    LOOP AG;循环
    RET
SHOW ENDP 

OUTPUT PROC
    MOV AH,02
    INT 21H
    RET
OUTPUT ENDP

CODES ENDS
END START