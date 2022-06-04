[<< back](../README.md)

# Programación estructurada

La programación estructurada es un paradigma de programación que recurre únicamente a subrutinas y tres estructuras básicas: secuencia, selección (if y switch) e iteración (bucles for y while).

## Estructura de secuencial

```ruby
print "What's your name? "
name = gets.chomp

puts "Hello #{name}!"
```

## Estructura condicional

```ruby
print "Select lang (en, es): "
lang = gets.chomp

if lang == 'en'
  puts "Hello!"
elsif lang == 'es'
  puts "¡Hola!"
else
  puts "Sorry, I don't speak #{lang}"
end
```

## Estructura iterativa

```ruby
print "How much do you love me? (Integer) "
value = gets.to_i

i = 0
while (i<value)
  print "(#{i}) Kiss "
  i += 1
end
```

```ruby
print "How much do you love me? (Integer) "
value = gets.to_i

value.times do |i|
  print "(#{i}) Kiss "
end
```

## Subrutina, método y función

**Una subrutina o subprograma (también llamada procedimiento, función, rutina o método)**, como idea general, se presenta como un subalgoritmo que forma parte del algoritmo principal, el cual permite resolver una tarea específica. Algunos lenguajes de programación, utilizan el nombre función para referirse a subrutinas que devuelven un valor.

En el caso de Ruby tenemos funciones porque siempre devuelven un valor.

```ruby
def greet(name)
  text = "Hello, #{name}!"
  return text
end

puts greet
```

```ruby
def greet(name)
  "Hello, #{name}!"
end

puts greet
```

## Require

Vamos a ver cómo podemos usar funciones de otros ficheros Ruby.

Fichero 1, es el que contiene las definiciones de funciones:
```ruby
def greet(name)
  "Hello, #{name}!"
end
```

Fichero 2, es el que se ejecuta y hace uso de funciones externas:
```ruby
require_relative `fichero1`

puts greet
```

## Resumen

* En Ruby los paréntesis son opcionales. Los podemos usar para ayudar aclarar alguna sentencia si lo creemos necesario.
* Todas las líneas que se ejecutan, siempre devuelven algo. No es necesario poner la instrucción `return` al final de la función.
* Deberíamos intentar escribir casi como cuando escribimos en lenguaje natural.
