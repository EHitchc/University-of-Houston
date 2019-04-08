#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define SAMPLERATE 44100
#define NUMCHANNELS 1
#define BITSPERSAMPLE 16
#define AMPLITUDE 32700.0
#define SONG_KEYS 25
struct wav_header {
    char chunkid[4];
    unsigned int chunksize;
    char format[4];
    char subchunk1id[4];
    unsigned int subchunk1size;
    unsigned short int audioformat;
    unsigned short int numchannels;
    unsigned int samplerate;
    unsigned int byterate;
    unsigned short int blockalign;
    unsigned short int bitspersample;
    char subchunk2id[4];
    unsigned int subchunk2size;
};

static const double PI = 3.1415926535897932384626433;

main()
{
    int i, j;
    unsigned int subchunk2size_file = 0;
    double note_freqs[] = {440.00, 466.16, 493.88, 523.25, 554.37, 587.33, 622.25, 659.25, 698.46, 739.99, 783.99, 830.61, 880.0, 932.33, 987.77, 1046.50, 1109.73, 1174.66, 1244.51, 1318.51, 1396.91, 1479.98, 1567.98, 1661.22};
    struct wav_header HeaderOut = {
        .chunkid[0] = 'R',
        .chunkid[1] = 'I',
        .chunkid[2] = 'F',
        .chunkid[3] = 'F',
        .chunksize = 0,
        .format[0] = 'W',
        .format[1] = 'A',
        .format[2] = 'V',
        .format[3] = 'E',
        .subchunk1id[0] = 'f',
        .subchunk1id[1] = 'm',
        .subchunk1id[2] = 't',
        .subchunk1id[3] = ' ',
        .subchunk1size = 16,
        .audioformat = 1,
        .numchannels = NUMCHANNELS,
        .samplerate = SAMPLERATE,
        .byterate = SAMPLERATE*NUMCHANNELS*BITSPERSAMPLE/8,
        .blockalign = NUMCHANNELS*BITSPERSAMPLE/8,
        .bitspersample = BITSPERSAMPLE,
        .subchunk2id[0] = 'd',
        .subchunk2id[1] = 'a',
        .subchunk2id[2] = 't',
        .subchunk2id[3] = 'a',
        .subchunk2size = 0,
    };

    FILE* fin = fopen("song.wav", "wb");

    if(fin == NULL)
    {
        printf("File was unable to be created. Program will now terminate.");
        return EXIT_FAILURE;
    }

    short int **audio = malloc(SONG_KEYS * sizeof(short int*));
    for(i = 0; i < SONG_KEYS; i++)
    {
        audio[i] = malloc(SAMPLERATE/3*sizeof(short int));
    }

    for(i = 0; i < SONG_KEYS-1; i++)
    {
        for(j = 0; j < SAMPLERATE/3; j++)
        {
            audio[i][j] = AMPLITUDE*sin(j * note_freqs[i]* 2* PI/SAMPLERATE);
        }
    }

    for(j = 0; j < SAMPLERATE/3; j++)
    {
        audio[SONG_KEYS-1][j] = 0;
    }

    unsigned short int song[48] = {3,3,10,10,12,12,10,24,8,8,7,7,5,5,3,24,10,10,8,8,7,7,5,24,10,10,8,8,7,7,5,24,3,3,10,10,12,12,10,24,8,8,7,7,5,5,3,24};

    fwrite(&HeaderOut, 1, sizeof(HeaderOut), fin);

    for(i = 0; i < 48; i++ )
    {
        fwrite(audio[song[i]], sizeof(short int), SAMPLERATE/3, fin);
        subchunk2size_file += SAMPLERATE/3 * sizeof(short int);
    }

    fseek(fin, 40, SEEK_SET);
    fwrite(&subchunk2size_file, sizeof(unsigned int), 1, fin);

    subchunk2size_file += 36;

    fseek(fin, 4, SEEK_SET);
    fwrite(&subchunk2size_file, sizeof(unsigned int), 1, fin);

    for(i = 0; i < SONG_KEYS; i++)
        free(audio[i]);
    free(audio);
    fclose(fin);

    return EXIT_SUCCESS;
}
