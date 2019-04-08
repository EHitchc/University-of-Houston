// filename  ***************  SCI.C ****************************** 
// Ethan Hitchcock, Audrey Wang - Spring 2017, Lab 5
// Lab Group 13A 

#include <mc9s12c32.h>     /* derivative information */
#include "DistanceThread.H"
#include "PWM.H"
#define TIMER_OUTCOMP 1
#define DELAY_250MS 41255  //41255 clocks + 7 TOF = 250ms
#define TOF_FLAG 1
#define DELAY_250MS_TOF 7
#define ATDCTL5_VAL 0b00000101
#define DATA_DIRECTION 0x01


int count_TOF = DELAY_250MS_TOF;

//-------------------Distance_thread_init------------------------
void initDistanceThread(void) {
  TIOS |= TIMER_OUTCOMP;    //Set Timer to Output Compare bit 1
  TFLG2 = TOF_FLAG;         //Clear TOF Flag
  TFLG1 = TIMER_OUTCOMP;    //Clear C0F Flag
}

//--------------------Start_Read_Distance------------------------
void startDistanceReading(void) {
  TC0 = TCNT + DELAY_250MS;
  TIE |= TIMER_OUTCOMP;      //Enable interrupts on TC0 register
}
    

//-------------------distance_reading_ISR------------------------
void interrupt 8 distanceReading_ISR(void) {
unsigned short reading;
  if(count_TOF == 0){
    count_TOF = DELAY_250MS_TOF;  //Reset TOF Counter
    ATDCTL5 = ATDCTL5_VAL;        //Read distance
    while(ATDSTAT0_SCF == 0){}    //Wait until read
    reading = ATDDR0H + 1000; //Scale to 1000-2000
    if(reading > 2000) reading = 2000;
    set_Pulse_Width(reading);
    if(PTM & DATA_DIRECTION == 0) PTM |= DATA_DIRECTION;  //Toggle LED
    else PTM &= ~DATA_DIRECTION;
    TFLG2 = TOF_FLAG;             //In case TOF flagged    
  } 
  else if(TFLG2 & TOF_FLAG == 1){
    count_TOF--;            //Decrease counter, wait till 7 TOF
    TFLG2 = TOF_FLAG;       //Reset TOF Flag
  } 
                            //if TOF not flagged skip decrement of counter
  TC0 += DELAY_250MS;       //Update Output Compare Value
  TFLG1 = TIMER_OUTCOMP;    //Reset Output Compare Flag
  return;
}
  

//--------------------Stop_Read_Distance------------------------
void stopDistanceReading(void)  {
  TIE &= ~TIMER_OUTCOMP;    //Turn off interrupts
}


