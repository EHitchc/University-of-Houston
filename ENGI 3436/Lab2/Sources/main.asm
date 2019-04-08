            TITLE "Lab 2 - ECE 4436"

; Lab 2 - ECE 4436 - Spring 2017
; Authors: Audrey Wang and Ethan Hitchcock
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
        XREF    SCI_Init,SCI_OutChar
;******************************************
; Constant equates
 T_SETTING:   EQU %00000011
 IN_SETTING:  EQU %00001100

;******************************************
; Code Section Start
Code:   SECTION
Entry:
main:
; Initialization
; Initialize stack pointer
        lds       #__SEG_END_SSTACK

; Initialize Serial port to 9600 buts/sec
        ldd       #9600
        jsr       SCI_Init
        
; Initialize PT0 and PT1 to turn LED off
        bset      PTT, T_SETTING
        
; Initialize DDRT Registers
; PT0 and PT1 to output, PT2 and PT3 to input
        bset      DDRT, T_SETTING
        bclr      DDRT, IN_SETTING
;
; Initialize A to != 0 or 1        
        ldaa      #2

LOOP:
; Read Input from pins
        jsr       ReadSwitches
        jsr       WriteSwitches
        
        cba                         ;If B == previous value of B stored in holder
        beq       SKIP_OUTPUT_SERIAL;Skip output in TERA
        jsr       SCI_OutChar        
SKIP_OUTPUT_SERIAL:
        exg       A, B              ;Store new B in A
        
        bra       LOOP
        
;******************************************
; Code Section ReadSwitches
ReadSwitches:
        ldab      PTT               ;IF PT2 and PT3 LO
        asrb       
        asrb
        cmpb      #0
        bne       ELSE_TEST         ;IF PT2 or/and PT3 HI -> ELSE_TEST
        ldab      #0
        rts       
ELSE_TEST:                                              
        cmpb      #3                ;IF PT2 XOR PT3 HI
        bhs       ELSE_LAST         ;IF PT2 and PT3 HI -> ELSE_LAST
        ldab      #1
        rts
ELSE_LAST:
        ldab      #0                ;IF PT2 and PT3 HI
        rts
        
;******************************************
; Code Section WriteSwitches
WriteSwitches:
        cmpb      #1                ;IF B Register from ReadSwitches =1
        blo       ELSE_WRITE        ;Turn on LEDS
        bclr      PTT, T_SETTING
        rts
ELSE_WRITE:                         ;IF B Register from ReadSwitches =0
        bset      PTT, T_SETTING    ;Turn off LEDS
        rts       
        
;******************************************
; Constant data in ROM
Const:  SECTION


;******************************************
; Variable data in RAM
Data:   SECTION        


