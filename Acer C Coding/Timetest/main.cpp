#include <iostream>
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

int main() {

    while(1){
        SYSTEMTIME st;
        GetLocalTime(&st);

        printf("%u:%u:%u:%u\n", st.wHour, st.wMinute, st.wSecond, st.wMilliseconds);
        Sleep(10);
    }
}
