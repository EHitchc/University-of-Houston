#include <stdio.h>
#include <stdlib.h>

void writeToFile(unsigned char *x, int n, FILE* fin);

int main(void)
{
    unsigned char bmpfh[14] = {66, 77, 54, 0, 3, 0, 0, 0, 0, 0, 54, 0, 0, 0};
    FILE* fin = fopen("red.bmp", "w");
    writeToFile(bmpfh, 14, fin);

    unsigned char bmpih[40] = {0};
    bmpih[0] = 40;
    bmpih[5] = 1;
    bmpih[9] = 1;
    bmpih[12] = 1;
    bmpih[14] = 24;
    bmpih[22] = 3;
    writeToFile(bmpih, 40, fin);

    unsigned char bmpgrad[768] = {0};
    int i;
    for(i=2;i<768;i+=3)
    {
            bmpgrad[i] = (i-2)/3;
    }
    bmpgrad[32] = 11;
    for(i=0;i<256;i++)
        writeToFile(bmpgrad, 768, fin);

    return 0;
}

void writeToFile(unsigned char *x, int n, FILE* y)
{
    int i;
    for(i=0;i<n;i++)
        fprintf(y, "%c", x[i]);
}
