CODES  SEGMENT
     ASSUME    CS:CODES
START:; the main program, like main of C++
    MOV  BX,  40ABH
    ADD  BL,  09CH 
    MOV  AL,  0E5H 
    CBW 
    ADD  BH,  AL 
    ADC  AX,  20H 
    MOV  SI,  0
    SUB  SI,  -91
    CBW; added line to pause and watch the result of last line
CODES  ENDS
    END   START