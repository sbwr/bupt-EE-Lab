### 分析下面指令序列完成的功能。

    MOV CL, 4
    SHL DX, CL
    MOV BL, AH
    SHL AX, CL
    SHR BL, CL
    OR  DL, BL

提示：连续执行后完成的功能