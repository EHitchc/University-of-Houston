#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <math.h>
#define WAV_HEADER_SIZE 44
#define AMPLITUDE 1.0
#define FREQUENCY 1.2
#define FACTOR 0.7

static const double PI = 3.1415926535897932384626433;

int checkExtension(char* string)
{
    char store_ext[5];
    int file_length = strlen(string), i;
    for(i = 0; i < 4; i++)
        store_ext[i] = string[file_length-(5-i)];
    for(i=0; i<4; i++)
        store_ext[i] = tolower(store_ext[i]);

    if(strstr(store_ext,".wav")==0)
        return 1;
    else
        return 0;
}

main()
{
    char* header = malloc(WAV_HEADER_SIZE);
    int flag = 1;
    FILE* fin = NULL;
    char filepath[512];
    printf("Enter the path and file name of a .wav file (including the extension):\n");

    do
    {
        if(fin == NULL && flag != 1)
        {
            printf("File not found. Please include path, name and file extension.\n");
        }

        fgets(filepath, sizeof(filepath), stdin);
        if(strlen(filepath) <= 4 )
        {
            printf("File name not long enough or did not include file extension. Please include path, name and file extension.\n");
            flag = 1;
        }
        else
        {
            if((flag = checkExtension(filepath)) == 1)
                printf("File extension was not .wav. Please include path, name and file extension.\n");
            else
            {
                filepath[strcspn(filepath, "\n")] = 0;
                fin = fopen(filepath, "rb");
                flag = 0;

                if(fin != NULL)
                {
                    fread(header, 1, WAV_HEADER_SIZE, fin);
                    unsigned short int* bitspersample = (unsigned short int*)(header + 34);

                    if(*bitspersample != 16)
                    {
                        printf("File did not have the right characteristics. Please include path, name and file extension to a valid file.\n");
                        flag = 1;
                    }
                }
            }
        }
    } while(fin == NULL || flag == 1);

    char outname[512];
    printf("What do you want to call your output file? Do not include .wav extension\n");
    fgets(outname, sizeof(outname), stdin);
    outname[strcspn(outname, "\n")] = 0;
    strcat(outname, ".wav");

    FILE* fout = fopen(outname, "wb");

    //write full header
    fwrite(header, 1, WAV_HEADER_SIZE, fout);

    //adjust numchannels
    fseek(fout, 22, SEEK_SET);
    fputc(2, fout);

    //adjust subchunk2size
    fseek(fout, 40, SEEK_SET);
    unsigned int* subchunk2size = (unsigned int*)(header+40);
    *subchunk2size = *subchunk2size << 1;
    fwrite(subchunk2size, 4, 1, fout);

    //adjust chunksize
    fseek(fout, 4, SEEK_SET);
    *subchunk2size = *subchunk2size + 36;
    fwrite(subchunk2size, 4, 1, fout);

    //adjust byterate
    fseek(fout, 28, SEEK_SET);
    unsigned int* byterate = (unsigned int*)(header + 28);
    *byterate = *byterate << 1;
    fwrite(byterate, 4, 1, fout);

    //adjust blockalign
    fseek(fout, 32, SEEK_SET);
    unsigned short int* blockalign = (unsigned short int*)(header + 32);
    *blockalign = *blockalign << 1;
    fwrite(blockalign, 2, 1, fout);

    unsigned int* samplerate = (unsigned int*)(header + 24);
    int memorysize = (*subchunk2size - 36)/2;

    float A = AMPLITUDE, f_0 = FREQUENCY, factor = FACTOR;

    short int* data = malloc(memorysize);
    short int left_samp, right_samp;
    int n = 0;
    fread(data, memorysize, 1, fin);

    fseek(fout, 44, SEEK_SET);
    while(n < (memorysize/2))
    {
        int delay = n - (int)(44*(1+A*cos(((2*PI)*f_0*n)/(*samplerate))));
        delay = delay < 0 ? n : delay;
        left_samp = (short int)((data[n] + (factor)* data[delay])/(1.0+factor));
        fwrite(&left_samp, 2, 1, fout);

        delay = n - (int)(44*(1+A*sin(((2*PI)*f_0*n)/(*samplerate))));
        delay = delay < 0 ? n : delay;
        right_samp = (short int)((data[n] + (factor)* data[delay])/(1.0+factor));
        fwrite(&right_samp, 2, 1, fout);

        n++;
    }
}
