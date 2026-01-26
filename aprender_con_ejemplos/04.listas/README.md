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


```ruby
>> a = [1,2,2,3,3,3]
=> [1, 2, 2, 3, 3, 3]

>> a.group_by { _1 }
=> {1=>[1], 2=>[2, 2], 3=>[3, 3, 3]}
```
---

_Hasta aquí hemos terminado de "evolucionar" las "listas", ahora puedes seguir con el siguiente problema._