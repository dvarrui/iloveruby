[<< back](../README.md)

# Porciones

Vamos a hacer un programa que haga lo siguiente:
* Pedir números al usuario que se irán almacenandoen una lista. Cuando se introduce un cero, se termina de pedir números.
* Mostrar por pantalla los números en posición par de la lista.
* Mostrar por pantalla los números en orden inverso.
* Partir la lista en dos mitades (Si el número de elementos es impar, una parte será mayor que otra). Mostrar las dos mitades por pantalla.
* Mostrar por pantalla todos los elementos de la primera mitad, exceptuando el primero y el último.
* Mostrar por pantalla el máximo y el mínimo de la segunda mitad.

**[Ejemplo 1](./01-porciones.rb): Pedir números al usuario que se irán almacenandoen una lista. Cuando se introduce un cero, se termina de pedir números.**

De entrada esta frase me sugiere que vamos a tener un bucle "infinito" (`loop`) donde se repite un proceso (`do...end`). El proceso que se repite será
* pedir un número al usuario `number = gets.to_i` y guardarlo en un Array `numbers << number`. 
* El bucle termina cuando `number == 0` o cuando `number.zero?` devuelve `true`. O dicho de otra forma, cuando se cumple la condición de salida "nos salimos" (`break`) del bucle "infinito" (`loop`).

> **NOTA**: Siempre me ha gustado como suena "bucle inifinito". Evoca a algo "matemático-filosófico". En programación debemos ser conscientes de cuando nuestro código tiene un "bucle infinito", porque cuando empezamos a programar es habitual el error de crear un bucle "infinito" sin condición de salida y entonces nuestro programa no termina "nunca".

```ruby
loop do
  print("Número? "); number = gets.to_i
  break if number.zero?
  numbers << number
end
```

**[Ejemplo 2](./02-porciones.rb): Mostrar por pantalla los números en posición par de la lista.**

```ruby
numbers.each_with_index do |value, index|
  puts "Posición[#{index}] = #{value}" if index.even?
end
```

**[Ejemplo 3](./03-porciones.rb): Mostrar por pantalla los números en orden inverso.**

Esta es muuuy fácil. Como nuestro "contenedor" es `numbers` y es de tipo Array, buscamos en la documentación de Array a ver si existe algún método que nos devuelva lo que necesitamos, o bien con el intérprete interactivo `irb`. Ejemplo:

```ruby
>> a = [1, 2, 3]
=> [1, 2, 3]

>> a.reverse     Press Alt+d to read the full document   
                 Array.reverse  
                                            
                 (from ruby core)                        
                 ----------------------------------------
                   array.reverse -> new_array            
                                                         
                 ----------------------------------------
                                                         
                 Returns a new Array with the elements of
                 self in reverse order:                  
                                                         
                   a = ['foo', 'bar', 'two']             
                   a1 = a.reverse                        
                   a1 # => ["two", "bar", "foo"]
```

¡Encontrado!

**[Ejemplo 4](./04-porciones.rb): Partir la lista en dos mitades (Si el número de elementos es impar, una parte será mayor que otra). Mostrar las dos mitades por pantalla.**

Tenemos que `numbers` es un Array que contiene a todos los números con los que estamos trabajando. 

* Empezamos calculando qué cantidad de elementos serían la mitad: `half_size = numbers.length / 2`.
* Ahora vamos a "coger" del `numbers` una cantidad de `half_size`elementos: `half_numbers1 = numbers.take(half_size)`. Esto es, al Array tiene el método `take(N)`que nos devuelve los N primeros elementos del Array. ¡Bien! Ya tenemos la primera mitad.
* Para "calcular" la segunda mitad hacemos `half_numbers2 = numbers - half_numbers1`, esto es, al Array de todos los números `numbers`, le "restamos" o le quitamos los elementos de la primera mitad `half_numnbers1`, y como resultado nos quedan los elementos de la segunda mitad.
* Mostramos el resultado por pantalla.

**[Ejemplo 5](./05-porciones.rb): Refactorizamos lo anterior.**

No termino de quedarme contento con la solución anterior. Vamos a pensar otra forma de resolver el mismo problema de dividir el Array en dos mitades. Resumiendo lo que queremos es:
* Calcular cuántos elementos son la mitad del Array.
* Coger la primera mitad del Arrya y
* Coger la segunda mitad del Arrya.

Abro una sesión de `irb` y pruebo lo siguiente comn un Array de elementos impares:

```
>> a = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]

>> b = a.length / 2
=> 2

>> a[0,b]
=> [1, 2]

>> a[b,b]
=> [3, 4]

>> a[b,b + 1]
=> [3, 4, 5]
```

¿Qué hemos hecho?
* Empezamos con un Array con 4 elementos `a`.
* Calculamos y guardamos la mitad del tamaño `b = a.legth / 2`.
* La primera mitad es coger `b` elementos desde la posición 0.
* La segunda mitad en coger `b + 1` elementos desde la posición `b`.

Abro sesión `irb` y pruebo con una Array de un número par de elementos:

```
>> a = [1,2,3,4]
=> [1, 2, 3, 4]

>> b = a.length / 2
=> 2

>> a[0,b]
=> [1, 2]

>> a[b,b + 1]
=> [3, 4]
```

¡Funciona bien en ambos casos! Aunque en este último, coger `b + 1` elementos nos "saldríamos" del Array... Ruby te permite coger elementos hasta donde exista. Otros ejemplo:

```ruby
>> a = [1,2,3,4]
=> [1, 2, 3, 4]

>> a[2, 999]
=> [3, 4]
>> 
```

**[Ejemplo 6](./06-porciones.rb): Mostrar por pantalla todos los elementos de la primera mitad, exceptuando el primero y el último.**

Una imagen vale más que mil palabras o `imagen > palabras * 1000`.

```
>> a = [1,2,3,4]
=> [1, 2, 3, 4]

>> a.delete_at(0)
=> 1

>> a
=> [2, 3, 4]

>> a.delete_at(-1)
=> 4

>> a
=> [2, 3]
```

Quitar elementos de un Array es tan sencillo como invocar al método `delete_at(N)`, donde `N` es la posición del elemento dentro del Array. La posición `0` es el primer elemento y el último elemento está en la posición `a.length - 1` o visto de como si el Array fuera circular, el último elemento está en la posición `-1`.

> **IMHO**: Con los Array y los Hash se pueden resolver muchísimos problemas. Es importante estar familiarizado con sus métodos porque son muy útiles.

Como la salida por pantalla empieza a ser "excesiva", usamos los colores para separar visualmente cada bloque de salida y facilitar su lectura.

**[Ejemplo 7](./07-porciones.rb): Mostrar por pantalla el máximo y el mínimo de la segunda mitad.**

La intuición nos pide usar un método `min` y otro `max` en la segunda mitad `half_numbers2`. Y nuestra intuición "nos sirve bien".

---

_Hasta aquí hemos terminado de "evolucionar" las "porciones", ahora puedes seguir con el [siguiente problema](../06.geometria/README.md)._