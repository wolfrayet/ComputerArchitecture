//  EE3450 Computer Architecture
//  Project 1. MIPS Assembly Programming
//  Algorithm A
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
int main(void) 
{
    int n;              // the Fibonancci number
    scanf("%d", &n);    // read the order of Fibonacci number
    n=iterative(n);
    printf("%d\n", n);
    return 0;
}
