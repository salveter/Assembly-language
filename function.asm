;--------------------------��es:bx��ʼ���ַ������ֱ������CL������
display:
       back:
            CMP BYTE PTR ES:[BX],CL
            JZ DONE
            MOV DL,ES:[BX]
            MOV AH,02H
            INT 21H
            INC BX
            JMP SHORT BACK
       DONE:
            RET 
