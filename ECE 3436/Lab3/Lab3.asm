            TITLE "Lab 3 - ECE 3436"

; Lab 3 - ECE 3436 - Spring 2017
; Authors: Ethan Hitchcock and Audrey Wang
;    This program reads in two strings of 
;    text characters from the serial input,
;    process the two strings, and writes the 
;    results of the processing to the serial
;    output.
;
;******************************************
; External symbol declarations (imported)
        XREF    __SEG_END_SSTACK
;******************************************
; Internal symbol definitions (exported)
        XDEF    Entry, main
;******************************************
; Include derivative specific macros
        INCLUDE 'mc9s12c32.inc'
;******************************************
; Constant equates



;******************************************
; Code Section Start
Code:   SECTION
Entry:
main:
; Initialization
; Initialize stack pointer
        lds      #__SEG_END_SSTACK
; Initialize Serial Port to 9600 bits/sec
        ldd      #9600
        jsr      SCI_Init





;******************************************
; Constant data in ROM
Const:  SECTION


;******************************************
; Variable data in RAM
Data:   SECTION



