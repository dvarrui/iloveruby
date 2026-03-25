#include <stdio.h>

int main() {
    int number;
    int factorial;
    int i;

    number = 3;
    factorial = 1;
    i = number;
    while(i>1) 
      factorial = factorial * i;
      i = i - 1 ;
    end
    printf("Factorial de %d es %d\n", number, factorial);
    return 0;
}
