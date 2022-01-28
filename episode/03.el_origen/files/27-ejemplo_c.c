#include <stdio.h>

int main(void) {
  int numero;

  printf("Escribe un número: ");
  scanf("%d", &numero);

  if (numero>0) && (numero<100) {
    printf("El número está entre 0 y 100.");
  } else {
    printf("El número está fuera del intervalo!");
  }

  return 0;
}
