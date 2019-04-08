// filename  ******************* SCI.H **************************
// Ethan Hitchcock, Audrey Wang 4/12/17

// Resolution for timer measurements is 500ns

// standard ASCII symbols 
#define CR   0x0D
#define LF   0x0A
#define BS   0x08
#define ESC  0x1B
#define SP   0x20       
#define DEL  0x7F
 
//-------------------Distance_thread_init------------------------
void initDistanceThread(void);

//--------------------Start_Read_Distance------------------------
void startDistanceReading(void);

//-------------------distance_reading_ISR------------------------
void interrupt 8 distanceReading_ISR(void);

//--------------------Stop_Read_Distance------------------------
void stopDistanceReading(void);
