// filename  ******************* PWM.H **************************
// Ethan Hitchcock, Audrey Wang 4/12/17

// standard ASCII symbols 
#define CR   0x0D
#define LF   0x0A
#define BS   0x08
#define ESC  0x1B
#define SP   0x20       
#define DEL  0x7F
 
//--------------------------start_PWM--------------------------
void start_PWM(void);

//---------------------------stop_PWM--------------------------
void stop_PWM(void);

//-----------------------set_Pulse_Width------------------------
void set_Pulse_Width(unsigned short us);

//----------------------------init_PWM--------------------------
void init_PWM(void);

//----------------------------PWM_ISR---------------------------
void interrupt 13 PWM_ISR(void);

