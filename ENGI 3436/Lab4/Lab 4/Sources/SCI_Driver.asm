;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************

; export symbols
            XDEF SCI_Init, SCI_InChar, SCI_OutChar
;--------------------------------------------------------------
; include derivative specific macros
            INCLUDE 'mc9s12c32.inc'
;--------------------------------------------------------------
RAM:        SECTION
RETURN_POINTER:  DS.W   1

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
                movw  #2400, SCIBDL
                bra   SET_CR
SET_BAUD_4800:
                movw  #4800, SCIBDL
                bra   SET_CR
SET_BAUD_9600:  
                movw  #9600, SCIBDL
                bra   SET_CR
SET_BAUD_19200:
                movw  #19200, SCIBDL
SET_CR:
                movb  #0, SCICR1
                movb  #$0C, SCICR2
                rts                
                
;--------------------------------------------------------------                
SCI_InChar:     
WHILE_0_IN:    
;                ldx   SCISR1
 ;               ldy   RDRF
  ;              cpx   #0
   ;             beq   WHILE_0_IN
    ;            cpy   #0
     ;           beq   WHILE_0_IN
      ;          ldd   SCIDRL                  
       ;         rts
                
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
;                ldx   SCISR1
 ;               ldy   TDRE
  ;              cpx   #0
   ;             beq   WHILE_0_OUT
    ;            cpy   #0
     ;           beq   WHILE_0_OUT
      ;          puld
       ;         std   SCIDRL                
                
                ldaa  SCISR1
                anda  RDRF
                cmpa  #0
                beq   WHILE_0_OUT
                pulb 
                stab  SCIDRL
                rts    
