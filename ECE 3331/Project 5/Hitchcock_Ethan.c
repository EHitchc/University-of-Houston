#include <stdio.h>
#include <stdlib.h>
void print_morse(int c);

int main(void)
{
    //prompt
    printf("Enter a message to be encoded into Morse code:\n");

    //begin loop
    int c = 0;
    while((c = getchar()) != '\n')
    {
        //convert lowercase to uppercase
        if(c <= 'z' && c >= 'a')
            c = c - 32;

        print_morse(c);
    }
    return 0;
}

void print_morse(int c)
{
    //output appropriate code
    switch(c)
    {
        case 'A':
            printf(". -   ");
            break;
        case 'B':
            printf("- . . .   ");
            break;
        case 'C':
            printf("- . - .   ");
            break;
        case 'D':
            printf("- . .   ");
            break;
        case 'E':
            printf(".   ");
            break;
        case 'F':
            printf(". . - .   ");
            break;
        case 'G':
            printf("- - .   ");
            break;
        case 'H':
            printf(". . . .   ");
            break;
        case 'I':
            printf(". .   ");
            break;
        case 'J':
            printf(". - - -   ");
            break;
        case 'K':
            printf("- . -   ");
            break;
        case 'L':
            printf(". - . .   ");
            break;
        case 'M':
            printf("- -   ");
            break;
        case 'N':
            printf("- .   ");
            break;
        case 'O':
            printf("- - -   ");
            break;
        case 'P':
            printf(". - - .   ");
            break;
        case 'Q':
            printf("- - . -   ");
            break;
        case 'R':
            printf(". - .   ");
            break;
        case 'S':
            printf(". . .   ");
            break;
        case 'T':
            printf("-   ");
            break;
        case 'U':
            printf(". . -   ");
            break;
        case 'V':
            printf(". . . -   ");
            break;
        case 'W':
            printf(". - -   ");
            break;
        case 'X':
            printf("- . . -   ");
            break;
        case 'Y':
            printf("- . - -   ");
            break;
        case 'Z':
            printf("- - . .   ");
            break;
        case '1':
            printf(". - - - -   ");
            break;
        case '2':
            printf(". . - - -   ");
            break;
        case '3':
            printf(". . . - -   ");
            break;
        case '4':
            printf(". . . . -   ");
            break;
        case '5':
            printf(". . . . .   ");
            break;
        case '6':
            printf("- . . . .   ");
            break;
        case '7':
            printf("- - . . .   ");
            break;
        case '8':
            printf("- - - . .   ");
            break;
        case '9':
            printf("- - - - .   ");
            break;
        case '0':
            printf("- - - - -   ");
            break;
        case '.':
            printf(". - . - . -   ");
            break;
        case ',':
            printf("- - . . - -   ");
            break;
        case ' ':
            printf("    ");
            break;
    }
}
