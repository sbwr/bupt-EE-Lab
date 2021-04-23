第三章 指令系统和寻址方式

1. 判断下面各语句的正确性（其中VAR为数据段中定义的字变量）。

   (1) XOR BX, [SI][DI]

   (2) SUB    SI, - 91

   (3) MOV   BX, SS:[SP]

   (4) TEST AL, 8000H

   (5) CMP  [BX],  [SI]

   (6) MOV AX, CL

   (7) MOV 25, BL

   (8) MOV AX, BX+VAR

2. 写出下列指令序列中每条指令的执行结果，并指出标志位CF、ZF、OF、SF的变化情况。

    MOV  BX,  40ABH 

    ADD  BL,  09CH 

    MOV  AL,  0E5H 

    CBW 

    ADD  BH,  AL 

    ADC  AX,  20H 