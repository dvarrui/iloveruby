[<< back](../README.md)

# DSL BASIC

El BASIC (Beginner's All-purpose Symbolic Instruction Code) original fue diseñado en 1964 con el objetivo de ser sencillo de aprender. Se pretendía que los estudiantes de cualquier carrera pudieran usar una computadora sin ser expertos en matemáticas o ingeniería.

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

# Ejecución

**Elegir el DSL**

* `source .nalias`, cargamos los alias.
* `cd basic`, entramos en la carpeta del DSL.
* Los ficheros `.bas` son los programas BASIC.

**Ejecutar un programa**

```bash
$ nbasic 1-holamundo.bas 
HOLA MUNDO!
```
> El nombre `nbasic`, no significa "New Basic" sino "No es Basic".

# Logros

* **Sin goto**
    * GOTO es la palabra clave más famosa (y odiada). Permite saltar de una línea a otra. Los lenguajes modernos no tienen GOTO porque se crea "código espageti".
    * Al no tener GOTO, eliminamos la posibilidad de crear bucles infinitos accidentales o saltos a líneas que no existen. Esto reduce la carga cognitiva de depuración.
* **Estructurado**:
    * Nuestro BASIC es más estructurado, ya que se eliminan los saltos.
    * El código se agrupa en bloques con un delimitador.
* **Estética**:
    * Se ha conseguido capturar la estética y apariencia del BASIC original (mayúsculas, comandos verbales y simplicidad).
    * LET era obligatorio en versiones antiguas para asignar variables, reforzando la idea de que estabas dando una orden matemática.
    * En nuestro DSL es opcional.
