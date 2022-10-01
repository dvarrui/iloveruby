
# Selección y bucle

En este programa, presentaré algunas de las construcciones de selección y bucle en Ruby.

1. Las declaraciones if de Ruby son similares a otros lenguajes. Al igual que con las llamadas a métodos, los paréntesis son opcionales.

```ruby
puts "Enter a temperature in Celcius: "
temperature = gets.to_i

if temperature >= 100
  puts "Water is boiling at #{temperature} degrees C"
elsif temperature > 0
  puts "Water is liquid at #{temperature} degrees C"
else
  puts "Water is frozen at #{temperature} degrees C"
end
```
2. Ruby normalmente no usa llaves para identificar bloques. En su lugar, utiliza palabras clave para identificar dónde comienzan y terminan los bloques.
    * Tenga en cuenta que un 'else if' se escribe elsif.
3. La mayoría de los bloques terminan con la palabra clave end.
    * La captura de pantalla adjunta muestra algunas ejecuciones del programa que prueba todas las ramas.

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662653842466-01.png)

4. Este es un ciclo típico controlado por conteo en Ruby. Se ve bastante similar a los bucles en otros idiomas.
    * Los paréntesis son opcionales para la prueba de bucle.
    * Observe la combinación while/end para definir el bloque.

```ruby
counter = 1
while counter <= 5
  puts "Mark"
  counter += 1
end
puts
```

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662654254824-02.png)

5. Esto es bastante interesante. Los números son objetos en Ruby y tienen métodos adjuntos. Aquí estoy diciendo que quiero ejecutar el código en el bloque do/end exactamente '5 veces'.
    * do/end es una forma de especificar un bloque de código en Ruby. Las llaves {} son otra forma, pero se usan con menos frecuencia.

```ruby
5.times do
  puts "Robert"
end
puts
```

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662654416206-03.png)

6. El método `times` también funciona con variables que contienen números.

```ruby
counter = 5
counter.times do
  puts "Mahoney"
end
puts
```

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662654588958-04.png)

7. Un rango representa un rango de valores con un valor inicial y un valor final. my_range representa los números del 1 al 10.

```ruby
my_range = 1..10
```

8. Cuando se pasa un rango a puts, se llama automáticamente a to_s. La captura de pantalla adjunta muestra cómo funciona to_s. Todos los objetos tienen un método to_s.
    * Por sí mismo, un rango no es muy útil. Sin embargo, cuando se combina con loops, se vuelve poderoso. Voy a mostrar algunos ejemplos a continuación.

```ruby
my_range = 1..10
puts my_range
puts
```

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662657246888-05.png)

9. Puede convertir un rango en una matriz con el método to_a (abreviatura de 'to array'). En la línea 34, convierto el rango en una matriz y lo paso a to_s.
    * Cuando se pasa una matriz a puts, su método to_s generará una cadena con valores separados por saltos de línea (vea la captura de pantalla adjunta).

```ruby
my_range = 1..10
puts my_range
puts

puts my_range.to_a
```

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662663392623-06.png)

10. También puede crear un rango de cadenas.
    * Observe que en este ejemplo estoy usando tres puntos para separar el inicio y el final del rango en lugar de dos. Cuando usa tres puntos, el valor final no está incluido (vea la captura de pantalla adjunta).
    * En otras palabras, el valor final se excluye del rango. Esto es útil para usar rangos con matrices basadas en 0 de una longitud determinada.

```ruby
start..end  #incluido el valor final
start...end #exclusivo del valor final
```

```ruby
my_range = "a"..."e"
puts my_range.to_a
puts
```

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662663714426-07.png)

11. Un rango es un objeto. Tiene métodos para recuperar los valores inicial y final llamados min y max.

```ruby
puts "Start of range " + my_range.min
puts "End of range " + my_range.max
```

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662663996918-08.png)

12. Se puede usar un rango para controlar un bucle. Esto es equivalente a un bucle foreach en algunos otros idiomas.
    * x contendrá cada uno de los valores en el rango y será accesible en el cuerpo del ciclo.

```ruby
for x in 1..10
  puts "Iteration #{x}"
end
puts
```

![](https://markm208.github.io/rubybook/chapter1/03/media/images/1662664131287-09.png)
