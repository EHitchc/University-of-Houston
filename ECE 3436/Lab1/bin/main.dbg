            TITLE "Lab 1 - ECE 4436"

; Lab 1 - ECE 4436 - Fall 2013
;
;    This program fills a table with consecutive integers,
;     starting with the value in the variable first.
;     For example, if first contains 5, the table will be:
;     5 6 7 8 9 10 11 12 13 14
;

; Lab Group 13A 
; Ethan Hitchcock, Audrey Wang

;******************************************
; External symbol declarations
            XREF    __SEG_END_SSTACK
;******************************************
; Internal symbol definitions
            XDEF    Entry, main
;******************************************
; Include derivative specific macros
            INCLUDE 'mc9s12c32.inc'
;******************************************
; Constant equates
TABLEN:     EQU       10     ;length of table

;******************************************
; Code Section Start
Code:       SECTION
Entry:
main:
; Initialization
; Initialize stack pointer
            lds      #__SEG_END_SSTACK
; Initialize loop data
            ldaa    first           ;init integer counter           
            ldab    #TABLEN         ;init counter to # entries      
            ldx     #table          ;init pointer to table start 
;                                                               
; Loop, filling the table with integers                         
;                                                               
addloop:                                                               
            staa    0,x             ;store in table
            inca                    ;increment to next integer                 
            inx                     ;point to next slot in table    
            decb                    ;decrement counter, done?       
            bne     addloop         ; if not, repeat                
; All done                                                                                                     
            bra     *               ;spin here             

;******************************************
; Constant data in ROM
Const:      SECTION
first:      DC.B    8               ;first integer value

;******************************************
; Variable data in RAM
Data:       SECTION
table:      DS.B     TABLEN 	    ;to be filled in with integers


