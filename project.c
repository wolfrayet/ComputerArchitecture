//  EE3450 Computer Architecture
//  Project 1. MIPS Assembly Programming
//  Yu-Hsiu Huang 104061249
//  1 June, 2018
#include <stdio.h>
#include <stdlib.h>
int iterative(int n)        // algorithm 1: Iterative Method
{
    if (n==0) return n;
    int temp1=0;
    int temp2=1;
    int temp3;
    for (int i=1; i<n-1; i++) {
        temp3 = temp1 + temp2;
        temp1 = temp2;
        temp2 = temp3;
    }
    return temp3 + temp1;
}
int recursive(int n)        // algorithm 2: Recursive Method
{
    if (n==0 || n==1) return n;
    else return recursive(n-1) + recursive(n-2);
}
int tail(int n, int a, int b)   // algorithm 3: Tail Recursion
{
    if (n==0) return a;
    else return tail(n-1, b, a+b);
}
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
int Fast(int n)             // algorithm 5: Fast Doubling Method
{
    if (n==0) return 0;
    int i = 1;
    int fi = 1, fk = 1;
    while (i<n) {
        if (i<=n/2) {
            int f2k = fi*fi + fk*fk;
            int f2i = fi*(2*fk - fi);
            fi = f2i;
            fk = f2k;
            i = 2*i;
        }
        else {
            int f2i = fk + fi;
            fi = fk;
            fk = f2i;
            i += 1;
        }
    }
    return fi;
}
int main(void) 
{
    int n;              // the Fibonancci number
    scanf("%d", &n);    // read the order of Fibonacci number
    // Algorithm 1
    //n=iterative(n);

    // Algorithm 2
    n=recursive(n);

    // Algorithm 3
    //n=tail(n, 0, 1);

    // Algorithm 4
/*
    if (n != 0) {
        int *Q = malloc(4 * sizeof(int));
        Q = FindQ(n);
        n = *(Q+1);
        free(Q);
    }
    else;
*/
    // Algorithm 5
    //n = Fast(n);

    // Output the result 
    printf("%d\n", n);
    return 0;
}
