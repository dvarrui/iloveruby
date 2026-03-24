[<< back](README.md)

# Entrada de numéros (offline)

Ya sabemos hacer entrada de datos en el script de forma interactiva y de forma no interactiva mediante el paso de argumentos. Pero hasta ahora toda la entrada que hemos realizado han sido de cadenas de texto (String). De hecho, no se pueden introducir números. Lo que hacemos es introducir una cadena de texto y luego ésta la convertimos en un número. Veamos un [ejemplo](example/greet4.rb) usando números:

```ruby
#!/usr/bin/env ruby
if ARGV.size < 2
  puts "Usage: #{$0} NAME NUMBER"
  exit 1
end

name = ARGV[0]        # First  argument
number = ARGV[1].to_i # Second argument converted into Integer
puts "Hello #{name.capitalize * number}!"
```

Veamos que sucede al ejecutarlo:
```
> ./greet4.rb
Usage: ./greet4.rb NAME NUMBER

> ./greet4.rb Yoda
Usage: ./greet4.rb NAME NUMBER

> ./greet4.rb Yoda 3
Hello YodaYodaYoda!
```

Se observa que:
1. Hemos usado una estructura `if-then` para controlar que la entrada de datos es la correcta. Como mínimo se espera recibir 2 argumentos.
2. Las entradas de datos son siempre de tipo String, pero podemos usar el método `to_i` para convertir un valor a un número (Integer).
3. Como curiosidad, si aplicamos `(String) * (Integer)`, se repite la cadena tantas veces como indique el número.

Voy a probar eso que estás pensando:
```
irb> name = "Vader"
=> "Vader"

irb> name * 4
=> "VaderVaderVaderVader"

irb> name * 0
=> ""

irb> name * -1
ArgumentError (negative argument)
```

## Bucles

Las 3 estructuras básicas de programación son:
* **Secuencia**: Ejecutar órdenes sencillas una detrás de otra.
* **Condicional**: `if-then`, `unless-then`
* **Bucles**: repetir una acción un determinado número de veces.

Estas 3 estructuras son la base para construir cualquier programa. Y evidentemente podemos hacer bucles en Ruby.

**Veamos un ejemplo usando bucle `while`**

```ruby
#!/usr/bin/env ruby
if ARGV.size < 2
  puts "Usage: #{$0} NAME NUMBER"
  exit 1
end

name = ARGV[0]
number = ARGV[1].to_i

i = 0
while(i<number) do
  puts "Hello #{name.capitalize}!"
  i += 1
end
```

**Veamos un ejemplo usando bucle `for`**

```ruby
#!/usr/bin/env ruby
if ARGV.size < 2
  puts "Usage: #{$0} NAME NUMBER"
  exit 1
end

name = ARGV[0]
number = ARGV[1].to_i

for i in 1..number
  puts "Hello #{name.capitalize}!"
end
```

## Iterar con enteros

mmm... en lugar de bucles, vamos a usar una estructura que hace lo mismo pero es de más alto nivel... el iterador. Practicamente todos los objetos de Ruby (no olvidemos que en Ruby todo son objetos) incluyen algún método para iterar.

¿Por qué usar iteradores en lugar de los claśicos bucles que se usan en cuaquier lenguaje de programación clásico?  Pues por:
1. Es el estilo Ruby.
2. Veremos que es más fácil de leer un iterador que un bucle.

> Aunque si lo prefieres, puedes usar los bucles clásicos.

Veamos el ejemplo [greet5.rb](example/greet5.rb):

```ruby
#!/usr/bin/env ruby
if ARGV.size < 2
  puts "Usage: #{$0} NAME NUMBER"
  exit 1
end

name = ARGV[0]
number = ARGV[1].to_i

number.times { puts "Hello #{name.capitalize}!" }
```

Dicho ejemplo da la siguente salida:
```
> ./greet5.rb Vader 3
Hello Vader!
Hello Vader!
Hello Vader!
```

Lo nuevo es:
* `number.times {...}`, `number` es un número (también un objeto Interger) que tiene un método llamado `times` (que es un iterador). Este método recibe un bloque de código (Es lo que está entre llaves) y lo ejecuta tantas veces como sea el valor de `number`.
* Los bloques de código pueden ir entre llaves o entre `do ... end`.

Veamos ejemplo con irb:
```
irb> a = 3
=> 3

irb> a.class
=> Integer

irb> a.times { puts "Hello!" }
Hello!
Hello!
Hello!
=> 3

irb> a.times do puts "Hello!" end
Hello!
Hello!
Hello!
=> 3
```

> AVANZADO: Los bloques de código además, son "trozos" de código que también son objetos, tienen métodos y se pueden guardar en variables, etc. Como dijimos en Ruby casi todo son objetos.

## Iterar con rangos

Veamos otro ejemplo de iterar, pero esta vez usando los rangos.

```
irb> a = 4..6
=> 4..6

irb> a.class
=> Range

irb> a.min
=> 4

irb> a.max
=> 6

irb> a.each { |i| puts "@"*i }
@@@@
@@@@@
@@@@@@
=> 4..6

irb> for i in a do puts "@"*i end
@@@@
@@@@@
@@@@@@
=> 4..6

```

## Iterar con Arrays

Los Array se llaman listas o vectores en otros lenguajes de programación. Un Array o lista es una colección de elementos. También podemos usar un Array para hacer nuestras iteraciones. Veamos un ejemplo:

```
irb> names = [ 'Obiwan', 'Quigon', 'Yoda']
=> ["Obiwan", "Quigon", "Yoda"]

irb> names.class
=> Array

irb> names.size
=> 3

irb> names.each { |i| puts "Hello #{i}!" }
Hello Obiwan!
Hello Quigon!
Hello Yoda!
=> ["Obiwan", "Quigon", "Yoda"]

irb> for name in names do puts "Hello #{name}" end
Hello Obiwan!
Hello Quigon!
Hello Yoda!
=> ["Obiwan", "Quigon", "Yoda"]

```

Los Arrays junto con los String son los objetos que más uso le vamos a dar en la creación de nuestros scripts de sysadmin.

Veamos como podemos usar los Array en la entrada de argumentos y recorrerlos todos para saludar. Ejemplo [greet6.rb](example/greet6.rb):

```ruby
#!/usr/bin/env ruby
if ARGV.empty?
  puts "Usage: #{$0} NAME1 NAME2 NAME3 ..."
  exit 1
end

for name in ARGV do
  puts "Hello #{name.capitalize}!"
end
```

Que produce la siguiente salida en pantalla:
```
> ./greet6.rb obiwan quigon yoda
Hello Obiwan!
Hello Quigon!
Hello Yoda!
```

Cosas nuevas:
1. En el control de errores no aseguramos que el Array de argumentos de entrada no esté vacío. Lo hemos hecho con `ARGV.empty?`, pero podíamos haber puesto `ARGV.size == 0`.
2. `ARGV` es un objeto Array que tiene el método `each` (Iterador). Dicho método recibe un bloque de código (`do-end`) y lo ejecuta por cada elemento dentro del Array.
3. `|name|`, es una variable auxiliar que toma en cada iteración unos de los valores del Array.

[next >>](entrada-desde-fichero.md)
