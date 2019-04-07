            TITLE "Lab x - ECE 4436"

; Lab x - ECE 4436 - Fall 2010
; Authors: Clark Kent and Lois Lane
;    This program ...
;
;******************************************
; External symbol declarations (imported)
        XREF    __SEG_END_SSTACK
        XREF    countMatches
        XREF    SCI_Init,SCI_InString
;******************************************
; Internal symbol definitions (exported)
        XDEF    Entry, main
;******************************************
; Include derivative specific macros
        INCLUDE 'mc9s12c32.inc'
;******************************************
; Constant equates
 STRING_MAX:    EQU   30
 EOS:           EQU   0


;******************************************
; Code Section Start
Code:   SECTION
Entry:
main:
; Initialization
; Initialize stack pointer
        lds      #__SEG_END_SSTACK
; Initialize ...
        ldd      #9600
        jsr      SCI_Init
        
;        ldx      #String_1
;        ldd      #STRING_MAX
;        jsr      SCI_InString
;        bra      *

         ldx     #HELLO    
         ldy     #FUCK
         jsr     countMatches
         bra     *


;******************************************
; Constant data in ROM
Const:  SECTION
 HELLO:       DC.B    'Hello World!',EOS
 FUCK:        DC.B    'Fuck   World!',EOS

;******************************************
; Variable data in RAM
Data:   SECTION
 String_1:    DS.B    STRING_MAX


