[<< back](../README.md)

# Porciones

Vamos a hacer un programa que haga lo siguiente:
1. Pedir números al usuario que se irán almacenandoen una lista. Cuando se introduce un cero, se termina de pedir números.
2. Mostrar por pantalla los números en posición par de la lista.
3. Mostrar por pantalla los números en orden inverso.
4. Parte la lista en dos mitades. Pero si el número de elementos es impar, no importa qué mitad tiene un elemento más.
5. Mostrar las dos mitades por pantalla.
6. Mostrar por pantalla todos los elementos de la primera mitad, exceptuando el primero y el último.
7. Mostrar por pantalla el máximo y el mínimo de la segunda mitad.

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
  puts "Value[#{index}] = #{value}" if index.even?
end
```

**[Ejemplo 3](./03-porciones.rb): Mostrar por pantalla los números en orden inverso.**
