// filename  ***************  MyTimer.C ****************************** 
// Ethan Hitchcock, Audrey Wang - Spring 2017, Lab 6
// Lab Group 13A 

#include <mc9s12c32.h>     /* derivative information */
#include "MyTimer.h"
#define PRESCALER 0x01     // Want 2MHz clock rate
#define CLOCK_100MS 200000
#define TOF_100MS 3

//NOTE BASE BUS CLOCK IS 4MHZ


//-------------------------Timer_init------------------------
void MyTimerInit(void) {
  TFLG2_TOF = 1;      //Clear TOF flag
  TSCR1_TEN = 1;   //Enable Timer
  TSCR2 = PRESCALER;      //Set prescaler to 2
  TC0 = 0x00;             //Clear TC0 register
}
    

//-------------------------Timer_delay------------------------
void Delay_100ms(void) {
int count = TOF_100MS;
  do{
    while (TFLG2_TOF == 0);
    TFLG2_TOF = 1;
  } while(--count > 0);
}


