[<< back](../README.md)

# Listas de números

Vamos a hacer un programa que:
* Pedir 10 números al usuario y los almacenarlos en una lista.
* Motrar todos los números por pantalla.
* Mostrar el texto "NEGATIVO" cuando el número sea negativo.
* Mostrar el texto "REPETIDO" cuando el número esté repetido.

**[Ejemplo 1](./01-listas.rb): Pedir 10 números al usuario y almacenarlos en una lista.**

Creamos la variable Array que va a almacenar los números: `numbers = []`.

A continuación, iteramos 10 veces para solicitarle al usuario los números. Pero esta vez usamos otra forma de iterar. Cogemos el objeto número `10` e invocamos a su método `times()`, de forma que estamos diciendo "haz esto 10 veces". Al método le pasamos un objeto bloque `do..end` con las acciones que se van a repetir en cada iteración.

```ruby
10.times do
  print("numbers[#{_1}]? ")
  numbers[_1] = gets.to_i
end
```

> **Recordar:**  `_1` es un parámetro numerado (El primer parámetro). En nuestro caso será 0, 1, 2, ... hasta 9.

**[Ejemplo 2](./02-listas.rb): Mostrar todos los números por pantalla.**

No cuesta nada hacerlo.

**[Ejemplo 3](./03-listas.rb): Mostrar el texto "NEGATIVO" cuando el número sea negativo.**

Abrimos sesión `irb` y buscamos si existe un método que nos pueda ayudar:

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

> **DUDA**: ¿Qué devuelve `0.negative?`?... Lo probamos y tenemos que `0.negative? #=> false`. O sea, que Ruby considera el 0 como un número positivo.

A la hora de mostrar los números usamos el método `each` del Array `numbers` para iterar. Volvemos a usar el parámetro numerado `_1`, porque es muy cómodo.

A su vez, dentro del bloque de código creamos la variable `info` con un "operador ternario" (que es como un condicional pero en una línea). Cuando el número es negativo info toma el valor `"(NEGATIVO)"` y sino será `""` (La cadena vacía). Esta variable `info` se muestra en la salida junto al número.

```ruby
numbers.each do
  info = _1.negative? ? "(NEGATIVO)" : ""
  puts "- number #{_1} #{info}"
end
```

**[Ejemplo 4](./04-listas.rb): Mostrar el texto "REPETIDO" cuando el número esté repetido.**

Para saber si un número está repetido en el Array o no, bastaría con saber para cada número, el total de apariciones, y luego podríamos quedarnos o filtrar únicamente por aquellos que tengan el total mayor a 1. En principio hemos conseguido expresar con palabras la idea de los pasos que podemos ejecutar para solucionar nuestro problema.

El siguiente paso es "descomponer" el párrafo anterior en varias frases, y ver si podemos "convertir" cada frase es líneas de código Ruby. Vuelvo a escribir el párrafo pero de otra forma un poco más programable:

Pasos:
* Calcular el total de apariciones (`occurrences`) de cada número de la lista(`numbers`).
* Si `occurrences[i] > 1`, entonces `i` está repetido.

**Hash** 

Antes de seguir, tengo que explicarte una clase nueva. Los Hash. Un Hash Ruby es como un diccionario de Python o un Map de Java. Es una estructura que guarda pares de clave-valor. Ejemplo: `h = { "clave" => "valor" }`, donde `h["clave"]` devuelve `"valor"`.

El Hash de Ruby admite muchos tipos de objetos diferentes como clave. Como por ejemplo Integer, String y lo más usado en Ruby como clave... los Symbol. Un Symbol o símbolo es como un String inmutable. En Exilir por ejemplo existe algo es parecido llamado "atom".

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

**Método `group_by`**

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

> **OJO**: A veces los problemas se resuelven más fácilmente eligiendo la estructura de datos más adecuada para representar la estructura de los valores de nuestro problema.

Para saber el número de ocurrencias de cada clave, podemos usar el método `size()` o `count()` de cada Array.

| Clave | Valor     | count()   | Ocurrencias |
| ----- | --------- | --------- | ----------- |
| 1     | [1]       | [1].count | 1           |
| 2     | [2, 2]    | [2].count | 2           |
| 3     | [3, 3, 3] | [3].count | 3           |

> **Reflexión**: Toda esta evolución, tiene como objetivo que el código quede más sencillo, claro y fácil de entender. Bueno... desde mi punto de vista de "RubyLover". Si vienes de otro lenguaje puede que te parezcan más sencillos los primeros ejemplos, sin usar clases "raras" de Ruby. Pero para mí que conozco Ruby desde hace años veo más sencillo seguir evolucionando el código para aprovechar las clases y métodos que nos ofrece el lenguaje.

---

_Hasta aquí hemos terminado de "evolucionar" las "listas", ahora puedes seguir con el siguiente problema._