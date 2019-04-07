            TITLE "Lab x - ECE 4436"

; Lab x - ECE 4436 - Fall 2010
; Authors: Audrey Wang and Ethan Hitchcock
;    This program ...
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
 HOLDER:      EQU 2

;******************************************
; Code Section Start
Code:   SECTION
Entry:
main:
; Initialization
; Initialize stack pointer
        lds       #__SEG_END_SSTACK
; Initialize a hold value        
        ldx       #holder     ;#holder is address of holder
        ldaa      #HOLDER     ;#initial value of 2 stored
        staa      0,x
; Initialize Serial port to 9600 buts/sec
        ldd       #9600
        jsr       SCI_Init
; Initialize DDRT Registers
; PT0 and PT1 to output, PT2 and PT3 to input
        bset      DDRT, T_SETTING
        bclr      DDRT, IN_SETTING
;
; Initialize PT0 and PT1 to off state
        bclr      PTT, T_SETTING

LOOP:
; Read Input from pins
        jsr       ReadSwitches

;******************************************
; Code Section ReadSwitches
ReadSwitches:
        ldd       PTT         ;IF PT0 and PT1 OFF
        asrb       
        asrb
        cmpb      #0
        bne       ELSE_TEST   ;IF PT0 or/and PT1 ON -> ELSE_TEST
        ldab      #0
        bra       END_IF       
ELSE_TEST:                                              
        cmpb      #3          ;IF PT0 XOR PT1 ON
        bhs       ELSE_LAST   ;IF PT0 and PT1 ON -> ELSE_LAST
        ldab      #1
        bra       END_IF
ELSE_LAST:
        ldab      #0          ;IF PT0 and PT1 ON
END_IF:
        bra       WriteSwitches
        
;******************************************
; Code Section WriteSwitches
WriteSwitches:
        cmpb      #1
        blo       ELSE_WRITE
        bset      PTT, T_SETTING
        bra       END_LOOP
ELSE_WRITE:
        bclr      PTT, T_SETTING
END_LOOP:
        ldx       #holder
        ldaa      0,x
        cba      
        beq       SKIP_OUTPUT_SERIAL
        jsr       SCI_OutChar        
SKIP_OUTPUT_SERIAL:
        stab      0,x      
        bra       LOOP
        
        
;******************************************
; Constant data in ROM
Const:  SECTION


;******************************************
; Variable data in RAM
Data:   SECTION        
holder: DS.B      1


