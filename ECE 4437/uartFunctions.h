/*
 * uartFunctions.h
 *
 *  Created on: 1/03/2018
 *      Author: Ethan
 */

#ifndef UARTFUNCTIONS_H_
#define UARTFUNCTIONS_H_

void writeCharToUart0();
void writeStringToUart0();
void printInstructions();
void writeCharToUart5();
void writeStringToUart5();
void Uart5InterruptIsrT();
char* itoa();
void reverse();
void swap();

#endif /* UARTFUNCTIONS_H_ */
