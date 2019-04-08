#include <stdio.h>
#include <stdlib.h>

int main()
{
//Part 1
    FILE* SSN = fopen("ssn_in.txt", "r");
    if(SSN == NULL)
    {
        printf("The file ""ssn_in.txt"" does not exist.");
        fclose(SSN);
        return 0;
    }
//Part 2
    printf("Please enter requested SSN: ");
    int usr_ssn; scanf("%d", &usr_ssn);

    if(usr_ssn<100000000 || usr_ssn>=1000000000)
    {
        printf("\nThe number you entered (%d) is not a valid 9-digit SSN.", usr_ssn);
        fclose(SSN);
        return 0;
    }
//Part 3
    int hold_var, check = 0, count = 0;
    while(!feof(SSN))
    {
        fscanf(SSN, "%d", &hold_var);
        count = count + 1;
        if(hold_var == usr_ssn)
            check = 1;
    }
//Part 4
    if(check == 1)
        printf("\nThe SSN you entered (%d) is among the %d SSNs in the file ssn_in.txt.", usr_ssn, count);
    else if(check == 0)
        printf("\nThe SSN you entered (%d) is not among the %d SSNs in the file ssn_in.txt.", usr_ssn, count);

    fclose(SSN);
    return 0;
}
