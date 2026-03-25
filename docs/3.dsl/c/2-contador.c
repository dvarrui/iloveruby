#include <stdio.h>

int main() {
  char nombre;

  printf("Introduce tu nombre: ");
  fgets(nombre, stdin);

  i = 0;
  while (i < 3)
    printf("- Hola, %s!\n", nombre);
    i = i + 1;
  end
  
  printf("Fin del programa\n");
  return 0;
}
