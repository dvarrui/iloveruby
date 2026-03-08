[<< back](../README.md)

# Listas de números

Vamos a hacer un programa con los siguiente "features":
* F1: Pedir 10 números al usuario y los almacenarlos en una lista.
* F2: Mostrar todos los números por pantalla.
* F3: Mostrar el texto "NEGATIVO" cuando el número sea negativo.
* F4: Mostrar el texto "REPETIDO" cuando el número esté repetido.

**[Ejemplo 1](./01-listas.rb): Feature 1 (F1). Pedir 10 números al usuario y almacenarlos en una lista.**

Creamos la variable Array que va a almacenar los números: `numbers = []`, y a continuación tendremos un bucle `while`donde le solicitamos al usuario los números.

```ruby
numbers = []

index = 1
while(index <= 10)
  print("- numbers[#{index}]? ")
  numbers[index] = gets.to_i
  index += 1
end
```

Explicación:
* El código dentro del bloque `while(COND) BLOCK end`, se ejecuta mientras sea cierta la condición `COND`. Entonces mientras `index <= 10` se va pidiendo los números al usuario. 

> **IMPORTANTE**: No olvidar actualizar la variable "index" con `index += 1`. Porque si no lo hacemos tenemos un "bucle infinito". Esto es, nunca cambia "index" y por tanto nunca se produce la condición de salida del bucle. Por eso se llama "bucle inifinito". Es un error típico del uso de los `while` olvidar que si no se desactiva la condición nos quedaremos atrapados.

**[Ejemplo 2](./02-listas.rb): Lo mismo que antes pero cambiando `while` por `for`.**

Como sabemos que con los `while` podemos cometer el error de los "bucles infinitos", y como sabemos antes de empezar el bucle el número de repeticiones entonces podemos usar un `for`. Veamos:

```ruby
numbers = []

for index in 1..10
  print("- numbers[#{index}]? ")
  numbers[index] = gets.to_i
end
```

Bucle `for`:
* Son mejores para bucles cunado se sabe a priori el numéro de repeticiones.
* Podemos notar que hemos resuelto el mismo problema pero con menos líneas y por tanto menos esfuerzo y menos carga cognitiva.

Bucle `while`:
* Son mejores para bucles donde no se sabe a priori el numéro de repeticiones.
* Implica escribir más líneas y por tanto aumenta las posibilidades de equivocarse.

**[Ejemplo 3](./03-listas.rb): cambiamos el bucle `for` por un iterador.**

Otra forma de realizar tareas repetidas sin usar bucles, es usando iteradores. Un iterador parte de un conjunto de elementos y le aplica el bloque de código a cada uno de los elementos del conjunto. Usar iteradores es más natural en Ruby, aunque puedes seguir usando los `for` y los `while` siempre que quieras.

Vamos con nuestro primer iterador.

```ruby
numbers = []

10.times do |index|
  print("- numbers[#{index}]? ")
  numbers[index] = gets.to_i
end
```

* Cogemos el objeto número `10` e invocamos a su método `times()`, de forma que estamos diciendo "haz esto 10 veces".
* Al método `times()`, le pasamos un objeto bloque `do...end` con las acciones que se van a repetir en cada iteración.
* La variable `index`, va a tomar los valores 0, 1, 2, 3, etc.

> **NOTA**: No sé si te has dado cuenta, pero algo que ha cambiado es que ahora la salida del programa muestra los índices de 0 a 9 y no de 1 a 10 como en los ejemplo anteriores. ¡Bueno! No es crítico pero tenía que decirlo.

**[Ejemplo 4](./04-listas.rb): parámetros numerados en el iterador.**

Vamos a simplificar ruido visual usando los parámetros numerados.

```ruby
numbers = []

10.times do
  print("- numbers[#{_1}]? ")
  numbers[_1] = gets.to_i
end
```

* Los parámetros numerados son:
    * `_1`, parámetro de la posición 1.
    * `_2`, parámetro de la posición 2.
    * `_3`, parámetro de la posición 3.
    * etc.
* En nuestro caso sólo tenemos un parámetro. Hemos cambiado `index` por `_1`. Nos hemos ahorrado escribir algo de código.
* `_1` es una variable (El primer parámetro). En nuestro caso irá tomando los valores 0, 1, 2, ... hasta 9.

**[Ejemplo 5](./04-listas.rb): lenguaje natural.**

El diseño de Ruby está pensado para acercarse lo más posible al lenguaje natural (Inglés) de modo que parezca que estamos leyendo y escribiendo en inglés. En las reciente versiones de Ruby se incorporado el siguiente cambio:

```ruby
numbers = []

10.times do
  print("- numbers[#{it}]? ")
  numbers[it] = gets.to_i
end
```

