// filename  ***************  PWM.C ****************************** 
// Ethan Hitchcock, Audrey Wang - Spring 2017, Lab 5
// Lab Group 13A 

#include <mc9s12c32.h>     /* derivative information */
#include "PWM.H"
#define DELAY_20MS 40000

unsigned short pulsewidth;
unsigned short storepulse;

//--------------------------start_PWM--------------------------
void start_PWM(void){
  TC5 = TCNT + DELAY_20MS;
  TIE_C5I = 1;       //Enable interrupts on TC5
}

//---------------------------stop_PWM--------------------------
void stop_PWM(void){
  while(TCTL1_OL5 == 1);
  TIE_C5I = 0;
}

//-----------------------set_Pulse_Width------------------------
void set_Pulse_Width(unsigned short us){
  pulsewidth = us*2;
}

//----------------------------init_PWM--------------------------
void init_PWM(void){
  TIOS_IOS5 = 1;
  TFLG2_TOF = 1;
  TFLG1_C5F = 1;
  TCTL1_OM5 = 1;           //Set PT5 Output to change with C5I
}

//----------------------------PWM_ISR---------------------------
void interrupt 13 PWM_ISR(void){
  if(TCTL1_OL5 == 0){
    TCTL1_OL5 = 1;
    TC5 += pulsewidth;
    storepulse = pulsewidth;
  }
  else {
    TCTL1_OL5 = 0;
    TC5 += (DELAY_20MS - storepulse);
  }
  TFLG1_C5F = 1;
  return;
}
  
  
  
  

