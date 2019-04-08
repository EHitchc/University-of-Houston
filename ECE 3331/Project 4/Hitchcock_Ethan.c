#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    //Encode or Decode
    char what_do[255];
    while(strcmp(what_do, "d") && strcmp(what_do, "e"))
    {
        printf("Do you want to encode a message or decode a message?\nEnter e to encode or d to decode:  ");
        scanf("%s", what_do);
    }

    //File input
    char file_name_in[255], file_name_out[255];
    printf("Input file name including extension (e.g. \".txt\"): ");
    scanf(" %s", file_name_in);
    FILE* fin = fopen(file_name_in, "r");
    while(fin == NULL)
    {
        printf("File either did not exist or file name was incorrect.\nPlease input valid file name including extension: ");
        scanf(" %s", file_name_in);
        fin = fopen(file_name_in, "r");
    }

    printf("\nOutput file name including extension (e.g. \".txt\"): ");
    scanf(" %s", file_name_out);
    FILE* fout = fopen(file_name_out, "w");
    while(fout == NULL)
    {
        printf("Error creating output file.\nPlease input valid file name including extension: ");
        scanf(" %s", file_name_out);
        fout = fopen(file_name_out, "w");
    }

    //for encode
    if(!strcmp(what_do, "e"))
    {
        //process
        int hold, operate;
        while((hold=fgetc(fin)) != EOF)
        {
            if(hold>96 && hold<123)
                operate = 1;
            else if(hold>47 && hold<58)
                operate = 2;
            else if(hold == 32)
                operate = 3;
            else if(hold == 46)
                operate = 4;
            else if(hold == 10)
                operate = 5;
            else
                operate = 0;
            switch(operate)
            {
                case 0:
                    break;
                case 1:
                    hold = 33 + (hold-97);
                    fputc(hold, fout);
                    break;
                case 2:
                    hold = 59 + (hold-48);
                    fputc(hold, fout);
                    break;
                case 3:
                    hold = 69;
                    fputc(hold,fout);
                    break;
                case 4:
                    hold = 70;
                    fputc(hold,fout);
                    break;
                case 5:
                    hold = 71;
                    fputc(hold,fout);
                    break;
            }
        }
    }

    //for decode
    else if(!strcmp(what_do, "d"))
    {
        //process
        int hold, operate;
        while((hold=fgetc(fin)) != EOF)
        {
            if(hold>32 && hold<59)
                operate = 1;
            else if(hold>58 && hold<69)
                operate = 2;
            else if(hold == 69)
                operate = 3;
            else if(hold == 70)
                operate = 4;
            else if(hold == 71)
                operate = 5;
            else
                operate = 0;
            switch(operate)
            {
                case 0:
                    break;
                case 1:
                    hold = 97 + (hold-33);
                    fputc(hold, fout);
                    break;
                case 2:
                    hold = 48 + (hold-59);
                    fputc(hold, fout);
                    break;
                case 3:
                    hold = 32;
                    fputc(hold,fout);
                    break;
                case 4:
                    hold = 46;
                    fputc(hold,fout);
                    break;
                case 5:
                    hold = 10;
                    fputc(hold,fout);
                    break;
            }
        }
    }

    fclose(fin);
    fclose(fout);
    return 0;
}
