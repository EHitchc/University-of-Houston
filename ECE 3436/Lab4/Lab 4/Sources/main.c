#include <hidef.h>      /* common defines and macros */
#include <mc9s12c32.h>     /* derivative information */
#include <string.h>
#pragma LINK_INFO DERIVATIVE "mc9s12c32"

#include "main_asm.h" /* interface to the assembly module */
#include "SCI.H"        /* user defined macros */
  

//Definition of Variables
//Constants
char prompt[] = "Enter Command";
char command_on[] = "LED_on";
char command_off[] = "LED_off";
char command_invalid[] = "Error: Command Invalid";

unsigned char data_direction = 0x01;

//Variable Storage
char store_string[9];
int matches = 1;

void main(void) {
  //Initialize DDRM
  DDRM = data_direction;
  //PTM = data_direction;
  
  //Initialize Baud Rate to 9600
  SCI_Init(9600);

  while(1){
    
    //Output "Enter Command" String
    SCI_OutString(prompt);
  
    //Store Input String
    SCI_InString(store_string,8);
  
    if((strcmp(store_string, command_on) || strcmp(store_string, command_off)) != 0)
      SCI_OutString(command_invalid);
    else if((strcmp(store_string, command_on) == 0)) {
      SCI_OutString("Turning LED on.");
      PTM = 0;
    } 
    else {
      SCI_OutString("Turning LED off.");
      PTM = 1;
    }  
  }

  for(;;) {} /* wait forever */
  /* please make sure that you never leave this function */
}
