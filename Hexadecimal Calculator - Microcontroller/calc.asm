 ORG 0H
	    
		MOV P0,#00H
	    MOV A,#38H 
		ACALL COMMAND
		ACALL DELAY
		MOV A,#0EH
		ACALL COMMAND
		ACALL DELAY
K0:    	MOV A,#01H
		ACALL COMMAND
		ACALL DELAY
		MOV A,#06H
		ACALL COMMAND
		ACALL DELAY
		MOV A,#86H
		ACALL COMMAND
	    ACALL DELAY
	  
	  MOV P3,#0FFH   
K1:   MOV P1,#00H    
      MOV A,P3
      ANL A,00001111B
      CJNE A,#00001111B,K1
K2:   ACALL DELAY
      MOV A,P3
      ANL A,00001111B
      CJNE A,#00001111B,K3
      SJMP K2
K3:   ACALL DELAY
      MOV A,P3
      ANL A,00001111B
      CJNE A,#00001111B,K4
      SJMP K2
K4:   MOV P1,#11111110B
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,RW0
      MOV P1,#11111101B
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,RW1
      MOV P1,#11111011B
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,RW2
      MOV P1,#11110111B
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,RW3
      LJMP K2
      
RW0:MOV DPTR,#300H
      SJMP FIND1
RW1:MOV DPTR,#304H
      SJMP FIND1
RW2:MOV DPTR,#308H
      SJMP FIND1
RW3:MOV DPTR,#30CH

FIND1: RRC A
       JNC MATCH1
       INC DPTR 
       SJMP FIND1
MATCH1:CLR A
       MOVC A,@A+DPTR
       MOV R0,A
	 
	   MOV A,R0
	   SUBB A,#0AH
	   JNC A1
	   MOV A,R0
	   ADD A,#30H
	   SETB C
	   JC B1
A1:	   MOV A,R0
	   ADD A,#37H
B1:	   ACALL DAT
OP:	   MOV P2,#00H
	 	
	
		

	 
L1:   MOV A,P2
      ANL A,#00011111B
      CJNE A,#00H,L2
	  SJMP L1
L2:   MOV A,P2
      MOV R7,A
	  
	
  	 CJNE R7,#00000001B,ADD0
	  LJMP K0

	  
ADD0:	CJNE R7,#00000010B,DIF0
       MOV A,#2BH
	   ACALL DAT
	    LJMP O2
		
DIF0:   CJNE R7,#00000100B,PROD0
       MOV A,#2DH
	   ACALL DAT
	    LJMP O2
		
PROD0:  CJNE R7,#00001000B,QUO0
	   MOV A,#2AH
	   ACALL DAT
	    LJMP O2
		
QUO0: 	MOV A,#2FH
		ACALL DAT
	    LJMP O2
		
      
	  

O2:	  MOV P3,#0FFH
M1:   MOV P1,#0H
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,M1
M2:   ACALL DELAY
		
		
		//BACKSPACE
	   MOV A,P2
	   CJNE A,#00000001B,CONT
	   MOV A,#4H
		ACALL COMMAND
		ACALL DELAY
		MOV A,#' '
	    ACALL DAT
		ACALL DAT
		MOV A,#06H
		ACALL COMMAND
		ACALL DELAY
		MOV A,#87H
		ACALL COMMAND
	    ACALL DELAY
		CLR P2.0
		ACALL DELAY
		LJMP OP
		
	  
CONT:
	  MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,M3
      SJMP M2
M3:   ACALL DELAY
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,M4
      SJMP M2
M4:   MOV P1,#11111110B
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,RW02
      MOV P1,#11111101B
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,RW12
      MOV P1,#11111011B
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,RW22
      MOV P1,#11110111B
      MOV A,P3
      ANL A,#00001111B
      CJNE A,#00001111B,RW32
      LJMP M2
      
RW02:MOV DPTR,#300H
       SJMP FIND2
RW12:MOV DPTR,#304H
       SJMP FIND2
RW22:MOV DPTR,#308H
       SJMP FIND2
RW32:MOV DPTR,#30CH

FIND2: RRC A
       JNC MATCH2
       INC DPTR 
       SJMP FIND2
MATCH2: CLR A
        MOVC A,@A+DPTR
        MOV R1,A
      
	    MOV A,R1
	   SUBB A,#0AH
	   JNC A2
	   MOV A,R1
	   ADD A,#30H
	   SETB C
	   JC B2
A2:	   MOV A,R1
	   ADD A,#37H
B2:	   ACALL DAT
	   MOV P2,#00H
	   
	   MOV A,#3DH
	   ACALL DAT
	   MOV P2,#00H
	   
	   
       CJNE R7,#00000010B,DIF
       MOV A,R0
       ADD A,R1
       MOV P0,A
	   LJMP ANS 
	   
DIF:   CJNE R7,#00000100B,PROD
       MOV A,R0
       SUBB A,R1
       MOV P0,A
	   LJMP ANS
	   
PROD:  CJNE R7,#00001000B,QUO
	   MOV A,R0
       MOV B,R1
       MUL AB
       MOV P0,A
	   LJMP ANS
	   
QUO:   MOV A,R0
       MOV B,R1
       DIV AB
       MOV P0,A
       LJMP ANS


ANS:   MOV A,P0
	   MOV R6,A
       ANL A,#0F0H
   	   SWAP A
	   MOV R5,A
	   CLR C
	   SUBB A,#0AH
	   JNC DOWN
	   MOV A,R5
	   ADD A,#30H
	   MOV R5,A
       SJMP DOWN2
	   
DOWN:  MOV A,R5
   	   ADD A,#37H			  
	   MOV R5,A

DOWN2: MOV A,R6
	   ANL A,#0FH
	   MOV R6,A
	   CLR C
	   SUBB A,#0AH
	   JNC DOWN1
   	   MOV A,R6
	   ADD A,#30H
	   SJMP DOWN3
DOWN1: MOV A,R6
       ADD A,#37H
DOWN3: MOV R4,A

		
		MOV A,R5
		ACALL DAT
		MOV A,R4
		ACALL DAT
		
		
		MOV P2,#00H
HERE:	MOV A,P2
		CJNE A,#00000001B,HERE
		LJMP K0


COMMAND:
		MOV P0,A
		CLR P2.5
		CLR P2.6
		SETB P2.7
		ACALL DELAY
		CLR P2.7
		MOV P2,#00H
		RET 
DAT:	
		MOV  P0,A
		SETB P2.5
		CLR  P2.6
		SETB P2.7
		ACALL DELAY
		CLR P2.7
		MOV P2,#00H
		RET

DELAY:	MOV R3,#50
HERE2:	MOV R2,#255
HERE1:	DJNZ R2,HERE1
		DJNZ R3,HERE2
		RET

ORG 300H
	DB 0H,1H,2H,3H
	DB 4H,5H,6H,7H
	DB 8H,9H,0AH,0BH
	DB 0CH,0DH,0EH,0FH

END