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

;--------------------------------------------------------

;------------------��AL�е�����ת��ΪASCII��

TO_ASCII PROC
         AND AL,0FH
         CMP AL,10
         JC NUM;˵��AL��벿��С�ڵ���'9',��ֱ�Ӽ���'0'��ASCII�뼴��
         ADD AL,07H;˵��AL��벿��ΪA-H��Ҫ�ڡ�0���Ļ����ϼ���7
     NUM:ADD AL,30H
         RET
TO_ASCII ENDP

ASCII PROC
      PUSH CX
      MOV CH,AL
      MOV CL,4
      SHR AL,CL
      CALL TO_ASCII;����AL�ĸ���λ
      MOV AH,AL
      MOV AL,CH
      CALL TO_ASCII
      POP CX
      RET
ASCII ENDP                
;-----------------------------------------------------------
