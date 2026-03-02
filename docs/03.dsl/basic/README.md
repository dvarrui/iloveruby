
# DSL BASIC

Programa basic de ejemplo

BASIC (Beginner's All-purpose Symbolic Instruction Code) es el abuelo de la simplicidad en la programación. Fue diseñado en 1964 con un objetivo puramente de Interacción Humano-Máquina (HCI): que los estudiantes de cualquier carrera pudieran usar una computadora sin ser expertos en matemáticas o ingeniería.

Aquí tienes un ejemplo clásico en el estilo de los 80 (como el Applesoft BASIC o el Commodore 64), donde la elegancia residía en la numeración de líneas.

1. Ejemplo: El juego de adivinar el número

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

2. Análisis del diseño de BASIC
La elegancia de lo secuencial

A diferencia de Go (estructurado), Ruby (basado en objetos) o Racket (funcional), BASIC es puramente procedimental y lineal.

* GOTO: Es la palabra clave más famosa (y odiada). Permite saltar de una línea a otra. Es una representación directa de cómo piensa la CPU, pero a nivel humano crea el famoso "Código Espagueti".
* LET: Era obligatorio en versiones antiguas para asignar variables, reforzando la idea de que estabas dando una orden matemática.

Comparativa: BASIC vs. el DSL de C en Ruby
Característica	BASIC Original	Ruby imitando a C
Control de flujo	Líneas numeradas (GOTO 50)	Funciones (main)
Variables	Globales por defecto	Definidas por método (int :x)
Carga Cognitiva	Muy Baja: Se lee de arriba a abajo.	Media: Hay que entender el contexto.

3. ¿Por qué Go "odia" a BASIC (indirectamente)?

Volviendo a tu primera pregunta sobre por qué Go piensa que ciertas cosas son "mala idea": Go (y la mayoría de lenguajes modernos) nació para matar al GOTO. La elegancia de Go reside en estructuras de control claras (for, if). En BASIC, el flujo de ejecución puede saltar a cualquier parte del programa, lo que hace que depurar un error en un sistema grande sea una pesadilla humana.
Un puente hacia el futuro

Hemos visto cómo Ruby puede imitar casi cualquier cosa debido a su flexibilidad. Sin embargo, BASIC nos recuerda que, a veces, la simplicidad de una lista de instrucciones numeradas es suficiente para que un humano se sienta poderoso frente a una máquina.

¿Te gustaría que hiciéramos un DSL en Ruby para imitar BASIC, incluyendo la numeración de líneas y el comando GOTO? Sería un reto técnico muy divertido.

Sin goto

Hacer un BASIC sin GOTO es, irónicamente, lo que dio origen a la programación moderna (la programación estructurada). Si quitamos los saltos de línea arbitrarios, obligamos al código a usar bloques lógicos como IF/ELSE y bucles WHILE, que es precisamente lo que Go defiende a capa y espada.

Vamos a crear un DSL en Ruby que capture la estética de BASIC (mayúsculas, comandos verbales y simplicidad) pero manteniendo una estructura limpia.

1. El motor: ModernBasic

En esta versión, las líneas no tendrán números (para evitar la tentación del GOTO), pero mantendremos las palabras clave icónicas.
Ruby


2. El programa: BASIC Estructurado en Ruby

Este programa se siente como BASIC, pero fluye como un lenguaje moderno.
Ruby

ModernBasic.run do
  PRINT "--- BIENVENIDO AL TRADUCTOR BASIC ---"
  
  INPUT "COMO TE LLAMAS?", :NOMBRE
  
  LET :SALUDO, "HOLA " + NOMBRE
  
  PRINT SALUDO
  
  PRINT "VAMOS A CONTAR HASTA 3:"
  
  LET :CONTADOR, 0
  REPEAT 3 do
    # Aquí usamos lógica de Ruby dentro del bloque
    PRINT "CONTANDO..."
  end
  
  PRINT "FIN DEL PROGRAMA."
end

3. ¿Por qué es este el punto medio ideal?

Desde la perspectiva de la Interacción Humano-Máquina (HCI), este diseño es muy interesante:

    Eliminación del Error de Salto: Al no tener GOTO, eliminamos la posibilidad de crear bucles infinitos accidentales o saltos a líneas que no existen. Esto reduce la carga cognitiva de depuración.

    Verbosismo Positivo: El uso de PRINT y INPUT en mayúsculas crea un contraste visual claro entre los comandos del lenguaje y los datos del usuario. Es lo que Go hace con el PascalCase, pero llevado a toda la palabra.

    Encapsulamiento: Aunque parece BASIC, cada bloque de código está contenido. No puedes "escapar" de un bloque a mitad de ejecución, lo que garantiza que el programa siempre termine de forma predecible.

El círculo se cierra: De Go a BASIC

Empezamos hablando de por qué Go considera ciertas cosas mala idea. La respuesta final es: La predictibilidad.

    BASIC con GOTO era impredecible (saltos locos).

    POO Clásica es impredecible (jerarquías que se rompen).

    Go y Ruby (bien usado) buscan que el camino del código sea una línea recta o curvas suaves, nunca un nudo.

Hemos recorrido casi 60 años de historia de lenguajes a través de DSLs en Ruby. ¿Te gustaría que intentáramos algo más radical, como un DSL para música (tipo Sonic Pi) o prefieres explorar cómo Rust gestiona estos mismos conceptos de forma ultra-segura?


