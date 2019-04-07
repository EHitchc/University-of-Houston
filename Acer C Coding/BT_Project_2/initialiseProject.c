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
#include "inc/hw_types.h"
#include "inc/hw_gpio.h"
#include "driverlib/gpio.h"
#include "driverlib/sysctl.h"
#include "driverlib/adc.h"
#include "driverlib/uart.h"
#include "driverlib/pin_map.h"
#include "driverlib/pwm.h"
#include "uartFunctions.h"

void ConfigureOnboardLED() {

    //Enable GPIO Pins
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);                                //Enable PORTF for LED Pins
    GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3);   //R = PF1 (2), B = PF2 (4), G = PF3 (8)

    while(!SysCtlPeripheralReady(SYSCTL_PERIPH_GPIOF)) {}                       //Loop until PORTF ready
}

void ConfigureBlueTooth() {

    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOE);                                //Enable PORTE & UART5 for BT - R/T
    SysCtlPeripheralEnable(SYSCTL_PERIPH_UART5);
    GPIOPinConfigure(GPIO_PE4_U5RX);                                            //Enable PE4 for Receive (Transmit on BT)
    GPIOPinConfigure(GPIO_PE5_U5TX);                                            //Enable PE5 for Transmit (Receive on BT)
    GPIOPinTypeUART(GPIO_PORTE_BASE, (GPIO_PIN_4|GPIO_PIN_5));

    while(!SysCtlPeripheralReady(SYSCTL_PERIPH_GPIOE) && !SysCtlPeripheralReady(SYSCTL_PERIPH_UART5)) {} //Loop until peripherals ready

    UARTConfigSetExpClk(UART5_BASE, SysCtlClockGet(), 115200, (UART_CONFIG_WLEN_8 | UART_CONFIG_STOP_ONE | UART_CONFIG_PAR_NONE));

    UARTFIFODisable(UART5_BASE);

    writeStringToUart5("Bluetooth ");
    writeStringToUart5("Connection ");
    writeStringToUart5("Established");
    writeStringToUart5("\n\r");

    UARTIntEnable(UART5_BASE, UART_INT_RX);
}

void ConfigureSerialPC() {

    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);                                //Enable PORTA & UART0 for serial PC connection
    SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);
    GPIOPinConfigure(GPIO_PA0_U0RX);                                            //Enable PA0 for Receive
    GPIOPinConfigure(GPIO_PA1_U0TX);                                            //Enable PA1 for Transmit
    GPIOPinTypeUART(GPIO_PORTA_BASE, GPIO_PIN_0 | GPIO_PIN_1);

    UARTConfigSetExpClk(UART0_BASE, SysCtlClockGet(), 115200, (UART_CONFIG_WLEN_8 | UART_CONFIG_STOP_ONE | UART_CONFIG_PAR_NONE));

    UARTFIFODisable(UART0_BASE);
}

void ConfigureADC() {

	SysCtlPeripheralEnable(SYSCTL_PERIPH_ADC0);									//enable ADC0 peripheral
	while(!SysCtlPeripheralReady(SYSCTL_PERIPH_ADC0)) {}

	GPIOPinTypeADC(GPIO_PORTE_BASE, (GPIO_PIN_1|GPIO_PIN_2));

	ADCSequenceConfigure(ADC0_BASE, 2, ADC_TRIGGER_PROCESSOR, 0);				//enable ADC0 sample, sequencer 2

	//configure the interrupt flag and sample the AIN1 pin and AIN2
	ADCSequenceStepConfigure(ADC0_BASE, 2, 0, (ADC_CTL_CH1));
	ADCSequenceStepConfigure(ADC0_BASE, 2, 1, (ADC_CTL_CH2|ADC_CTL_IE|ADC_CTL_END));

	ADCSequenceEnable(ADC0_BASE, 2);											//enable ADC sequencer 2

	//clear ADC interrupt flag
	ADCIntClear(ADC0_BASE, 2);

}

void ConfigurePWM() {
	//Configure PWM Clock to match system
	SysCtlPWMClockSet(SYSCTL_PWMDIV_1);

	// Enable the peripherals used by this program.
	SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOB);
	SysCtlPeripheralEnable(SYSCTL_PERIPH_PWM0);  //The Tiva Launchpad has two modules (0 and 1). Module 0 covers the pins

	//Configure PB6 and PB7 Pins as PWM
	GPIOPinConfigure(GPIO_PB6_M0PWM0);
	GPIOPinConfigure(GPIO_PB7_M0PWM1);
	GPIOPinTypePWM(GPIO_PORTB_BASE, GPIO_PIN_6 | GPIO_PIN_7);

	//Configure PWM Options
	PWMGenConfigure(PWM0_BASE, PWM_GEN_0, PWM_GEN_MODE_DOWN | PWM_GEN_MODE_NO_SYNC);

	//Set the Period (expressed in clock ticks)
	PWMGenPeriodSet(PWM0_BASE, PWM_GEN_0, 320);
}

void setUp() {

	//setting system clock to run at 40MHZ
    SysCtlClockSet(SYSCTL_SYSDIV_5|SYSCTL_USE_PLL|SYSCTL_OSC_MAIN|SYSCTL_XTAL_16MHZ);

    ConfigureOnboardLED();

    ConfigureSerialPC();
    ConfigureBlueTooth();
    ConfigureADC();
    ConfigurePWM();
}
