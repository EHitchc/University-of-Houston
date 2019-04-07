            TITLE "Lab x - ECE 4436"

; Lab x - ECE 4436 - Fall 2010
; Authors: Clark Kent and Lois Lane
;    This program ...
;
;******************************************
; External symbol declarations (imported)

;******************************************
; Internal symbol definitions (exported)
        XDEF    countMatches

;******************************************
; Constant equates

;******************************************
; Code Section Start
Code:   SECTION
countMatches:
        ldab  #0
        stab  COUNTER
       
        
 CYCLE:
        ldaa  1,X+
        ldab  1,Y+
        cmpa  #0            ;EOS, RTS
        beq   _EXIT
        cmpb  #0            ;EOS, RTS
        beq   _EXIT
                
        cmpa  #$20          ;SPACE, SKIP
        beq   CYCLE
        cmpb  #$20
        beq   CYCLE
        
        cba   
        bne   CYCLE
        ldab  COUNTER
        incb
        stab  COUNTER
        bra   CYCLE
            
 _EXIT: 
        ldab  COUNTER  
        rts

;******************************************
; Constant data in ROM
Const:  SECTION

;******************************************
; Variable data in RAM
Data:   SECTION
 COUNTER:     DS.B    1


