#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define BASE 256
int convertBase(int number, int* store, int base);

main()
{
    int counter = 1;
    int* countptr = &counter;
    srand((unsigned int)time(NULL));

    //Initialize dimensions
    //horizontal width
    char *p, input_hold_h[100];
    int horizontal_width;
    printf("What dimensions do you want the output to be?\nHorizontal width (limit 512): ");

    while(fgets(input_hold_h, sizeof(input_hold_h), stdin))
    {
        horizontal_width = strtol(input_hold_h, &p, 10);
        if(p == input_hold_h || *p != '\n' || (!(horizontal_width > 0 && horizontal_width <=512)))
        {
            printf("Invalid value for width, please enter value between 1 and 512: ");
        }
        else break;
    }

    //vertical height
    char input_hold_v[100];
    int vertical_height;
    printf("Vertical height (limit 512): ");

    while(fgets(input_hold_v, sizeof(input_hold_v), stdin))
    {
        vertical_height = strtol(input_hold_v, &p, 10);
        if(p == input_hold_v || *p != '\n' || (!(vertical_height > 0 && vertical_height <=512)))
        {
            printf("Invalid value for height, please enter value between 1 and 512: ");
        }
        else break;
    }

    //Initialize output name
    FILE* fout;
    char fileInName[256];
    printf("\nWhat do you want the output to be called? (Include .bmp extension): ");
    scanf("%s", fileInName);
    fout = fopen(fileInName, "wb");

    int sizeImage, zero_buffer, y, z;
    if( (zero_buffer = (3*horizontal_width)%4) != 0)
    {
        y = 4*horizontal_width;
        sizeImage = y*vertical_height;
        z = y - (4-zero_buffer);
    }
    else
    {
        y = 3*horizontal_width;
        sizeImage = y*vertical_height;
        z = y;
    }

    //convert file size to base-256
    int sbit[4] = {0};
    convertBase(sizeImage + 54, sbit, BASE);

    //Write File Header
    unsigned char bmpfh[14] = {[0] = 66, [1] = 77, [2] = sbit[0], [3] = sbit[1], [4] = sbit[2], [5] = sbit[3], [10] = 54};
    fwrite(bmpfh, 1, sizeof(bmpfh), fout);

    //Convert image size to base-256
    int vbit[4] = {0}, hbit[4] = {0}, ibit[4] = {0};
    convertBase(horizontal_width, hbit, BASE);
    convertBase(vertical_height, vbit, BASE);
    convertBase(sizeImage, ibit, BASE);

    //Write Info Header
    unsigned char bmpih[40] = {[0] = 40, [4] = hbit[0], [5] = hbit[1], [6] = hbit[2], [7] = hbit[3], [8] = vbit[0], [9] = vbit[1], [10] = vbit[2], [11] = vbit[3], [12] = 1, [14] = 24, [20] = ibit[0], [21] = ibit[1], [22] = ibit[2], [23] = ibit[3]};
    fwrite(bmpih, 1, sizeof(bmpih), fout);

    //begin writing random bits
    int w, x;
    unsigned char bmppixel;
    for(w=0; w < vertical_height; w++)
    {
        for(x=0; x < z; x++)
        {
            bmppixel = (int)(((float)rand()/RAND_MAX)*255.9999);
            fwrite(&bmppixel, 1, sizeof(bmppixel), fout);
        }
        while(x < y)
        {
            fwrite("0", 1, 1, fout);
            x++;
        }
    }
    return 0;
}

int convertBase(int number, int* store, int base)
{
    int index = 0, remainder;
    while ( number != 0 )
    {
        remainder = number%base;
        number = (number - remainder)/base;
        store[index] = remainder;
        index++;
    }
    return 0;
}

