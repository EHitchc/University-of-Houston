/**************************************************************
     ECE 3436 - Lab 4 - Spring 2017
     Ethan Hitchcock and Audrey Wang - Lab Group 13A
Main written in C to turn LED on/off given a character command
**************************************************************/

#include <hidef.h>      /* common defines and macros */
#include <mc9s12c32.h>     /* derivative information */
#pragma LINK_INFO DERIVATIVE "mc9s12c32"

#include "main_asm.h" /* interface to the assembly module */
#include "SCI.H"        /* user defined macros */
#define STRING_MAX 10  

//Definition of Variables
//Constants
char newline[] = {13,10,0};
unsigned char data_direction = 0x01;

//Variable Storage
char store_string[STRING_MAX];
char command_on[8] = "LED_on";
char command_off[8] = "LED_off";
int flag, i;

void main(void) {
  //Initialize DDRM
  DDRM = data_direction;
  PTM = 0x01;  
  //Initialize Baud Rate to 9600
  SCI_Init(9600);

  while(1){
    
    //Reset Flag
    flag = 0;
    
    //Output "Enter Command" String
    SCI_OutString("Enter Command");
    SCI_OutString(newline);
  
    //Store Input String
    SCI_InString(store_string,STRING_MAX);
    SCI_OutString(newline);
  
    for(i=5; i<7; i++){
      if(((store_string[i] != command_on[i]) && (store_string[i] != command_off[i])) || (store_string[7] != 0)) {
        flag = 1;
        break;
      }
    } 
    
    if(flag == 1) {
      SCI_OutString("Error: Command Invalid");
      SCI_OutString(newline);
    } 
    else if(store_string[5] == command_on[5]) {
      SCI_OutString("Turning LED on.");
      SCI_OutString(newline);
      PTM = 0x00;
    }    
    else if(store_string[5] == command_off[5]) {
      SCI_OutString("Turning LED off.");
      SCI_OutString(newline);
      PTM = 0x01;
    } 
    
    //clear string array
    for(i=0;i<STRING_MAX;i++){
      store_string[i] = 0;
    }
  }
}

  