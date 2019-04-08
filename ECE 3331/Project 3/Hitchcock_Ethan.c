#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main()
{
//Part 1
/*  equation:
    x_1 = x_1 - (pow(x_1, 3)-3)/(3*x_1*x_1);*/

//Part 2
    double x_0;
    printf("Input initial estimate of the root: ");
    scanf("%lf", &x_0);

//Part 3
/*  code partially implemented in part 4:
    double x_1 = x_0;
    int counter = 0;
    while( fabs(pow(x_1,3)-3) >= 0.000001 && counter <500)
    {
        x_1 = x_1 - ( pow(x_1, 3)-3)/(3*x_1*x_1);
        counter = counter + 1;
    }*/
//Part 4
    double x_1 = x_0;
    int counter = 0;
    while( fabs(pow(x_1,3)-3) >= 0.000001 && counter <500)
    {
        if (3*x_1*x_1 != 0)
        {
            x_1 = x_1 - ( pow(x_1, 3)-3)/(3*x_1*x_1);
            counter = counter + 1;
        }
        else
        {
            x_1 += .000001;
            x_1 = x_1 - ( pow(x_1, 3)-3)/(3*x_1*x_1);
            counter = counter + 1;
        }
    }
//Part 5
    printf("\n\nThe final estimate of the root is: %f\n", x_1);
    printf("The number of iterations that were applied is: %d\n", counter);
    printf("The value of |f(x)| at the final estimate of the root is: %f\n", fabs(pow(x_1,3)-3));
    return 0;
}
