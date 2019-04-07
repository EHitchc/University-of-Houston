#include <hidef.h>      /* common defines and macros */
#include <mc9s12c32.h>     /* derivative information */
#pragma LINK_INFO DERIVATIVE "mc9s12c32"

#include "main_asm.h" /* interface to the assembly module */


void main(void) {
  /* put your own code here */
  EnableInterrupts;
  asm_main(); /* call the assembly function */

  for(;;) {} /* wait forever */
  /* please make sure that you never leave this function */
}
