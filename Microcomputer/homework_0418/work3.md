# 微机作业20210418
假设从变量buff开始存放了200个字，编写一个程序统计出其正数、0和负数的个数，并把它们分别存入n1、n2和n3中。

## 思路
循环：每个字与0比较，根据标志位跳转到正数、0和负数的个数统计程序块。

## 坑
分清 cmp 有符号、无符号操作数影响的标志位。