;work2.1 calculate fourth power of 2 within 4 lines
CODES SEGMENT
    ASSUME CS: CODES
    START:
        MOV  AX, 2
        ADD  AX, AX
        ADD  AX, AX
        ADD  AX, AX
        INT  21; return to DOS
    CODES ENDS
END START