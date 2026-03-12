// https://www.amberbit.com/blog/2014/6/12/calling-c-cpp-from-ruby/
//
// Compilation:
// $ gcc -c -fPIC 01-ffi.c -o 01-ffi.o
// $ gcc -shared -o 01-ffi.so 01-ffi.o

#include <stdlib.h>
#include <math.h>

int ffi_pow(int a, int n) {
  return pow(a, n);
}

int ffi_factorial(int max) {
  int i=max, result=1;
  while (i >= 2) { result *= i--; }
  return result;
}

int ffi_fibonacci(int n) {
  int a = 1, b = 1, c, i;
  if (n == 0) {
    return 0;
  }
  for (i = 3; i <= n; i++) {
    c = a + b;
    a = b;
    b = c;
  }
  return b;
}
