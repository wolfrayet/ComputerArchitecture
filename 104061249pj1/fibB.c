//  EE3450 Computer Architecture
//  Project 1. MIPS Assembly Programming
//  Algorithm B
//  Yu-Hsiu Huang 104061249
//  1 June, 2018
#include <stdio.h>
#include <stdlib.h>
int recursive(int n)        // algorithm 2: Recursive Method
{
    if (n==0 || n==1) return n;
    else return recursive(n-1) + recursive(n-2);
}
int main(void) 
{
    int n;              // the Fibonancci number
    scanf("%d", &n);    // read the order of Fibonacci number
    n=recursive(n);
    printf("%d\n", n);
    return 0;
}
