; 实验二 无符号数组排序 by wurui
; 建议使用VS Code查看/编辑
.model small
.data
    buf db 0ABH,0FH,4CH,3DH,7AH,0E0H,0FFH,11H,8H,88H,0ABH,0FH,4CH,3DH,7AH,0E0H,0FFH,11H,8H,88H
        db 0ABH,0FH,4CH,3DH,7AH,0E0H,0FFH,11H,8H,88H,0ABH,0FH,4CH,3DH,7AH,0E0H,0FFH,11H,8H,88H
    N=$-buf                                                         ; 计算数组长度
    LAST=N-1                                                        ; 最后一位数字的位置
    BEFORE db 'BEFORE SORT',0AH,'$'
    AFTER db 'AFTER SORT',0AH,'$'
.stack
.code
    start: 
; ========= 主程序，调用函数依次完成显示原数组，排序，显示新数组三功能。 =========
    MOV AX, @DATA
    MOV DS, AX
    ; ------------------------- 显示原数组 --------------------------
    MOV DX, OFFSET BEFORE
    MOV AH, 09H
    INT 21H

    MOV SI, OFFSET BUF
    MOV CX, N
    CALL SHOW
    ; -------------- 排序，DI记录左边界，BX记录右边界，闭区间 -----------
    MOV DI, OFFSET BUF
    MOV BX, DI
    ADD BX, LAST
    DEC BX
    CALL QSORT
    ; ------------------------ 显示排序后数组 ------------------------
    MOV DX, OFFSET AFTER
    MOV AH, 09H
    INT 21H
    MOV SI, OFFSET BUF
    MOV CX, N
    CALL SHOW
    ; ----------------------------- 退出 ---------------------------
    JMP EXIT

; ================================ 函数 ==============================
    ; -------------- 快速排序, 将数组从无序变为完全有序 ----------------
    QSORT PROC NEAR
        PUSH DI     ; 保存左右初值，使函数结束时能够恢复现场
        PUSH BX
        ; 若左右边界相接，排序结束
        CMP DI,BX
        JGE DONE;DI>=BX [bug] 因为右值BX有可能减少至负数，做有符号数判断
        ; 进行一轮排序
        CALL PARTITION;进行一轮排序
        ; 递归调用，排序中枢左侧部分
        PUSH BX     ; 调用QSORT时需改变右值，故保存右值
        MOV BX,AX   ; a[i]=key,ax中存放枢轴的地址
        DEC BX
        CALL QSORT  ; Qsort(a,left,i-1);   
        
        POP BX      ; 恢复右值

        ; 递归调用，排序中枢右侧
        MOV DI,AX
        INC DI
        CALL QSORT;Qsort(a,i+1,right);

    DONE:;快排结束
        POP BX
        POP DI
        RET
    QSORT ENDP

    ; ------------------------ 进行一轮排序 -------------------------
    PARTITION PROC NEAR
        PUSH DI         ;保存左值，退出时使用
        PUSH BX         ;保存右值
        MOV DL,[DI]     ;DL中存放基准值，即为key
    AG: 
        CMP DI,BX;while left<right
        JGE QUIT_QSORT;DI>=BX

    S: ; 在右侧寻找<key数，
        CMP DI,BX;left<right
        JGE AG;DI>=BX跳转  
        CMP [BX],DL     ; 无符号数比较，找到小数
        JB SWAP1;a[j]<=key,即找到了小数,交换到左边
        DEC BX;若未找到小数并交换，j--；否则
        JMP S;while
    SWAP1:; 将找到的[DI]复制到当前"空位"[BX]（[BX]数值已于上一轮被复制）
        MOV AH,[BX]
        MOV [DI],AH
    L:  ; 在左侧寻找>key数，
        CMP DI,BX;left<right
        JGE AG;DI>=BX跳转  
        CMP [DI],DL;and key>=a[j]
        JA SWAP2;a[j]<=key,即找到了大数,交换到右边
        INC DI;i++
        JMP L
    SWAP2:; 将找到的[BX]]复制到当前"空位"[DI]（[DI]数值已被另存至DL或上一轮复制）
        MOV AH,[DI]
        MOV [BX],AH
        
        ;一趟完成，循环
        JMP AG
    QUIT_QSORT:
        MOV [DI],DL;插入基准值
        MOV AX,DI;最后插入基准值的地址赋给AX
        POP BX
        POP DI
        RET
    PARTITION ENDP

    ; -------------------- 显示控制, 每行显示十个数 -------------------
    ; 显示输出并以回车结尾，SI指向要显示的数组，用CX输入数组大小
    SHOW PROC NEAR
        ; PUSH AL BUG: 不可以push字节
        PUSH SI
        PUSH AX
        PUSH BX
        PUSH CX

    JUDGE:
        CMP CX,10
        JG OUT10   ; 剩余数字超过十个,循环输出十个
        JMP QUIT_SHOW; 剩余数字不足十个,输出剩余并退出

    OUT10: ; 循环输出10个数并换行, 输出后CX-=10
        PUSH CX
        MOV CX,10
    OUT10_LP:
        MOV DL,[SI]
        INC SI
        CALL PRINT
        LOOP OUT10_LP;循环

        MOV DL,0AH;输出回车
        MOV AH,02H
        INT 21H
        POP CX
        SUB CX,10   ; 输出后CX-=10
        JMP JUDGE

    QUIT_SHOW:
        MOV DL,[SI]
        INC SI
        CALL PRINT
        LOOP QUIT_SHOW;循环
        MOV DL,0AH;输出回车
        MOV AH,02H
        INT 21H
        POP CX
        POP BX
        POP AX
        POP SI
        RET
    SHOW ENDP 

    ; 以字符格式显示输出两位16进制数，输出内容放在DL中
    PRINT PROC NEAR
        PUSH BX
        ; 先显示高四位，即DL右移四位后显示
        MOV BH,DL
        SHR DL,4    ; 已获得高四位
        CMP DL,0AH
        JGE ISLET1
        JS  ISNUM1
        ; 显示低四位，即DL高四位置为0，即与00001111求与
    P2:
        AND BH,0FH
        MOV DL,BH   ; 已获得低四位
        CMP DL,0AH
        JGE ISLET2
        JS  ISNUM2
    ISLET1:; 显示单个>9 DEX数字
        SUB DL,10
        ADD DL,'A'
        MOV AH,02
        INT 21H
        JMP P2
    ISNUM1:; 显示单个<9 DEX数字
        ADD DL,'0'
        MOV AH,02
        INT 21H
        JMP P2
    ISLET2:; 显示单个>9 DEX数字
        SUB DL,10
        ADD DL,'A'
        MOV AH,02
        INT 21H
        JMP EXIT_PRINT
    ISNUM2:; 显示单个<9 DEX数字
        ADD DL,'0'
        MOV AH,02
        INT 21H
        JMP EXIT_PRINT
    EXIT_PRINT:         ; 输出空格并退出
        MOV DL,' '  
        INT 21H
        POP BX
        RET
    PRINT ENDP

    EXIT:
    mov ax,4c00h
    int 21h

    end start