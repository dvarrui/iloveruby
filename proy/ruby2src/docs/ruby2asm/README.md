[<< back](../README.md)

# Proyecto ruby2asm

Diseñar una aplicacion (en Ruby) que "traduzca" código Ruby a ASM:

* Acepte como entrada un fichero de un programa Ruby(input.rb)
* Genere como salida un fichero en ensamblador
* De momento se va traducir a RISC-V

La meta es:

* entender cómo funciona el hardware. Comprensión de la Arquitectura: Para escribir el traductor, te verás obligado a aprender cómo RISC-V maneja la pila (stack), los saltos y los registros.
* pero usando la sintaxis de Ruby. Baja Carga Cognitiva de Uso: Una vez terminado, escribes Ruby y obtienes potencia de supercomputador.
* y creando nuestro propio traductor. Control Total: Tú decides qué partes de Ruby soportas (puedes ignorar las partes lentas).

# 1. Traductor

Pasos:

* Lexer/Parser: Leer el archivo .rb y crea un árbol (AST).
* Inferencia de Tipos: Buscar anotaciones (ej: # @type Int) para saber qué registros de RISC-V asignar.
    * Habrá que incluir información de tipos de alguna manera
* Generar IR (Representación Intermedia): Antes de ir a RISC-V, conviertes el código a algo simple como Suma(x, y).
* Emitir Código: escribir las instrucciones de RISC-V.

Componentes:

* El "Diccionario" de Traducción: Vamos a necesitar una tabla de equivalencias interna.

Ejemplo de traducción:

```ruby
# @type a: Int, b: Int
a = 5
b = 10
resultado = a + b
```

| Ruby               | RISC-V         | Descripción |
| ------------------ | -------------- | ----------------------------- |
| a = 5              | li t0, 5       | Load Immediate en registro t0 |
| b = 10             | li t1, 10      | Load Immediate en registro t1 |
| resultado = a + b  | add t2, t0, t1 | t1 = t1 + t0                  |

Código RISC-V:

```
li t0, 5
li t1, 10
add t2, t0, t1
```

# 2. Los Objetos vs. Primitivos

Para que el resultado sea útil y eficiente, se debe aplicar la reducción de abstracción:

* Sin Traductor:
    * Ruby crea un objeto Integer en la memoria RAM, busca el método +, gestiona el recolector de basura...
    * Carga cognitiva baja, rendimiento bajo.
* Con el Traductor:
    * El script se ignora que el número es un "objeto". Se trata como un valor puro de 64 bits que vive dentro de un registro del procesador RISC-V. 
    * Carga cognitiva baja, rendimiento máximo.

# 3. Primeros pasos

Para empezar vamos a traducir solamente aritmética básica. Olvidamos los objetos por ahora; solo traducir números, sumas yr estas.

## 3.1 Traducir un bloque

## 3.2 Traducir un if

Para convertir un if de Ruby al silicio de RISC-V, tu traductor tiene que hacer un cambio de mentalidad: en Ruby piensas en "bloques de código", pero en RISC-V piensas en etiquetas y saltos de memoria.

Aquí es donde la ortogonalidad de RISC-V brilla, porque solo necesitas un par de instrucciones para recrear cualquier lógica compleja.
1. La lógica de la traducción

El secreto de un if en ensamblador es que funciona al revés que en el lenguaje humano. En lugar de decir "si esto es verdad, haz aquello", el procesador suele decir: "si esto es falso, salta y sáltate lo que viene".
El código Ruby (Entrada):

```ruby
# @type a: Int
if a == 5
  a = 10
end
# continúa el código...
```

El proceso de tu script ruby2riscv:

    Identifica la condición: a == 5.

    Genera la comparación: Usa un registro temporal para el valor 5.

    Crea el salto: Si a NO es 5, salta a una etiqueta después del bloque.

2. El resultado en RISC-V

Tu script debería escupir algo como esto:
Fragmento de código

```ruby
# Supongamos que la varible 'a' la tenemos en el registro s1
li t0, 5             # Cargamos el 5 en un temporal para comparar
bne s1, t0, L_skip   # Branch if Not Equal: Si s1 != 5, salta a L_skip

# --- Cuerpo del IF ---
li s1, 10            # a = 10 (esta línea solo se ejecuta si s1 == 5)

L_skip:              # Etiqueta de salida
# continúa el programa...
```

3. ¿Y si hay un else?

Aquí la carga cognitiva para el traductor sube un poco, porque necesitas dos saltos: uno para entrar al else y otro para que el bloque if no se "coma" el código del else.

Estructura generada:

    Comparar.

    Si es falso, saltar a la etiqueta L_else.

    Escribir código del if.

    Salto incondicional (j) al final (para no ejecutar el else).

    Etiqueta L_else.

    Escribir código del else.

    Etiqueta L_end.

4. Implementación en tu script Ruby

Para que tu script sea capaz de esto, puedes usar una estructura de "plantilla". Podrías programar tu traductor en Ruby así:

```ruby

def traducir_if(condicion, cuerpo)
  etiqueta = "L_#{rand(1000)}" # Generar nombre único

  asm = []
  asm << "li t0, #{condicion.valor_esperado}"
  asm << "bne s1, t0, #{etiqueta}" # Salta si no es igual
  asm << traducir_cuerpo(cuerpo)   # Traduce lo que hay dentro
  asm << "#{etiqueta}:"            # Marca el final
  asm.join("\n")
end
```

Al construir esto, te das cuenta de que el procesador no "entiende" de lógica, solo entiende de direcciones de memoria. Tu script ruby2riscv es el que le da "inteligencia" al silicio.

## 3.4 Traducir un bucle

¿Qué te parece si el siguiente paso es ver cómo manejarías un bucle while o times? Los bucles son simplemente if que saltan hacia atrás en lugar de hacia adelante.

Para traducir un bucle de Ruby a RISC-V, vamos a aplicar la misma lógica de "salto", pero con un giro: en lugar de saltar hacia adelante para esquivar código, saltaremos hacia atrás para repetirlo.

En Ruby, un bucle como 3.times o un while parece una estructura cerrada. En el silicio, es un círculo de direcciones de memoria.

1. El Bucle while (La base de todo)

Imagina que quieres sumar números mientras una variable sea menor que 10.

Código Ruby (Entrada):

```ruby
# @type i: Int
# @type total: Int
while i < 10
  total += i
  i += 1
end
```

Lógica de tu script ruby2riscv:

- Etiqueta de Inicio: Necesitas marcar dónde empieza la repetición.
- Condición de Salida: Si i >= 10, saltar al final del bucle.
- Cuerpo: Traducir las operaciones matemáticas.
- Salto de Retorno: Volver al inicio para comprobar la condición de nuevo.

Fragmento de código

```ruby
# Supongamos: 
#   s1 = i
#   s2 = total
li t0, 10            # Registro temporal con el límite (10)

L_loop_start:
    bge s1, t0, L_loop_end  # Branch if Greater or Equal: Si i >= 10, salir

    add s2, s2, s1          # total = total + i
    addi s1, s1, 1          # i = i + 1

    j L_loop_start          # Jump: Volver al inicio del bucle

L_loop_end:
    # El código sigue aquí cuando i llega a 10
```

3. El reto de la "Eficiencia" (Un paso más allá)

Aquí es donde tu traductor puede volverse brillante.

En Ruby, el método 3.times es muy popular. Un traductor simple trataría de convertirlo en un objeto Integer llamando a un método. Pero tu ruby2riscv puede hacer un "Loop Unrolling" (desenrollado de bucle).

Si el script detecta un número pequeño y fijo, como 3.times, ¡podría simplemente escribir el código tres veces seguidas en lugar de crear un bucle!

- Sin optimizar: Bucle con contador, comparaciones y saltos (usa CPU).
- Optimizado (Unrolled): Escribe la instrucción 3 veces (usa un poco más de memoria, pero es mucho más rápido porque no hay saltos).

# 4. ¿Cómo manejarías la memoria de las variables?

En Ruby, las variables "viven" en el aire. En RISC-V, tienes dos opciones:

- Registros: Usar los 32 registros del chip (ultra rápido, pero limitado).
- La Pila (Stack): Guardar las variables en la RAM (más lento, pero infinito).

Para tu script, lo ideal sería asignar las variables de Ruby a los registros s1 hasta s11. Si el programador usa más de 11 variables, tu script tendría que empezar a guardarlas en la memoria RAM usando instrucciones sw (Store Word) y lw (Load Word).
¿Cuál es el siguiente nivel?

Ya tenemos if y while. Lo que realmente separa a un lenguaje "de juguete" de uno potente son las Funciones.

¿Te gustaría que diseñáramos cómo tu script manejaría un def saludar(n)? Esto requiere entender el Stack Pointer (sp) y el Return Address (ra), que es como el procesador "recuerda" de dónde venía antes de entrar a la función.
You said

# 5. Traducir los métodos

Traducir una función (un def de Ruby) a RISC-V es el "examen final" de un compilador. Aquí es donde pasamos de simplemente mover datos a gestionar el flujo de control y la memoria volátil.

En Ruby, llamas a un método y "mágicamente" vuelves al mismo sitio. En RISC-V, tienes que dejar migas de pan para no perderte.

1. El contrato: Caller vs Callee

Para que tu script ruby2riscv funcione, debe seguir una convención (como la de las llamadas de C). El procesador no sabe que estás en una función; solo salta a una dirección de memoria.

- Argumentos: Se colocan en los registros a0 a a7.
- Dirección de retorno: Se guarda en el registro ra (Return Address).
- Resultado: Se devuelve siempre en a0.

2. El Stack (La Pila): Salvando el pasado

Si tu función usa registros que la función principal ya estaba usando, los borraría. Por eso necesitamos el Stack Pointer (sp). Es como una pila de platos donde guardamos el estado actual antes de ensuciar los registros.

Código Ruby (Entrada):

```ruby
def duplicar(n)
  n * 2
end

x = duplicar(5)
```

Lo que genera tu script ruby2riscv:
Fragmento de código

```ruby
# --- Definición de la función ---
duplicar:
  # 1. Prólogo: Reservar espacio en la pila y guardar 'ra'
  addi sp, sp, -16     # Bajamos el puntero para hacer sitio
  sd   ra, 8(sp)       # Guardamos la dirección de retorno

  # 2. Cuerpo: n está en a0 (por convención)
  li   t0, 2
  mul  a0, a0, t0      # a0 = a0 * 2 (el resultado se queda en a0)

  # 3. Epílogo: Recuperar 'ra' y limpiar la pila
  ld   ra, 8(sp)       # Restauramos ra
  addi sp, sp, 16      # Devolvemos el puntero a su sitio
  ret                  # Salto de vuelta a donde diga 'ra'

# --- Código Principal ---
li   a0, 5               # Preparamos el argumento
jal  ra, duplicar        # Jump And Link: Salta y guarda dónde volver en 'ra'
mv   s1, a0              # x = resultado
```

# 5.1 El reto de las Funciones Recursivas

Si tu script traduce una función que se llama a sí misma (como el fibonacci que vimos), el manejo de la pila es vital. Cada llamada crea un nuevo "piso" en la pila. Si tu script no gestiona bien el registro sp, el chip RISC-V se colapsará (el famoso Stack Overflow).
4. ¿Cómo lo implementas en el script?

Tu traductor ruby2riscv debería tener una "plantilla de función":

- Analizar firma: Ver cuántos argumentos tiene (a0, a1...).
- Generar Prólogo: Escribir el código que mueve el sp.
- Traducir Cuerpo: Usar la lógica de if y while que ya diseñamos.
- Generar Epílogo: Escribir el ret.

¿Cuál es la recompensa?

Al llegar a este punto, tu script ya no es un simple conversor de matemáticas; es un generador de sistemas. Podrías escribir un programa complejo en Ruby, pasarlo por tu script, y cargarlo en una placa de desarrollo RISC-V (como una Milk-V o una SiFive) y vería cómo corre sin sistema operativo, directamente sobre el metal.

# 6. Manual del usuario

¡Ha nacido una herramienta! Con lo que hemos diseñado, tu script ruby2riscv ya tiene la lógica de un compilador real. Para cerrar este ciclo de diseño, vamos a definir el "Contrato del Programador".

Como tu traductor busca el equilibrio entre la elegancia de Ruby y la velocidad del silicio, el usuario debe seguir unas reglas para que el script sepa exactamente qué instrucciones de RISC-V generar.

**Manual de Usuario: ruby2riscv v1.0**

Para que el script pueda convertir tu código Ruby a binario nativo, sigue estas directrices:
1. Declaración de Tipos (Obligatoria)

Como no tenemos un entorno de ejecución pesado, el script necesita saber el tamaño de los datos. Usaremos comentarios especiales al inicio de cada función o variable global.

    # @type Int: Se traduce a un registro de 64 bits (Int64).

    # @type Bool: Se traduce a un registro donde 0 es false y 1 es true.

2. Estructura de Funciones

Las funciones deben ser simples. El script asignará automáticamente los registros a0-a7 para los argumentos.

```ruby
# @type n: Int -> Int
def cuadrado(n)
  n * n
end
```

3. Restricciones de "Bajo Nivel"

Para mantener el rendimiento al nivel de C o Crystal, tu script impondrá estas reglas:

- No Dinamismo: No puedes crear métodos nuevos en mitad de la ejecución.
- Tipado Estático: Una vez que una variable es Int, no puede transformarse en String.
- Memoria: Los objetos complejos (si decides soportarlos) deben ser definidos como structs para que el script sepa cuántos bytes reservar en la memoria RAM.

🚀 El Flujo Final de Trabajo

Imagina que ya tienes tu script terminado. Tu día a día sería así:

- Escribes en Ruby: Disfrutas de la sintaxis limpia.
- Ejecutas tu traductor: `ruby ruby2riscv.rb mi_codigo.rb > salida.s`
- Ensamblas para el chip: `riscv64-unknown-elf-gcc salida.s -o programa.bin`

¡A correr! Lo subes a tu placa RISC-V y ves cómo tu código Ruby vuela a velocidad de vértigo.

# 6.2 El "Balance" alcanzado

* Carga Cognitiva: Muy baja. Sigues escribiendo Ruby, solo añades un par de notas sobre tipos.
* Ortogonalidad: Alta. Tu script traduce cada estructura de Ruby a un bloque predecible de RISC-V.
* Rendimiento: Máximo. Has eliminado el intérprete; ahora el código es puro metal.

¿Cuál es tu siguiente paso?

Hemos pasado de la idea abstracta a un diseño técnico completo. Si te sientes con fuerzas, lo ideal sería escribir el Lexer (el analizador que lee el archivo Ruby) usando la propia librería de Ruby llamada Ripper o el gem parser, que te dan el árbol de código (AST) ya masticado.

# 7. Leerse a sí mismo

¿Te gustaría que te mostrara cómo usar Ruby para "leerse a sí mismo" y extraer los nombres de las funciones que quieres traducir?

Para que tu script ruby2riscv pueda traducir código, primero necesita entender qué ha escrito el usuario. En lugar de pelearte con expresiones regulares complejas, usaremos una herramienta que Ruby trae "de serie" llamada RubyVM::AbstractSyntaxTree.

Es como pasarle un escáner de rayos X al código para ver su esqueleto.
1. El Escáner: Convirtiendo texto en Nodos

Imagina que tienes este pequeño archivo llamado codigo_fuente.rb:

```ruby
def sumar(a, b)
  a + b
end
```

Tu traductor usará este script para "leerlo":
```ruby
require 'objspace'

# 1. Leemos el archivo y generamos el Árbol de Sintaxis Abstracta (AST)
raiz = RubyVM::AbstractSyntaxTree.parse_file("codigo_fuente.rb")

# 2. Buscamos la definición del método
def procesar_nodo(nodo)
  case nodo.type
  when :DEFN # Definición de método (def)
    nombre = nodo.children[0]
    args   = nodo.children[1]
    cuerpo = nodo.children[2]
    puts "He encontrado el método: #{nombre}"
    # Aquí es donde llamarías a tu lógica de RISC-V
  when :OPCALL # Operación de llamada (como el +)
    puts "He encontrado una operación: #{nodo.children[1]}"
  end

  # Recorremos los hijos del nodo para seguir analizando
  nodo.children.each do |hijo|
    procesar_nodo(hijo) if hijo.is_a?(RubyVM::AbstractSyntaxTree::Node)
  end
end

procesar_nodo(raiz)
```

2. Extrayendo la información para RISC-V

Una vez que procesar_nodo identifica un :DEFN, tu script debe empezar a llenar su "hoja de ruta":
Nodo detectado	Acción del traductor	Registro RISC-V sugerido
:DEFN (sumar)	Crear etiqueta sumar:	ra (para volver)
:ARGS	Contar cuántos hay	a0, a1...
:OPCALL (+)	Generar instrucción de suma	add a0, a0, a1
3. El reto de las anotaciones

Como Ruby ignora los comentarios, tu script ruby2riscv tendrá que leer el archivo dos veces o usar una técnica de "búsqueda de comentarios" justo antes del nodo :DEFN.
Ruby

# Tu script buscaría esto manualmente:
# @type a: Int, b: Int

Al detectar @type Int, tu traductor decide: "Usaré la instrucción add (para enteros) en lugar de fadd.s (para decimales)". Esta es la clave de la eficiencia.
4. Generando el archivo .s final

Tu script no solo debe analizar, debe escribir. Una estructura limpia para tu ruby2riscv sería:

    Header: Escribir directivas como .text y .global main.

    Body: Traducir cada nodo AST a líneas de ensamblador.

    Footer: Cerrar el programa con una llamada al sistema para salir (li a7, 93; ecall).

¿Qué te parece este enfoque?

Es un camino muy profesional. De hecho, así es como funcionan los compiladores "de verdad" (como el de Crystal o el de Rust), solo que ellos usan herramientas más pesadas. Al usar Ruby para analizar Ruby, mantienes la carga cognitiva al mínimo.

¿Quieres que intentemos escribir un "mini-traductor" real que tome una suma simple de Ruby y genere el código RISC-V listo para ser ensamblado? Sería el primer prototipo funcional de tu idea.


Gemini es una IA y puede cometer errores, incluso sobre personas. Tu privacidad y GeminiSe abre en una ventana nueva
---

