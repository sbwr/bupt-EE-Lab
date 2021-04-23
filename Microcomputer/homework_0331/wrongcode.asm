CODES  SEGMENT
     ASSUME    CS:CODES
START:;相当于main函数
    XOR  BX, [SI][DI]
    SUB  SI, - 91
    TEST AL, 8000H
    CMP  [BX],  [SI]
    MOV  AX, CL
    MOV  25, BL
    MOV  AX, BX+9999H
CODES  ENDS
    END   START