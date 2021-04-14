    AREA	Example1,CODE,READONLY	  ;声明代码段Example1 
	ENTRY				  ;标识程序入口 
	CODE32				  ;声明32位ARM指令
START
    MOV	R0,#0			  ;设置参数 
 	MOV	R1,#10
LOOP
    BL	ADD_SUB	    		  ;调用子程序ADD_SUB 
	B	LOOP			  ;跳转到LOOP
ADD_SUB	 
	ADDS	R0,R0,R1		  ;R0 = R0 + R1 
	MOV     PC,LR	     		  ;子程序返回 
END