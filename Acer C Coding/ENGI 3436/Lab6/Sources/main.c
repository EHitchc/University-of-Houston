/**************************************************************
     ECE 3436 - Lab 5 - Spring 2017
     Ethan Hitchcock and Audrey Wang - Lab Group 13A
Main written in C to turn LED on/off given a character command
Outputs valid commands if invalid command given
-d command outputs HEX distance
**************************************************************/

#include <hidef.h>      /* common defines and macros */
#include <mc9s12c32.h>     /* derivative information */
#pragma LINK_INFO DERIVATIVE "mc9s12c32"

#include "main_asm.h" /* interface to the assembly module */
#include "SCI.H"        /* user defined macros */
#include "Distance.H"
#include "MyTimer.H"
#include "DistanceThread.H"
#include "PWM.H"
#define STRING_MAX 3  
#define DATA_DIRECTION 0x01

//Definition of Variables
//Constants
char newline[] = {13,10,0};

//Variable Storage
char store_string[STRING_MAX];
char command_on[3] = "-o";
char command_off[3] = "-f";
char command_help[3] = "-h";
char command_dist[3] = "-d";
char command_timeddist[3] = "-t";
char command_stoptimeddist[3] = "-s";
char command_beginPWM[3] = "-p";
char command_endPWM[3] = "-w";
int i, j;

void main(void) {
  //Initialize DDRM
  DDRM |= DATA_DIRECTION;
  PTM |= DATA_DIRECTION;  
  //Initialize Baud Rate to 9600
  SCI_Init(9600);
  Distance_init();
  MyTimerInit();
  initDistanceThread();
  init_PWM();
  
  while(1){
    
    //Output "Enter Command" String
    SCI_OutString("Enter Command");
    SCI_OutString(newline);
  
    //Store Input String
    SCI_InString(store_string,STRING_MAX-1);
    SCI_OutString(newline);
  
    if(store_string[0] == command_on[0] && store_string[1] == command_on[1]) {
      stopDistanceReading();
      SCI_OutString("Turning LED on.");
      SCI_OutString(newline);
      PTM &= ~DATA_DIRECTION;
    }    
    else if(store_string[0] == command_off[0] && store_string[1] == command_off[1]) {
      stopDistanceReading();
      SCI_OutString("Turning LED off.");
      SCI_OutString(newline);
      PTM |= DATA_DIRECTION;
    } 
    else if(store_string[0] == command_help[0] && store_string[1] == command_help[1]) {
      SCI_OutString("Valid commands are:");
      SCI_OutString(newline);
      SCI_OutString("-o to turn the LED on");
      SCI_OutString(newline);
      SCI_OutString("-f to turn the LED off");
      SCI_OutString(newline);
      SCI_OutString("-d to output sample of 5 distances");
      SCI_OutString(newline);
      SCI_OutString("-t to take timed distance readings and blink LED");
      SCI_OutString(newline);
      SCI_OutString("-s to stop taking timed distance readings");
      SCI_OutString(newline);
      SCI_OutString("-p to begin pulse.");
      SCI_OutString(newline);
      SCI_OutString("-w to stop pulse.");
      SCI_OutString(newline);
    }
    else if(store_string[0] == command_dist[0] && store_string[1] == command_dist[1]) {
      stopDistanceReading();
      for(i=0;i<5;i++) {
        for(j=0;j<10;j++) Delay_100ms();
        SCI_OutUHex(Read_Distance());
        SCI_OutString(newline);
      }
    }
    else if(store_string[0] == command_timeddist[0] && store_string[1] == command_timeddist[1]) {
      startDistanceReading();
      SCI_OutString("Pulse width now being updated with readings from ADC.");
      SCI_OutString(newline);
    }
    else if(store_string[0] == command_stoptimeddist[0] && store_string[1] == command_stoptimeddist[1]) {
      stopDistanceReading();
      SCI_OutString("Pulse width no longer being updated.");
      SCI_OutString(newline);
    }
    else if(store_string[0] == command_beginPWM[0] && store_string[1] == command_beginPWM[1]) {
      start_PWM();
      SCI_OutString("Pulse now being delivered.");
      SCI_OutString(newline);
    }
    else if(store_string[0] == command_endPWM[0] && store_string[1] == command_endPWM[1]) {
      stop_PWM();
      SCI_OutString("Pulse now turned off.");
      SCI_OutString(newline);
    }
    else {
      SCI_OutString("Error: Command Invalid");
      SCI_OutString(newline);
      SCI_OutString("Valid commands are:");
      SCI_OutString(newline);
      SCI_OutString("-o to turn the LED on");
      SCI_OutString(newline);
      SCI_OutString("-f to turn the LED off");
      SCI_OutString(newline);
      SCI_OutString("-d to output sample of 5 distances");
      SCI_OutString(newline);
      SCI_OutString("-t to take timed distance readings and blink LED");
      SCI_OutString(newline);
      SCI_OutString("-s to stop taking timed distance readings");
      SCI_OutString(newline);
      SCI_OutString("-p to begin pulse.");
      SCI_OutString(newline);
      SCI_OutString("-w to stop pulse.");
      SCI_OutString(newline);
    } 
    
    //clear string array
    for(i=0;i<STRING_MAX;i++){
      store_string[i] = 0;
    }
  }
}

  