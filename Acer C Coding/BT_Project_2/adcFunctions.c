/*
 * initialiseProject.c
 *
 *  Created on: 1/03/2018
 *      Author: Ethan
 */

#include <stdint.h>
#include <stdbool.h>
#include "inc/hw_memmap.h"
#include "inc/hw_types.h"
#include "driverlib/debug.h"
#include "driverlib/sysctl.h"
#include "driverlib/adc.h"
#include "driverlib/gpio.h"

void readDistance(uint32_t *distanceSample) {

	//trigger ADC conversion
	ADCProcessorTrigger(ADC0_BASE, 2);

	//wait for the conversion to complete
	while(!ADCIntStatus(ADC0_BASE, 2, false)) {}

	// read the ADC value from the ADC Sample Sequencer 2, distanceSample stores the value
	ADCSequenceDataGet(ADC0_BASE, 2, distanceSample);

	//clear ADC interrupt flag
	ADCIntClear(ADC0_BASE, 2);
}
