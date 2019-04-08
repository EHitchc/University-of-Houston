            TITLE "Lab 3 - ECE 3436"

; Lab 3 - ECE 3436 - Spring 2017
; Authors: Ethan Hitchcock and Audrey Wang
; Lab Group 13A
;    This program reads in two strings of 
;    text characters from the serial input,
;    process the two strings, and writes the 
;    results of the processing to the serial
;    output.
;
;******************************************
; External symbol declarations (imported)
        XREF    __SEG_END_SSTACK
        XREF    countMatches
        XREF    SCI_Init,SCI_InString
        XREF    SCI_OutString,SCI_OutUDec
        XREF    reset
;******************************************
; Internal symbol definitions (exported)
        XDEF    Entry, main
        
;******************************************
; Include derivative specific macros
        INCLUDE 'mc9s12c32.inc'
        
;******************************************
; Constant equates
 MAX_STRING:  EQU 30
 EOS:         EQU 0
 CR:          EQU 13
 LF:          EQU $0a
;******************************************
; Code Section Start
Code:   SECTION
Entry:
main:
; Initialization
; Initialize stack pointer
        lds      #__SEG_END_SSTACK
        
; Initialize serial port to 9600 bits/sec
        ldd      #9600
        jsr      SCI_Init
        
LOOP:   
; String 1     
        ldx      #Str_In_1
        pshx
        ldd      #MAX_STRING        
        jsr      SCI_InString
        
        ldd      #CAR
        jsr      SCI_OutString
   
 ; String 2       
        ldx      #Str_In_2
        pshx
        ldd      #MAX_STRING       
        jsr      SCI_InString
        
        ldd      #CAR
        jsr      SCI_OutString
        
; Jump to subroutine countMatches
        ldx      #Str_In_1
        ldy      #Str_In_2
        jsr      countMatches   ;Counter stored
                                ;in B
; Print number of matches
        
        ldaa     #0
        jsr      SCI_OutUDec
        ldd      #MATCHES_FOUND
        jsr      SCI_OutString
        ldd      #CAR
        jsr      SCI_OutString 
        
        ldx      #Str_In_1
        ldy      #Str_In_2
        jsr      reset  
        
; Do forever
        bra      LOOP
        
;******************************************
; Constant data in ROM
Const:  SECTION
CAR:              DC.B  CR,LF,EOS
MATCHES_FOUND:    DC.B  ' matches were found.',EOS
;******************************************
; Variable data in RAM
Data:   SECTION

Str_In_1:  DS.B   MAX_STRING  ; array 1
Str_In_2:  DS.B   MAX_STRING  ; array 2

