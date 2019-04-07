#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define BASE 256
unsigned char createPixel(int i);
int convertBase(int number, int* store, int base);

main()
{
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
    fout = fopen(fileInName, "w");

    int sizeImage, sizeImageFile;
    if((3*horizontal_width)%4 != 0)
        sizeImage = 4*horizontal_width*vertical_height;
    else
        sizeImage = 3*horizontal_width*vertical_height;
    sizeImageFile = 54 + sizeImage;

    //convert file size to base-256
    int sbit[4] = {0};
    convertBase(sizeImageFile, sbit, BASE);

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
    fwrite(bmpih, 1, sizeof(bmpih), fout)

    int y, z;
    if((3*horizontal_width)%4 == 0)
    {
        y = 3*horizontal_width;
        z = y;
    }
    else if((3*horizontal_width)%4 == 1)
    {
        y = 4*horizontal_width;
        z = y - 3;
    }
    else if((3*horizontal_width)%4 == 2)
    {
        y = 4*horizontal_width;
        z = y - 2;
    }
    else if((3*horizontal_width)%4 == 3)
    {
        y = 4*horizontal_width;
        z = y - 1;
    }

    //begin writing random bits
    int w, x, randhold;
    unsigned char bmppixel;
    for(w=0; w < vertical_height; w++)
    {
        for(x=0; x < z; x++)
        {
            randhold = (rand()%255);
            bmppixel = createPixel(randhold);
            fprintf(fout, "%c", bmppixel);
        }
        while(x < y)
        {
            fprintf(fout, "%c", '0');
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

unsigned char createPixel(int i)
{
    unsigned char x;
    if(i == 10)
    {
        x = 11;
    }
    else
    {
        x = i;
    }
    return x;
}
