/*
 * initialiseProject.c
 *
 *  Created on: 1/03/2018
 *      Author: Ethan
 */

//Tiva HEADERS
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "inc/hw_memmap.h"
#include "driverlib/gpio.h"
#include "driverlib/sysctl.h"
#include "driverlib/uart.h"
#include "driverlib/pin_map.h"

void writeCharToUart0(char c)
{
	while (!UARTSpaceAvail(UART0_BASE)); //wait till Transmitter is not full
	UARTCharPutNonBlocking(UART0_BASE, c); //write to UART0
}


void writeStringToUart0(char* str)   //write a string to Uart0
{
	int i;
    for (i = 0; i < strlen(str); i++)
    	writeCharToUart0(str[i]);
}

void writeCharToUart5(char c)
{
	while (!UARTSpaceAvail(UART5_BASE)); //wait till Transmitter is not full
	UARTCharPutNonBlocking(UART5_BASE, c); //write to UART5
}


void writeStringToUart5(char* str)
{
	int i;
    for (i = 0; i < strlen(str); i++)
    	writeCharToUart5(str[i]);
}

//void Uart5InterruptIsrT(char txChar) //this interrupt routine is to transmit data over bluetooth
//{
//	UARTIntClear(UART5_BASE, UART_INT_TX);
//
//	if (!UARTCharsAvail(UART5_BASE))
//		txChar = UARTCharGetNonBlocking(UART5_BASE);
//
//}

void printInstructions(char *instructCodes[], char *instructDef[], int numInstructions) {
	int i;
	for (i = 0; i < numInstructions; i++) {
		writeStringToUart5(instructCodes[i]);
		writeStringToUart5("\t\t--->\t\t");
		writeStringToUart5(instructDef[i]);
		writeStringToUart5("\n\r");
	}
}

void swap(char *x, char* y) {
	char t = *x; *x = *y; *y = t;
}

void reverse(char str[], int length)
{
    int start = 0;
    int end = length -1;
    while (start < end)
    {
        swap((str+start), (str+end));
        start++;
        end--;
    }
}

char* itoa(int num, char* str, int base)
{
    int i = 0;
    bool isNegative = false;

    /* Handle 0 explicitely, otherwise empty string is printed for 0 */
    if (num == 0)
    {
        str[i++] = '0';
        str[i] = '\0';
        return str;
    }

    // In standard itoa(), negative numbers are handled only with
    // base 10. Otherwise numbers are considered unsigned.
    if (num < 0 && base == 10)
    {
        isNegative = true;
        num = -num;
    }

    // Process individual digits
    while (num != 0)
    {
        int rem = num % base;
        str[i++] = (rem > 9)? (rem-10) + 'a' : rem + '0';
        num = num/base;
    }

    // If number is negative, append '-'
    if (isNegative)
        str[i++] = '-';

    str[i] = '\0'; // Append string terminator

    // Reverse the string
    reverse(str, i);

    return str;
}
