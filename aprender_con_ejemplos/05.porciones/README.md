[<< back](../README.md)

# Porciones

Vamos a hacer un programa que haga lo siguiente:
1. Pedir números al usuario que se irán almacenandoen una lista. Cuando se introduce un cero, se termina de pedir números.
2. Mostrar por pantalla los números en posición par de la lista.
3. Mostrar por pantalla los números en orden inverso.
4. Partir la lista en dos mitades (Si el número de elementos es impar, una parte será mayor que otra). Mostrar las dos mitades por pantalla.
5. Mostrar por pantalla todos los elementos de la primera mitad, exceptuando el primero y el último.
6. Mostrar por pantalla el máximo y el mínimo de la segunda mitad.

**[Ejemplo 1](./01-porciones.rb): Pedir números al usuario que se irán almacenandoen una lista. Cuando se introduce un cero, se termina de pedir números.**

De entrada esta frase me sugiere que vamos a tener un bucle "infinito" donde se repite el proceso de pedir un número al usuario `number = gets.to_i` y guardarlo en un Array `numbers << number`. El bucle termina cuando `number == 0` o cuando `number.zero?` devuelve `true`.

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

