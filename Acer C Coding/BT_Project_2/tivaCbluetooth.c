//Tiva -------- Bluetooth Module
//PE4   ------  TXD
//PE5   ------  RXD
//3.3v  ------  Vc
//gnd   ------  gnd

//Tiva -------- Distance Sensor
//PE1   ------  Front Facing IR
//PE2   ------  Side Facing IR

//BIOS HEADERS
#include <xdc/std.h>  						//mandatory - have to include first, for BIOS types
#include <ti/sysbios/BIOS.h> 				//mandatory - if you call APIs like BIOS_start()
#include <xdc/runtime/Log.h>				//needed for any Log_info() call
#include <xdc/cfg/global.h> 				//header file for statically defined objects/handles

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
#include "driverlib/pwm.h"

//Custom Function HEADERS
#include "initialiseProject.h"
#include "uartFunctions.h"
#include "adcFunctions.h"

//GLOBALS
char rxChar[11];
char txChar;
uint8_t  timeron=60;
uint16_t count=0;
char countstr[10];
uint8_t index=0;
uint32_t adcDistanceSample[4];
char adcDistanceString[5];

static char *instructCodes[] = {
	"off",
	"red",
	"green",
	"blue",
	"distance"
};

static char *instructDef[] = {
	"Turn off LED",
	"Turn on red LED",
	"Turn on green LED",
	"Turn on blue LED",
	"Sample IR distance sensors"
};

static int numInstructions = sizeof(instructCodes)/sizeof(instructCodes[0]);

void UART5_ISR()
{
	UARTIntClear(UART5_BASE, UART_INT_RX);

	Swi_post(UART5_RX_Swi);
}

void Uart5InterruptIsrR()//this interrupt routine is for receiving data from bluetooth
{
	if(UARTCharsAvail(UART5_BASE) && strlen(rxChar) < 10){
		rxChar[index] = UARTCharGetNonBlocking(UART5_BASE);
		writeCharToUart5(rxChar[index]);
	}

	index++;

	if (strlen(rxChar) >= 10){
		writeStringToUart5("\n\r\tCommand exceeded character limit. Please use 'help' to view valid commands\n\r");
		index = 0;
	}

	if(rxChar[index-1]==13)
	{
		rxChar[index-1]='\0';
		if(strcmp(rxChar,"off")==0)
			GPIOPinWrite(GPIO_PORTF_BASE, (GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3), 0);
		else if(strcmp(rxChar,"red")==0)
			GPIOPinWrite(GPIO_PORTF_BASE, (GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3), GPIO_PIN_1);
		else if(strcmp(rxChar,"blue")==0)
			GPIOPinWrite(GPIO_PORTF_BASE, (GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3), GPIO_PIN_2);
		else if(strcmp(rxChar,"green")==0)
			GPIOPinWrite(GPIO_PORTF_BASE, (GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3), GPIO_PIN_3);
		else if(strcmp(rxChar,"help")==0) {
			writeStringToUart5("\n\r\tInstruction Codes\n\r");
			printInstructions(instructCodes, instructDef, numInstructions);
		}
		else if(strcmp(rxChar,"distance")==0) {
			readDistance(adcDistanceSample);

			itoa(adcDistanceSample[0], adcDistanceString, 10);
			writeStringToUart5("\n\rFront Sensor Reading:\t");
			writeStringToUart5(adcDistanceString);
			writeStringToUart5("\n\r");

			itoa(adcDistanceSample[1], adcDistanceString, 10);
			writeStringToUart5("Side Sensor Reading:\t");
			writeStringToUart5(adcDistanceString);
			writeStringToUart5("\n\r");

		}
		else if(strcmp(rxChar,"pwmd")==0) {
			 //Set PWM duty-50% (Period /2)
			 PWMPulseWidthSet(PWM0_BASE, PWM_OUT_0,100);
			 PWMPulseWidthSet(PWM0_BASE, PWM_OUT_1,100);

			 // Enable the PWM generator
			 PWMGenEnable(PWM0_BASE, PWM_GEN_0);

			 // Turn on the Output pins
			 PWMOutputState(PWM0_BASE, PWM_OUT_0_BIT | PWM_OUT_1_BIT, true);
		}
		else if(strcmp(rxChar,"pwmd")==0) {
			 // Disable the PWM generator
			 PWMGenDisable(PWM0_BASE, PWM_GEN_0);

			 // Turn off the Output pins
			 PWMOutputState(PWM0_BASE, PWM_OUT_0_BIT | PWM_OUT_1_BIT, false);
		}
		else {
			writeStringToUart5("\n\r\tCommand Not Recognised.");
		}
		index=0;
		writeStringToUart5("\n\r");
	}
}

int main(void)
{
    setUp();
    BIOS_start();
}
