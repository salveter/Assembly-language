;--------------------------将es:bx开始的字符输出，直到遇见CL的内容
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
