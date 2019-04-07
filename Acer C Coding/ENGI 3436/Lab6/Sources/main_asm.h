#ifndef _MAIN_ASM_H
#define _MAIN_ASM_H

#ifdef __cplusplus
    extern "C" { /* our assembly functions have C calling convention */
#endif


void SCI_Init(int baudRate);
  /* interface to my assembly main function */

char SCI_InChar(void);

void SCI_OutChar(char);


#ifdef __cplusplus
    }
#endif

#endif /* _MAIN_ASM_H */
