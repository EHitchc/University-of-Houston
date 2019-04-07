/**************************************************************
     ECE 3436 - Lab 4 - Spring 2017
     Ethan Hitchcock and Audrey Wang - Lab Group 13A
Main written in C to turn LED on/off given a character command
**************************************************************/

#include <stdio.h>
#include <stdlib.h>

#define STRING_MAX 10

void main(void) {

    char store_string[STRING_MAX];
    char command_on[8] = "LED_on";
    char command_off[8] = "LED_off";
    int flag, i;

    while(1){

    //Reset Flag
    flag = 0;

    //Output "Enter Command" String
    printf("Enter Command\n");

    //Store Input String
    gets(store_string);

    for(i=5; i<7; i++){
      if(((store_string[i] != command_on[i]) && (store_string[i] != command_off[i])) || (store_string[7] != 0)) {
        flag = 1;
        break;
      }
    }

    if(flag == 1) {
      printf("Error: Command Invalid\n");
    }
    else if(store_string[5] == command_on[5]) {
      printf("Turning LED on.\n");
    }
    else if(store_string[5] == command_off[5]) {
      printf("Turning LED off.\n");
    }

    //clear string array
    for(i=0;i<STRING_MAX;i++){
      store_string[i] = 0;
    }
  }
}

