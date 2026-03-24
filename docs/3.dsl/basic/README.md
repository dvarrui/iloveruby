[<< back](../README.md)

# DSL BASIC

## Ejecutar los ejemplos

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

## Basic Sin goto

Hacer un BASIC sin GOTO es, irónicamente, lo que dio origen a la programación moderna (la programación estructurada). Si quitamos los saltos de línea arbitrarios, obligamos al código a usar bloques lógicos como IF/ELSE y bucles WHILE, que es precisamente lo que Go defiende a capa y espada.

Vamos a crear un DSL en Ruby que capture la estética de BASIC (mayúsculas, comandos verbales y simplicidad) pero manteniendo una estructura limpia.

Desde la perspectiva de la Interacción Humano-Máquina (HCI), este diseño es muy interesante:

* Eliminación del Error de Salto: Al no tener GOTO, eliminamos la posibilidad de crear bucles infinitos accidentales o saltos a líneas que no existen. Esto reduce la carga cognitiva de depuración.
* Verbosismo Positivo: El uso de PRINT y INPUT en mayúsculas crea un contraste visual claro entre los comandos del lenguaje y los datos del usuario. Es lo que Go hace con el PascalCase, pero llevado a toda la palabra.
* Encapsulamiento: Aunque parece BASIC, cada bloque de código está contenido. No puedes "escapar" de un bloque a mitad de ejecución, lo que garantiza que el programa siempre termine de forma predecible.

## El BASIC original

BASIC (Beginner's All-purpose Symbolic Instruction Code) fue diseñado en 1964 con el objetivo de ser sencillo de aprender. Se pretendía que los estudiantes de cualquier carrera pudieran usar una computadora sin ser expertos en matemáticas o ingeniería.

Ejemplo: El juego de adivinar el número

```ruby
10 PRINT "--- EL JUEGO DEL NUMERO ---"
20 LET SECRETO = INT(RND(1) * 100) + 1
30 PRINT "HE PENSADO UN NUMERO DEL 1 AL 100."
40 PRINT "ADIVINALO!"
50 INPUT "TU APUESTA: ", INTENTO
60 IF INTENTO < SECRETO THEN PRINT "MAS ALTO!": GOTO 50
70 IF INTENTO > SECRETO THEN PRINT "MAS BAJO!": GOTO 50
80 PRINT "GANASTE! EL NUMERO ERA "; SECRETO
90 END
```

A diferencia de Ruby (basado en objetos) BASIC es puramente procedimental y lineal.

* GOTO: Es la palabra clave más famosa (y odiada). Permite saltar de una línea a otra. Es una representación directa de cómo piensa la CPU, pero a nivel humano crea el famoso "Código Espagueti". La mayoría de lenguajes modernos no tienen GOTO.
* LET: Era obligatorio en versiones antiguas para asignar variables, reforzando la idea de que estabas dando una orden matemática.

Hemos visto cómo Ruby puede imitar casi cualquier cosa debido a su flexibilidad. Sin embargo, BASIC nos recuerda que, a veces, la simplicidad de una lista de instrucciones numeradas es suficiente para que un humano se sienta poderoso frente a una máquina.
