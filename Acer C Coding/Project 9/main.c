#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define WAV_HEADER_SIZE 44

int checkExtension(char* string);

main()
{
    int i, flag = 1;
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
                fin = fopen(filepath, "rb");
                flag = 0;
            }
        }
    } while(fin == NULL || flag == 1);

    char *header = malloc(WAV_HEADER_SIZE);
    if(!header)
        return EXIT_FAILURE;
    fread(header, 1, WAV_HEADER_SIZE, fin);

    char* chunkid;
    unsigned int* chunksize;
    char* format;
    char* subchunk1id;
    unsigned int* subchunk1size;
    unsigned short int* audioformat;
    unsigned short int* numchannels;
    unsigned int* samplerate;
    unsigned int* byterate;
    unsigned short int* blockalign;
    unsigned short int* bitspersample;
    char* subchunk2id;
    unsigned int* subchunk2size;

    chunkid = header;
    chunksize = (unsigned int*)(header + 4);
    format = header + 8;
    subchunk1id = header + 12;
    subchunk1size = (unsigned int*)(header + 16);
    audioformat = (unsigned short int*)(header + 20);
    numchannels = (unsigned short int*)(header + 22);
    samplerate = (unsigned int*)(header + 24);
    byterate = (unsigned int*)(header + 28);
    blockalign = (unsigned short int*)(header + 32);
    bitspersample = (unsigned short int*)(header + 34);
    subchunk2id = header + 36;
    subchunk2size = (unsigned int*)(header + 40);

    printf("\n");
    for(i=0;i<4;i++)
        printf("%c", *(chunkid+i));
    printf("\n%u\n", *chunksize);
    for(i=0;i<4;i++)
        printf("%c", *(format+i));
    printf("\n");
    for(i=0;i<4;i++)
        printf("%c", *(subchunk1id+i));
    printf("\n%u", *subchunk1size);
    printf("\n%u", *audioformat);
    printf("\n%u", *numchannels);
    printf("\n%u", *samplerate);
    printf("\n%u", *byterate);
    printf("\n%u", *blockalign);
    printf("\n%u", *bitspersample);
    printf("\n");
    for(i=0;i<4;i++)
        printf("%c", *(subchunk2id+i));
    printf("\n%u\n", *subchunk2size);

    fclose(fin);

    return 0;
}

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
