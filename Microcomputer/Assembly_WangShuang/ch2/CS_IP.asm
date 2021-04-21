CODES SEGMENT
    ASSUME CS: CODES
    START:
        MOV  AX, 2
        ADD  AX, AX
        ADD  AX, AX
        ; MOV  CS,  0  Illegal use of segment register
        ; MOV  CS:IP,  0   err: Undefined symbol: IP  not allowed to modify IP
        JMP CS:3
        JMP CS:0
    CODES ENDS
END START  