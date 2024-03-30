org 256
.data
    risultato dd ?
    resto dd ?
    dieci dw ?
    input1 dd ?
    input2 dd ?
    var db ?
    msg1 dB "Primo numero: $", '$'
    msg2 db "Secondo numero: ", '$'
    msg3 db "Segno: ", '$'
    msg4 db "Il risultato e' ", '$'
    msg5 db "Resto: ", '$'

.code
    MOV dieci, 10
    MOV var, 4 
    MOV BX, 00h
              
switch2:
    DEC var
    LEA DX, msg1
    MOV AH, 09h
    INT 21h
    CMP var, 03h
    JE input
    
    MOV AX,0003h
    INT 10h
    LEA DX, msg3
    MOV AH, 09h
    INT 21h
    CMP var, 02h
    JE switch
    
    CMP var, 01h
    MOV BX, 00h
    MOV CX, 00h
    MOV AX,0003h
    INT 10h
    LEA DX, msg2
    MOV AH, 09h
    INT 21h
    JE input

    MOV AX,0003h
    INT 10h    
    LEA DX, msg4
    MOV AH, 09h
    INT 21h
    CMP var, 00h
    JE segno
    
input:
    MOV AX, 00h
    INT 16h
    CMP AH, 1Ch
    JE primo
    MOV AH, 00h
    SUB AL, 30h
    PUSH AX
    ADD CH, 1h
    JMP input

continua:
    INC BH
    CMP var, 03
    JE  somma1
    JMP somma2
primo:
    CMP CH, BH
    JE switch2
    POP AX
    MOV CL, 00h                 
    
ciclo:
    CMP CL, BH
    JE continua 
    JMP X10
    
uguali:
    INT 21h

X10:
    MUL dieci
    INC CL
    JMP ciclo
somma1:
    ADD input1, AX
    JMP primo

somma2:
    ADD input2, AX
    JMP primo   

switch:
    MOV AX, 00h
    INT 16h
    MOV AH, 00h
    PUSH AX
    JMP switch2                           

addizione:
    MOV AX, input1
    ADD AX, input2
    MOV risultato, AX             
    JMP output      

sottrazione:
    MOV AX, input1
    SUB AX, input2
    MOV risultato, AX                
    JMP output      
 
moltiplicazione:
    MOV AX, input1
    MUL input2
    MOV risultato, AX                   
    JMP output      

divisione:
    MOV DX, 00h
    MOV AX, input1      
    DIV input2
    MOV risultato, AX
    MOV resto ,DX                   
    JMP output       

segno:
    POP AX
    CMP AL, '+'     
    JE addizione    
    CMP AL, '-'     
    JE sottrazione  
    CMP AL, '*'     
    JE moltiplicazione 
    CMP AL, '/'     
    JE divisione
    
output: 
    MOV AX, risultato  
    MOV CX, 10          

    MOV BX, 10         
    MOV SI, 0          

stampa:
    MOV DX, 0           
    DIV BX              

    ADD DL, '0'         
    MOV [SI], DL        
    INC SI              

    CMP AX, 0        
    JNZ stampa 


exit:
    DEC SI              

    MOV AH, 02h         
    MOV DL, [SI]        
    INT 21h             

    CMP SI, 0
    JG exit    
    
    CMP resto, 0h
    JNE output1
    MOV AH, 4Ch
    INT 21h

output1:
    MOV DH, 01h
    MOV DL, 00h
    MOV AH ,02h
    INT 10h
    LEA DX, msg5
    MOV AH, 09h
    INT 21h 
    MOV AX, resto  
    MOV CX, 10          

    MOV BX, 10         
    MOV SI, 0          

stampa1:
    MOV DX, 0           
    DIV BX              

    ADD DL, '0'         
    MOV [SI], DL        
    INC SI              

    CMP AX, 0        
    JNZ stampa1 


exit1:
    DEC SI              

    MOV AH, 02h         
    MOV DL, [SI]        
    INT 21h             

    CMP SI, 0
    JG exit    
    MOV AH, 4Ch
    INT 21h
