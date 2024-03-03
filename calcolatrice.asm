.code
    MOV CX, 02h   
    MOV BX, 00h       
    MOV DL, 01h       

invio:
    CMP CX, 00h       
    JE switch       
    MOV AH, 00h       
    INT 16h         
    SUB CX, 01h       
    CMP DL, 01h       
    JE spostamento1 
    JMP spostamento2 

switch:
    MOV AX, 00h
    INT 16h         
    CMP AL, '+'     
    JE addizione    
    CMP AL, '-'     
    JE sottrazione  
    CMP AL, '*'     
    JE moltiplicazione 
    CMP AL, '/'     
    JE divisione    
    JMP switch        

spostamento1:
    MOV DL, AL       
    JMP invio       

spostamento2:
    MOV CL, AL      
    JMP switch      

addizione:
    SUB DL, 30h
    SUB CL, 30h
    ADD DL, CL              
    JMP exit      

sottrazione:
    SUB DL, 30h
    SUB CL, 30h
    SUB DL, CL               
    JMP exit      
 
moltiplicazione:
    SUB DL, 30h
    SUB CL, 30h
    MOV AX, 00h
    MOV AL, CL
    MOV DH ,00h
    MUL DL                   
    JMP exit      

divisione:
    SUB DL, 30h
    SUB CL, 30h
    MOV AX, 00h
    MOV AL, DL
    MOV DL, CL
    MOV CL, 00h
    CMP DL, 00h
    JE zero     
    DIV DL                   
    JMP exit       

exit:
    INT 21h

zero:
    MOV AX, 00h
    MOV BX, 00h
    MOV CX, 00h
    MOV DX, 00h
    INT 21h