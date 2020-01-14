//  EE3450 Computer Architecture
//  Project 1. MIPS Assembly Programming
//  Algorithm E
//  Yu-Hsiu Huang 104061249
//  1 June, 2018
#include <stdio.h>
#include <stdlib.h>
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
    n = Fast(n);
    printf("%d\n", n);
    return 0;
}
