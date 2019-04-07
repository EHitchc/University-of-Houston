#include <stdio.h>
#include <stdlib.h>
/*
extern float balance = 0;

void withdraw(float value);
void deposit(float value);

main()
{
    while(1)
    {
        float amount;
        printf("enter an amount: ");
        scanf("%f", &amount);

        char type;
        printf("\nDeposit (-) or Withdrawal (+)?\n");
        scanf(" %c", &type);

        if(type == '-')
        {
            withdraw(amount);
        }
        else if(type == '+')
        {
            deposit(amount);
        }

        printf("New Balance: $%.2f\n", balance);
    }
}

void withdraw(float value){
    balance -= value;
}

void deposit(float value){
    balance += value;
}
*/

void f( int x[], int y);

main()
{
    int a[5], b, i;

    for (i = 0; i < 5; i++) a[i] = 2*i;

    b=16;
    f(a,b);
    for(i=0;i<5;i++) printf("%d\n", a[i]);
    printf("%d", b);
    return EXIT_SUCCESS;
}

void f( int x[], int y)
{
    int i;
    for (i=0;i<5;i++)
        x[i] += 2;
    y+=2;
}
