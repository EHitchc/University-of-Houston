#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
/*
int main()
{
    FILE* fptr;

    char stock_price_shares[ 61 ];
    int i, count;

    fptr = fopen( "PORTFOLIO.DAT", "r");

    while( fgets(stock_price_shares, 61, fptr) != NULL)
        printf("\n%s", stock_price_shares);

    fclose(fptr);

    printf( "\nHow many new records for PORTFOLIO.DAT?");
    scanf("%d", &count);
    fptr = fopen("PORTFOLIO.DAT", "w");

    for(i=0; i < count; ++i)
    {
        gets(stock_price_shares);
        fputs(stock_price_shares, fptr);
    }

    fclose(fptr);
    return EXIT_SUCCESS;
}

main()
{
    char store[2];
    int i;
    for(i=0;i<2;i++)
    {
        if((store[i] = getchar()) != '\n');
        else store[i] = getchar();
    }
    putchar(store[0]);
    putchar(store[1]);
}


main()
{
    FILE* fptr;
    int c;
    fptr = fopen("poetry.txt", "w");
    while(getchar() != EOF)
        if((c = getchar()) != EOF)
            fputc(c, fptr);
    fclose(fptr);
    return EXIT_SUCCESS;
}

char* fgetstr(char* string, int max, FILE* fptr)
{
    int c;
    char* ptr = string;

    if(max <= 0)
        return NULL;

    if(max == 1)
    {
        *ptr = '\0';
        return string;
    }

    if((c = fgetc(fptr))== EOF )
        return NULL;

    max--;

    do
    {
        *ptr++ = c;
        max--;
    } while(max >= 0 && c != '\n' && (c = fgetc(fptr) != EOF));

    *ptr = '\0';
    return string;
}

int fputstr(char* string, FILE* fptr)
{
    int c;

    if(*string == '\0')
        return EOF;

    while(*string)
    {
        c = *string++;
        fputc( c, fptr );
    }

    return 1;
}

int check( char * str, char c)
{
    if(strchr(str, c) == NULL)
        return 0;
    else
        return 1;
}

int main()
{
    printf("%d", check("hi guise", 'l'));
}
*/
/*
int store(int* numarray, FILE* fin)
{
    int j = 0;
    fscanf(fin, "%d", numarray++);
    while(!feof(fin) && j < 100)
    {
        fscanf(fin, "%d", numarray++);
        j++;
    }
    return j;
}

void average_deduct(int* numbs, int count)
{
    int i = 0, store = 0;
    int* array = numbs;
    while( i++ < count)
    {
        store += *array++;

    }
    store /= count;

    i = 0;
    while( i++ < count )
    {
        *numbs++ -= store;
    }
}

int main()
{
    FILE* fin = fopen("numbs.txt", "r");
    int numbs[100];
    int num_tot = store(numbs, fin);
    average_deduct(numbs, num_tot);
    int i = 0;
    fclose(fin);
}

main()
{
    int letter;
    FILE* fp;

    fp = fopen( "data.dat", "rb");
    fseek( fp, 5, SEEK_SET);
    letter = fgetc(fp);
    printf("%c\n", letter);
    fseek(fp, 15, SEEK_CUR);
    letter = fgetc(fp);
    printf("%c\n", letter);
    fseek(fp,0,SEEK_END);
    if((letter = fgetc(fp)) == EOF)
        printf( "EOF\n");
    else
        printf("%c\n", letter);
    fseek( fp, -5, SEEK_END);
    letter = fgetc( fp);
    printf( "%c\n", letter);
    return EXIT_SUCCESS;
}
*/

int main(){

    int i=0,j=0,k=0;
    int **numbers1;
    numbers1 = (int **)malloc(10*sizeof(int*));

    for(i=0;i<10;i++){
        numbers1[i] = (int *)malloc(10*sizeof(int));
    }
    for(i=0;i<10;i++){
        for(j=0;j<10;j++){
            numbers1[i][j] = k++;
            printf("\nnumbers1[%d][%d] = %d",i,j,numbers1[i][j]);
        }
    }
}
