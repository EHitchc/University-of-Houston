;**************************************************************
;     ECE 3436 - Lab 4 - Spring 2017
;     Ethan Hitchcock and Audrey Wang - Lab Group 13A
; Lower level C Programs written in Assembly
;**************************************************************
; export symbols
            XDEF SCI_Init, SCI_InChar, SCI_OutChar

;--------------------------------------------------------------
; include derivative specific macros
            INCLUDE 'mc9s12c32.inc'

;--------------------------------------------------------------
RAM:        SECTION

ROM:        SECTION
RDRF:            DC.B   $20   ; Receive Data Register Full Bit
TDRE:            DC.B   $80   ; Transmit Data Register Empty Bit

; code section
MyCode:     SECTION
; this assembly routine is called by the C/C++ application
;--------------------------------------------------------------
SCI_Init:       movb  #0, SCIBDH
                
                cpd   #2400
                beq   SET_BAUD_2400
                cpd   #4800
                beq   SET_BAUD_4800
                cpd   #9600
                beq   SET_BAUD_9600
                cpd   #19200
                beq   SET_BAUD_19200
                movb  #1, SCIBDL
                bra   SET_CR
SET_BAUD_2400:
                movb  #104, SCIBDL
                bra   SET_CR
SET_BAUD_4800:
                movb  #52, SCIBDL
                bra   SET_CR
SET_BAUD_9600:  
                movb  #26, SCIBDL
                bra   SET_CR
SET_BAUD_19200:
                movb  #13, SCIBDL
SET_CR:
                movb  #0, SCICR1
                movb  #$0C, SCICR2
                rts                
                
;--------------------------------------------------------------                
SCI_InChar:     
WHILE_0_IN:               
                ldaa  SCISR1
                anda  RDRF
                cmpa  #0
                beq   WHILE_0_IN
                ldab  SCIDRL
                rts
;--------------------------------------------------------------
SCI_OutChar:    
                pshb
WHILE_0_OUT:    
                ldaa  SCISR1
                anda  TDRE
                cmpa  #0
                beq   WHILE_0_OUT
                pulb 
                stab  SCIDRL
                rts    
