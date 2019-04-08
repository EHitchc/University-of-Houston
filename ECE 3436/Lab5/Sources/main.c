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
int i;

void main(void) {
  //Initialize DDRM
  DDRM |= DATA_DIRECTION;
  PTM |= DATA_DIRECTION;  
  //Initialize Baud Rate to 9600
  SCI_Init(9600);
  Distance_init();

  while(1){
    
    //Output "Enter Command" String
    SCI_OutString("Enter Command");
    SCI_OutString(newline);
  
    //Store Input String
    SCI_InString(store_string,STRING_MAX-1);
    SCI_OutString(newline);
  
    if(store_string[0] == command_on[0] && store_string[1] == command_on[1]) {
      SCI_OutString("Turning LED on.");
      SCI_OutString(newline);
      PTM &= ~DATA_DIRECTION;
    }    
    else if(store_string[0] == command_off[0] && store_string[1] == command_off[1]) {
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
      SCI_OutString("-d to output distance");
      SCI_OutString(newline);
    }
    else if(store_string[0] == command_dist[0] && store_string[1] == command_dist[1]) {
      SCI_OutUHex(Read_Distance());
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
      SCI_OutString("-d to output distance");
      SCI_OutString(newline);
    } 
    
    //clear string array
    for(i=0;i<STRING_MAX;i++){
      store_string[i] = 0;
    }
  }
}

  