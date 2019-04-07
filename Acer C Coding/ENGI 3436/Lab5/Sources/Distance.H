// filename  ******************* SCI.H **************************
// Ethan Hitchcock, Audrey Wang 4/12/17

// standard ASCII symbols 
#define CR   0x0D
#define LF   0x0A
#define BS   0x08
#define ESC  0x1B
#define SP   0x20       
#define DEL  0x7F
 
//-------------------------Distance_init------------------------
void Distance_init(void);

//-------------------------Read_Distance------------------------
unsigned short Read_Distance(void);

