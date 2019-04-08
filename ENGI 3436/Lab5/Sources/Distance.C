// filename  ***************  SCI.C ****************************** 
// Ethan Hitchcock, Audrey Wang - Spring 2017, Lab 5
// Lab Group 13A 

#include <mc9s12c32.h>     /* derivative information */
#include "Distance.h"
#define RDRF 0x20   // Receive Data Register Full Bit
#define TDRE 0x80   // Transmit Data Register Empty Bit
#define ADPU 0b10000000
#define ATDCTL4_VAL 0b01100011
#define ATDCTL5_VAL 0b00000101
#define S1C 0b00001000


//-------------------------Distance_init------------------------
void Distance_init(void) {
int i;
  ATDCTL2 = ADPU; /* A/D Power On */
  for (i = 0; i< 20; i++);
  ATDCTL3 = S1C;
  ATDCTL4 = ATDCTL4_VAL; /* 10-bit resolution, 16 A/D conversion clock periods,prescaler of 3 */  
}

//-------------------------Read_Distance------------------------
unsigned short Read_Distance(void){
/* single channel, unsigned, single conversion sequence, channel 5 set */
  ATDCTL5 = ATDCTL5_VAL;
  while(ATDSTAT0_SCF == 0); 
return ATDDR0H;
}

