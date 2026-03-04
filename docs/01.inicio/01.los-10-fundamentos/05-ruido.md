[<< back](./README.md)

# 5. Quitando "ruido" visual

Ruby además tiene algunas "particularidades" que permiten que el lenguaje se "acerque" al lenguaje natural (el inglés). Las siguientes, por ejemplo:

1. **Los paréntesis se pueden omitir** si la expresión se entiende bien sin ellos. Por defecto, no los pondremos.
2. Casi **todas las sentencias son expresiones** y por tanto siempre (o casi siempre) se devuelve algún valor.
3. **Se sobreentiende un `return` al final de un método**. Se puede omitir la instrucción `return` al final de los métodos, porque se asume que el valor de la última expresión evaluada será el valor devuelto por el método.

Ejemplos:

```ruby
nombre = "Obi-wan"
# (Ejemplo 1) Los paréntesis sobran la mayoría de las veces
nombre.upcase #=> "OBI-WAN" 
puts nombre   #=> Muestra "Obi-wan" por el terminal

# (Ejemplo 2) Casi todo es una expresión
persona = if age >= 18
  "Adulta"
else
  "Menor"
end

# (Ejemplo 3) La sentencia return sobra al final del método
def suma(a, b)
  a + b
end
```

**Reflexión**

A menudo se critica a Ruby por ser un lenguaje demasiado flexible, poco ortogonal, que tiene varias formas de hacer lo mismo. Qué tiene magia...

Matz va evolucionando el diseño de Ruby para mantenerlo coherente, OOP, y en la medida de lo posible va incorporando azúcar sintáctico o cambios para ampliar sus capacidades para poder programar Ruby casi como si estuviéramos escribiendo en inglés.

Veremos más ejemplo, un poco más adelante.

## Quitando "ruido" cognitivo

La clase [Array](https://ruby-doc.org/core-3.0.1/Array.html) es un ejemplo de cómo el "core" de las bibliotecas del lenguaje nos pueden ayudar a expresar mucho escribiendo poco. La carga cognitiva se reduce cuando tenemos bibliotecas con los métodos adecuados para que el programador pueda utilizarlos escribiendo lo menos posible.

La clase Array, IMHO debería haberse llamado List, porque es una lista de elementos de tamaño variable al estilo Python, y no es un array al estilo C con un tamaño prefijado de elementos del mismo tipo. Esta clase, tiene "casi" todos los métodos que esperaríamos encontrar en cualquier lista.

> **NOTA**: La "potencia" de los métodos de las clases de Ruby se incrementa notablemente al combinarlos con los closures o bloques de código que veremos más adelante.

Ejemplos de métodos del Array:

* `each`: Método iterador que se combina con un closure.
* `new`, `clear`, `empty?`: Contructores, limpiadores, ¿está vacío?.
* `count`,  `size`, `length`: contador, tamaño, longitud... sinónimos.
* `+`, `-`, `<<`, `<=>`, `==` : son, aunque no lo parezcan, métodos de objetos, al estilo de operadores primitivos.
* `all?`, `any?`, `none?`, `one?`, `select`: Los nombres de estos métodos son casi autodescriptivos.
* `map`, `reduce`: Imitando características de los lenguajes funcionales.
* `first`, `last`, `index`, `at`: posiciones.
* `min`, `max`, `sum`, `minmax`: matemáticas o estadística.
* `sort`, `reverse`, `shuffle`, `sample`: orden.

## Filosofía: legibilidad vs flexibilidad

Realmente, en este punto se puede apreciar la filosofía Ruby de "tener varios caminos para la  misma tarea". Y es, precisamente en este punto, donde surge una gran diferencia con la filosofía de Python "debería haber un único camino preferente".

Este punto filosofico de Python tiene relación con la idea de legibilidad, pero en cierto modo esto es cuestionable. La legibilidad entendida como hacer "facil de leer por todos". Pero la escritura de "un único camino preferente" es legible para los que tienen una forma de pensar "alineada" con el camino de escritura elegido. Por lo tanto esta forma de escritura conduce o favorece el "pensamiento único preferentemente".

Para llegar a la legibilidad (que es facilidad para leer) implica que antes tuvo que haber un proceso de escritura. Y es en esta fase de escritura dónde se hace necesaria (desde el punto de vista de Ruby) permitirle al escritor tener libertad para expresarse según sus propios modelos cognitivos y no forzarlo a seguir un modelo único preferente.

En este sentido, dar más posibilidades al escritor de expresarse de su forma natural puede inducir también a que la lectura se realice tal y como el escritor concibió originalmente. El hecho de que el escritor deba restringir su modelo mental a unos "caminos preferentes" o "modelos cognitivos principales o mainstream" le pueden limitar expresar fielmente su idea original, llevándole a escribir algo que no es realmente lo que deseaba en su origen, y por tanto, de forma forzada se consigue una "apariencia de legibilidad" que ha sido tergiversada durante el proceso de escritura.

Me surge una pregunta, ¿cuántos métodos nos proporciona la clase `Array`?

```
$ myirb
>> Array.methods.count
=> 122
>> Array.methods.size
=> 122
>> Array.methods.length
=> 122
>> 
```

¿Cuántos métodos tiene la clase `list`de Python? 11 métodos para manipular, ordenar, buscar y modificar listas in situ. Éstos son:

1. append()
2. clear()
3. copy()
4. count()
5. extend()
6. index()
7. insert()
8. pop()
9. remove()
10. reverse()
11. sort().


---
[next >>](./06-clases.md)
