.data
    OrgArray: .word 12, 90, 31, 34, 99, 14, 90, 78, 39, 20, 19, 33, 45, 95, 22, 75, 84, 88, 89, 23, 21, 123, 987, 3, 24, 98, 23, 554, 54, 83, 247, 43, 48, 42, 67, 822, 324, 909, 419, 8, 56, 42
    EvenArray: .space 168
    OddArray: .space 168
.text
    ; 将三个数组的地址分别赋给r1, r2, r3
    ldr r1, =OrgArray
    ldr r2, =EvenArray
    ldr r3, =OddArray
    mov r4, #43         ; 记录循环次数

traverse: ; 遍历OrgArray
    sub r4, r4, #1
    beq exit
    ldr r0, [r1]
    add r1, r1, #4      ; r1增加至数组下一元素
    tst r0, #1
    bne odd
    beq even

odd: ; 奇数存入OddArray
    str r0, [r3]
    add r3, r3, #4
    b   traverse        ; 返回继续遍历

even:
    str r0, [r2]
    add r2, r2, #4
    b   traverse

exit:
    swi 0x11