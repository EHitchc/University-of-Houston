#include <stdio.h>
#include <stdlib.h>
void createGradient(unsigned char* x, int i);

int main(int argc, char *argv[])
{
    //Write File Header
    unsigned char bmpfh[14] = {[0] = 66, [1] = 77, [2] = 54, [4] = 3, [10] = 54};
    FILE* fin = fopen("red.bmp", "w");
    fwrite(bmpfh, 1, sizeof(bmpfh), fin);

    //Write Info Header
    unsigned char bmpih[40] = {[0] = 40, [5] = 1, [9] = 1, [12] = 1, [14] = 24, [22] = 3,};
    fwrite(bmpih, 1, sizeof(bmpih), fin);

    //Create gradient of 1px height
    unsigned char bmpgrad[768] = {0};

    int i= argc > 1 ? strtol(argv[1],NULL, 10):1;
    createGradient(bmpgrad, i);

    if(argc > 2)
    {
        i= argc > 2 ? strtol(argv[2],NULL, 10):1;
        createGradient(bmpgrad, i);
    }

    if(argc > 3)
    {
        i= argc > 3 ? strtol(argv[3],NULL, 10):1;
        createGradient(bmpgrad, i);
    }

    //write gradient to file 256 times
    for(i=0;i<256;i++)
        fwrite(bmpgrad, 1, sizeof(bmpgrad), fin);

    //end
    return 0;
}

void createGradient(unsigned char* x, int i)
{
    int j = i;
    for(i;i<768;i+=3)
    {
            x[i] = (i-j)/3;
    }
    x[30+j] = 11;
}
