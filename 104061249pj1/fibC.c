//  EE3450 Computer Architecture
//  Project 1. MIPS Assembly Programming
//  Algorithm C
//  Yu-Hsiu Huang 104061249
//  1 June, 2018
#include <stdio.h>
#include <stdlib.h>
int tail(int n, int a, int b)   // algorithm 3: Tail Recursion
{
    if (n==0) return a;
    else return tail(n-1, b, a+b);
}
int main(void) 
{
    int n;              // the Fibonancci number
    scanf("%d", &n);    // read the order of Fibonacci number
    n=tail(n, 0, 1);
    printf("%d\n", n);
    return 0;
}
