;����5.2����һ���ֽ����ݵĸߵ���λ��Ϊ��λʮ��������
;ע�⵽�˴���Ѱַ��ʽ��HEX[],DATA[]����C�����е����飬��������number[BX]��Ѱַ��ʽ��0[bx]��5[bx]�����ε�ַ��ƫ����
SSEG SEGMENT STACK
STK DB 20 DUP(0)
SSEG ENDS
DSEG SEGMENT
DATA DB 0B5H
HEX DB 0,0,'$';���B��5����ʮ��������
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
	XLAT;AL��x�������B5
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
;�����Ѿ������Ŀ,���潫����ʾ����
	MOV CL,'$'
	MOV AX,DS
	MOV ES,AX
	MOV BX,OFFSET HEX
	CALL DISPLAY

	MOV AX,4C00H
	INT 21H
;--------------------------��es:bx��ʼ���ַ������ֱ������CL������

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

	
