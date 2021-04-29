.data
    array: .word 0, 1, 2, 3, 99, 789
.text
    ldr r1, =array
    ldr r2, [r1]
    ldr r1, =array+4
    ldr r3, [r1]