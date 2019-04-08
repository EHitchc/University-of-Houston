#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    typedef struct bitmapfileheader {
        unsigned short int type;
        unsigned int size_fh;
        unsigned short int reserved1, reserved2;
        unsigned int offset;
    } FILEHEADER;

    typedef struct bitmapinfoheader {
        unsigned int size_ih;
        int width, height;
        unsigned short int planes;
        unsigned short int bits;
        unsigned int compression;
        unsigned int imagesize;
        int xresolution, yresolution;
        unsigned int ncolours;
        unsigned int importantcolours;
    } INFOHEADER;

    typedef struct header {
        FILEHEADER fh;
        INFOHEADER ih;
    } HEADER;

    HEADER bmph1, bmph2;

    FILE *image1, *image2, *image3;
    image1 = fopen("image1_393x257.bmp", "rb");
    image2 = fopen("image2_393x257.bmp", "rb");

    image3 = fopen("image3_393x257.bmp", "wb");

    if( image1 == NULL || image2 == NULL)
    {
        printf("Either image 1 or image 2 could not be opened. Program now terminating");
        return EXIT_FAILURE;
    }

    if(image3 == NULL)
    {
        printf("\n Program unable to create a new bmp file. Program now terminating.");
        return EXIT_FAILURE;
    }

    fread(&bmph1, 2, 1, image1);
    fread(&bmph1.fh.size_fh, 52, 1, image1);

    printf("bmph1:\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n\n", bmph1.fh.type, bmph1.fh.size_fh, bmph1.fh.reserved1, bmph1.fh.reserved2, bmph1.fh.offset, bmph1.ih.size_ih, bmph1.ih.width, bmph1.ih.height, bmph1.ih.planes, bmph1.ih.bits, bmph1.ih.compression, bmph1.ih.imagesize, bmph1.ih.xresolution, bmph1.ih.yresolution, bmph1.ih.ncolours, bmph1.ih.importantcolours);

    fread(&bmph2, 2, 1, image2);
    fread(&bmph2.fh.size_fh, 52, 1, image2);

    printf("bmph2:\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n\n", bmph2.fh.type, bmph2.fh.size_fh, bmph2.fh.reserved1, bmph2.fh.reserved2, bmph2.fh.offset, bmph2.ih.size_ih, bmph2.ih.width, bmph2.ih.height, bmph2.ih.planes, bmph2.ih.bits, bmph2.ih.compression, bmph2.ih.imagesize, bmph2.ih.xresolution, bmph2.ih.yresolution, bmph2.ih.ncolours, bmph2.ih.importantcolours);

    if( bmph1.ih.width != bmph2.ih.width || bmph1.ih.height != bmph2.ih.height ) {
        printf("The files are not of the same dimensions. Program now terminating");
        return EXIT_FAILURE;
    }

    float scale;
    printf("Enter floating point scale between 0 and 1: ");
    scanf("%f", &scale);
    while(scale > 1 || scale < 0){
        printf("\nFloating point value must be between 0 and 1. Please enter valid scale value: ");
        scanf("%f", &scale);
    }


    fwrite(&bmph1, 2, 1, image3);
    fwrite(&bmph1.fh.size_fh, 52, 1, image3);
    unsigned int i;
    unsigned char pixel;
    for(i = 0; i < bmph1.ih.imagesize; i++){
        pixel = scale*fgetc(image1) + (1-scale)*fgetc(image2);
        fwrite(&pixel, 1, 1, image3);
    }

    return EXIT_SUCCESS;
}
