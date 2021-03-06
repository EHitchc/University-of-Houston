            TITLE "Lab 3 - ECE 3436"

; Lab 3 - ECE 3436 - Spring 2017
; Authors: Ethan Hitchcock and Audrey Wang
; Lab Group 13A
;   Subroutine: countMatches
;
;******************************************
; External symbol declarations (imported)

;******************************************
; Internal symbol definitions (exported)
        XDEF    countMatches
        XDEF    reset

;******************************************
; Constant equates
 MAX_STRING:  EQU 
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
        cmpb  #0            
        beq   _EXIT
                
        cmpa  #$20          ;SPACE, SKIP
        beq   CYCLE
        cmpb  #$20
        beq   CYCLE
        
        cba                 ;Are they equal
        bne   CYCLE
        ldab  COUNTER       ;If yes, increment
        incb                ;counter
        stab  COUNTER
        bra   CYCLE
            
 _EXIT: 
        ldab  COUNTER       ;load Counter to B
        rts                 ;before returning

reset:
        ldab  #0
        ldaa  #0
LOOP_Reset:        
        staa  1,X+
        staa  1,Y+
        incb
        cmpb  #MAX_STRING
        beq   __EXIT
        bra   LOOP_Reset
__EXIT:
        rts        
        
;******************************************
; Constant data in ROM
Const:  SECTION

;******************************************
; Variable data in RAM
Data:   SECTION
 COUNTER:     DS.B    1


