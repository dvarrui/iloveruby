[<< back](../README.md)

# DSL - lenguaje C

## Ejecutar los ejemplos de C

Para ejecutar los programas de ejemplo hacemos lo siguiente:

* Elegimos un DSL, por ejemplo C:
```bash
c
├── 01-holamundo.c
├── 02-contador.c
├── 03-factorial.c
├── lib/
├── ncc
└── README.md
```

* Cargamos los alias y entramos en la carpeta del DSL de C:
```bash
source .nalias
cd c
```

* Consultamos el ejemplo: 
```c
#include <stdio.h>

main {
    printf("Hola Mundo!\n");
    return 0;
}
```

* "Compilamos" y ejecutamos el programa:
```console
$ ncc 01-holamundo.c 

$ ./a.out 
Hola Mundo!
```

En este caso, el comando `ncc` simula el comportamiento de un compilador y construye el ejecutable `a.out`.

## Desarrollo

Imitar C en Ruby es un desafío porque son polos opuestos:
* C es estático, de bajo nivel y gestiona memoria manualmente.
* Ruby es dinámico, de alto nivel y abstrae todo lo anterior.

El primer reto, debemos imitar la sintaxis de tipos, el uso de punteros y la estructura de funciones con `main()`.

