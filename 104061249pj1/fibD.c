//  EE3450 Computer Architecture
//  Project 1. MIPS Assembly Programming
//  Algorithm D
//  Yu-Hsiu Huang 104061249
//  1 June, 2018
#include <stdio.h>
#include <stdlib.h>
int * FindQ(int n)          // find Q matrix for algorithm 4
{
    int *Q = malloc(4 * sizeof(int));
    if (n==1) {             // n=1 case
        for (int i=0; i<4; i++) {
            if (i != 3) *(Q+i) = 1;
            else *(Q+i) = 0;
        }
    }
    else if (n%2 == 0) {    // even case
        int *Qt = malloc(4 * sizeof(int));  // temporal matrix Qt
        Qt = FindQ(n/2);
        // Matrix Multiplication: Qt * Qt
        *Q = (*Qt)*(*Qt) + (*(Qt+1))*(*(Qt+2));
        *(Q+1) = (*Qt)*(*(Qt+1)) + (*(Qt+1))*(*(Qt+3));
        *(Q+2) = (*(Qt+2))*(*Qt) + (*(Qt+3))*(*(Qt+2));
        *(Q+3) = (*(Qt+2))*(*(Qt+1)) + (*(Qt+3))*(*(Qt+3));
        // free temporal memory
        free(Qt);
    }
    else {                  // odd case
        int *Qt = malloc(4 * sizeof(int));  // temporal matrix Qt
        int *Qk = malloc(4 * sizeof(int));  // temporal matrix Qk
        Qt = FindQ(n/2);
        Qk = FindQ(n-n/2);
        // Matrix Multiplication: Qt * Qk
        *Q = (*Qt)*(*Qk) + (*(Qt+1))*(*(Qk+2));
        *(Q+1) = (*Qt)*(*(Qk+1)) + (*(Qt+1))*(*(Qk+3));
        *(Q+2) = (*(Qt+2))*(*Qk) + (*(Qt+3))*(*(Qk+2));
        *(Q+3) = (*(Qt+2))*(*(Qk+1)) + (*(Qt+3))*(*(Qk+3));
        // free temporal memory
        free(Qt);
        free(Qk);
    }
    return Q;
}
int main(void) 
{
    int n;              // the Fibonancci number
    scanf("%d", &n);    // read the order of Fibonacci number
    if (n != 0) {
        int *Q = malloc(4 * sizeof(int));
        Q = FindQ(n);
        n = *(Q+1);
        free(Q);
    }
    else;
    printf("%d\n", n);
    return 0;
}