* En los parámetros numerados podemos usar `_1` o `it` de forma indistinta. Así suena más natural.

**[Ejemplo 6](./06-listas.rb): Feature 2 (F2). Mostrar todos los números por pantalla.**

Hacer el feature 2 (F2), no cuesta nada.

**[Ejemplo 7](./07-listas.rb): Feature 3 (F3). Mostrar el texto "NEGATIVO" cuando el número sea negativo.**

```ruby
numbers.each do
  if it < 0 
    info = "(NEGATIVO)"
  else
    info = ""
  end
  puts "- number #{it} #{info}"
end
```

* Vamos a necesitar la "estructura condicional" `if` para saber cuando es negativo (`<0`) y positivo (`>=0`).
* A la hora de mostrar los números usamos el método `each` del Array `numbers` para iterar. Volvemos a usar el parámetro `it`, porque es muy cómodo.
* A su vez, dentro del bloque de código creamos la variable String `info`. Cuando el número es negativo `info` toma el valor `"(NEGATIVO)"` y sino será la cadena vacía.
* Esta variable `info` se muestra en la salida junto al número.

**[Ejemplo 8](./08-listas.rb): En Ruby casi todas las sentencias devuelven un valor.**

En Ruby casi todas las sentencias devuelven un valor. Son como las expresiones. Vamos a cambiar sutilmente el código.

```ruby
numbers.each do
  info = if it < 0 
    "(NEGATIVO)"
  else
    ""
  end
  puts "- number #{it} #{info}"
end
```

* Vamos a necesitar la "estructura condicional" `if` para saber cuando es negativo (`<0`) y positivo (`>=0`).
* A la hora de mostrar los números usamos el método `each` del Array `numbers` para iterar. Volvemos a usar el parámetro `it`, porque es muy cómodo.
* A su vez, dentro del bloque de código creamos la variable String `info`. Cuando el número es negativo `info` toma el valor `"(NEGATIVO)"` y sino será la cadena vacía.
* Esta variable `info` se muestra en la salida junto al número.

**[Ejemplo 9](./09-listas.rb): Operador ternario.**

En casi todos los lenguaje de programación existe el operador ternario. Tiene la forma `var = COND ? TRUE_VALUE : FALSE_VALUE`. Si `COND` es verdadero `var = TRUE_VALUE` y si es falso `var = FALSE_VALUE`. El operador ternario se suele usar cuando tenemos un `if-then-else` y cada alternativa devuelve un valor.


```ruby
numbers.each do
  info = (it < 0) ? "(NEGATIVO)" : ""
  puts "- number #{it} #{info}"
end
```

¡Me gusta como ha quedado esta versión! ¡Yo me quedaría aquí y estaría bien! 

Poer por motivos didácticos voy a "rubinizar" un poco más sólo para conocer las posibilidades del lenguaje.

---
**[Ejemplo 10](./10-listas.rb): Rubinizando un poco más.**

Abrimos sesión `irb` y buscamos si existe un método que nos pueda "rubinizar":

```bash
>> 1.negative?
   1.negative?Press Alt+d to read the full document   
              Integer.negative?                       
                                                      
              (from ruby core)                        
              Implementation from Numeric             
              ----------------------------------------
                negative? -> true or false            
                                                      
              ----------------------------------------
                                                      
              Returns true if self is                 
              less than 0, false otherwise. 

>> 1.negative?
=> false

>> (-1).negative?
=> true
```

¡Lo tenemos! El método `negative?()` de los Integer devuelve `true` cuando es un número negativo y `false` en caso contrario.

A la hora de mostrar los números usamos el método `each` del Array `numbers` para iterar. Volvemos a usar el parámetro numerado `_1`, porque es muy cómodo.

```ruby
numbers.each do
  info = it.negative? ? "(NEGATIVO)" : ""
  puts "- number #{it} #{info}"
end
```

> **DUDA**: ¿El cero es positivo o es negativo? ¿Qué devuelve `0.negative?`?... Lo probamos y tenemos que `0.negative? #=> false`. O sea, que Ruby considera el 0 como un número positivo.

**[Ejemplo 11](./11-listas.rb): F4: Mostrar el texto "REPETIDO" cuando el número esté repetido.**

Para saber si un número está repetido en el Array o no, bastaría con saber para cada número, el total de apariciones. Si el total de apareciones (ocurrencias) > 0 entonces está repetido. En principio hemos conseguido expresar con palabras la idea de los pasos que queremos ejecutar para solucionar nuestro problema.

El siguiente paso es "descomponer" el párrafo anterior en varias frases, y ver si podemos "convertir" cada frase es líneas de código Ruby. De modo que vuelvo a escribir el párrafo pero de otra forma un poco más programable:

