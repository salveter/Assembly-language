;例题5.2，将一个字节数据的高低四位变为两位十六进制数
;注意到此处的寻址方式：HEX[],DATA[]类似C语言中的数组，还有类似number[BX]的寻址方式如0[bx]，5[bx]代表段地址的偏移量
SSEG SEGMENT STACK
STK DB 20 DUP(0)
SSEG ENDS
DSEG SEGMENT
DATA DB 0B5H
HEX DB 0,0,'$';存放B，5两个十六进制数
DSEG ENDS
CSEG SEGMENT
	ASSUME CS:CSEG,DS:DSEG,SS:SSEG

DISC:
	MOV AX,DSEG
	MOV DS,AX
	MOV AX,SSEG
	MOV SS,AX
	MOV SP,SIZE STK
	MOV AL,0
	MOV BX,OFFSET DATA
	XLAT;AL中x储存的是B5
	MOV AH,AL
	AND AL,0FH
	CMP AL,10
	JB NUM
	ADD AL,7
NUM:	ADD AL,30H
	MOV HEX[0],AL
	MOV AL,AH
	MOV CL,4
	SHR AL,CL
	CMP AL,10
	JB NUM1
	ADD AL,7
NUM1:	ADD AL,30H
	MOV HEX[1],AL
;至此已经完成题目,下面将其显示出来
	MOV CL,'$'
	MOV AX,DS
	MOV ES,AX
	MOV BX,OFFSET HEX
	CALL DISPLAY

	MOV AX,4C00H
	INT 21H
;--------------------------将es:bx开始的字符输出，直到遇见CL的内容

DISPLAY PROC

       BACK:

            CMP BYTE PTR ES:[BX],CL

            JZ DONE

            MOV DL,ES:[BX]

            MOV AH,02H

            INT 21H

            INC BX

            JMP SHORT BACK

       DONE:

            RET 

DISPLAY ENDP
CSEG ENDS
	END DISC

	

