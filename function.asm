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

;--------------------------------------------------------

;------------------将AL中的内容转换为ASCII码

TO_ASCII PROC
         AND AL,0FH
         CMP AL,10
         JC NUM;说明AL后半部分小于等于'9',就直接加上'0'的ASCII码即可
         ADD AL,07H;说明AL后半部分为A-H，要在‘0’的基础上加上7
     NUM:ADD AL,30H
         RET
TO_ASCII ENDP

ASCII PROC
      PUSH CX
      MOV CH,AL
      MOV CL,4
      SHR AL,CL
      CALL TO_ASCII;处理AL的高四位
      MOV AH,AL
      MOV AL,CH
      CALL TO_ASCII
      POP CX
      RET
ASCII ENDP                
;-----------------------------------------------------------