Pasos:
* Calcular el total de apariciones (`occurrences`) de cada número de la lista(`numbers`).
* Si `occurrences[i] > 1`, entonces `i` está repetido.

**Hash** 

Antes de seguir, tengo que explicarte una clase nueva. Los Hash. Un Hash Ruby es como un diccionario de Python o un Map de Java. Es una estructura que guarda pares de clave-valor. Ejemplo: `h = { "clave" => "valor" }`, donde `h["clave"]` devuelve `"valor"`.

El Hash de Ruby admite muchos tipos de objetos diferentes como clave. Como por ejemplo Integer, String y lo más usado en Ruby como clave... son los Symbol. Un Symbol o símbolo es como un String inmutable. En Exilir por ejemplo existe algo es parecido llamado "atom".

Todo esto lo explico porque vamos a usar un método del Hash para ayudarnos.

```ruby
# Creando un Hash en la variable h1
# Las claves son Integer
h1 = { 1 => "Uno", 2 => "Dos", 3 => "Tres" }

h1[1] #=> "Uno"

# Creando un Hash en la variable h2
# Las claves son Integer, String y Symbol
h2 = { 1 => "Uno", "2" => 2, :3 => "Tres" }

h2["2"] #=> "Dos"
```

Cuando se usan Symbol como clave en un Hash es habitual usar esta otra forma de escritura más concisa: `h = { clave: "valor"}`.

```ruby
# Creando un Hash en la variable h3
# Las claves son Symbol (String inmutables)
h3 = { name: "Obiwan", age: 57, height: 180 }

h3[:name] #=> "Obiwan"
h3[:age]    #=> 57
```

_Después de conocer los Hash, seguimos resolviendo nuestro problema._

**Método `group_by` del Array**

En este momento, recuerdo haber leído sobre un método llamado `group_by`, que me "suena" que podría ayudarnos. Pero no recuerdo bien... Entonces decido consultar la [documentación de group_by](https://www.rubydoc.info/stdlib/core/Enumerable:group_by). Veamos cómo funciona el método a ver si nos sirve para algo. Ejemplo:

```ruby
>> a = [1,2,2,3,3,3]
=> [1, 2, 2, 3, 3, 3]

>> a.group_by { _1 }
=> {1=>[1], 2=>[2, 2], 3=>[3, 3, 3]}
```

A partir de un Array de elementos, `group_by` devuelve un Hash agrupando los elementos que son similares. En el Hash devuelto tenemos como claves: 1, 2 y 3.
* Donde la clave 1 tiene el valor `[1]`. Este valor es a su vez un Array con un elemento.
* La clave 2 tiene el valor `[2, 2]`. Este valor es un Array con dos elementos.
* La clave 3 tiene el valor `[3, 3, 3]`. Este valor es un Array con tres elementos.

> **OJO**: A veces los problemas se resuelven más fácilmente eligiendo la estructura de datos más adecuada para representar la estructura de los valores de nuestro problema. Y los objetos más útiles son los Array, Hash y Enumerable...

Para saber el número de ocurrencias de cada clave, podemos usar el método `size()` o `count()` de cada Array.

| Clave | Valor     | count()   | Ocurrencias |
| ----- | --------- | --------- | ----------- |
| 1     | [1]       | [1].count | 1           |
| 2     | [2, 2]    | [2].count | 2           |
| 3     | [3, 3, 3] | [3].count | 3           |

> **Reflexión**: Toda esta evolución, tiene como objetivo que el código quede más sencillo, claro y fácil de entender. Bueno... desde mi punto de vista de "RubyLover". Si vienes de otro lenguaje puede que te parezcan más sencillos los primeros ejemplos, sin usar clases "raras" de Ruby. Pero para mí que conozco Ruby desde hace años veo más sencillo seguir evolucionando el código para aprovechar las clases y métodos que nos ofrece el lenguaje.

## Bucles vs iteradores

Entiendo que los iteradores de Ruby, cuestan un poco al principio porque además se usan en conjunción con los closures o bloques de código, lo cual es muy potente. Pero no te preocupes, mi itención es ayudarte a pensar en Ruby poco a poco, y como entiendo que si vienes de otro lenguaje estarás más acostumbrado a los bucles, voy a ir intercalando bucles con iteradores poco a poco hasta que al final usaremos sólo iteradores.

## Las estructuras básicas (3 de 3)

Ya conocíamos la "estructura secuencial", y la "estructura condicional", ahora con estos ejemplos hemos aprendido la **estructura bucle y/o iterador**.

---

_Hasta aquí hemos terminado de "evolucionar" las "listas", ahora puedes seguir con el [siguiente problema](../05.porciones/README.md)._