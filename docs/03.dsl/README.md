[<< back](../index.md) | [HOME](../index.md) | [next >>](../01.inicio/README.md)

```
iLoveRuby -> DSL

EN CONSTRUCCION!!!
```

# Sección 3: DSL

## Definición

Un DSL (Domain Specific Languaje) es un lenguaje diseñado específicamente para resolver problemas en un dominio particular. El objeto de resolver un problema usando DSL es que de esta forma se aumenta la productividad al ofrecer una sintaxis concisa y cercana al lenguaje del negocio, facilitando la comunicación con usuarios no técnicos.

## Características

El lenguaje de programación Ruby tiene unas características que lo hacen ideal para crear DSL, por ejemplo:

* El tipado dinámico de mucha flexibilidad.
* Los paréntesis de los métodos son opcionales.
* Los closures o bloques de código son objetos que se pasan por parámetros pero además se pueden pasar de forma "natural" como el "último" parámetro implícito del método.
* Hay varias formas de implementar metaprogramación.
* El método `method_missing` puede "capturar" invocaciones que no existen y actuar de forma controlada.
* El punto y coma para separar las sentencias es opcional.
* "Casi" toda sentencia es una expresión y por tanto, siempre devuelve algo.
* etc.

## Ejemplos

Se han creado los siguientes DSL de ejemplo para demostrar en la práctica real que la teoría sobre Ruby funciona.

* [BASIC](./basic/): DSL de Ruby para crear un BASIC.
    * Para ejecutar hacemos `nbasic 01-holamundo.bas`.
* [C](./c/): DSL de Ruby para crear un C.
    * Para "compilar" hacemos `ncc 01-holamundo.c`.
    * Para ejecutar hacemos `./a.out`.
* [Python](./python/): DSL de Ruby para crear un Python.
    * Para ejecutar hacemos `npython 01-hello.py`.

> En Desarrollo: Javascript, LIST  y Logo.

### Ejecutar los ejemplos de BASIC

Para ejecutar los programas de ejemplo hacemos lo siguiente:

* Elegimos un DSL, por ejemplo BASIC:
```bash
basic
├── 01-holamundo.bas
├── 02-contador.bas
├── 03-factorial.bas
├── lib/
└── README.md
```

* Cargamos los alias y entramos en la carpeta del DSL BASIC:
```bash
source .nalias
cd basic
```

* Ejecutamos un ejemplo:
```bash
$ nbasic 01-holamundo.bas 
HOLA MUNDO!
```

> En el caso del C, el comando `ncc` simula el comportamiento de un compilador y construye el ejecutable `a.out`.

### Ejecutar los ejemplos de C

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

* Para cada DSL se ha creado la subcarpeta `lib` que contiene los ficheros que hacen la "magia" de convertir Ruby en un lenguaje diferente.
* La carga de los alias `.nalias` es para aumentar el efecto de la magia, creando los alias `nbasic`, `ncc`, `npython`, como si fueran los intérpretes o compiladores del lenguaje imitado.
* El nombre `nbasic`, no significa "New Basic" sino "No es Basic".