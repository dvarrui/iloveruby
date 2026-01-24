[<< back](README.md)

# Variables y tipos

> Enlaces de interés:
> * https://markm208.github.io/rubybook/chapter1/02/index.html
> * [Example](files/02.rb)

En este programa discutiré cómo crear variables en programas de Ruby.

Las variables locales, los parámetros de los métodos y los nombres de los métodos deben comenzar con letras minúsculas.

Al crear variables locales, no se necesita especificar los tipos. Cada variable tiene un tipo, pero se determina en función de cómo se usa.

Entonces, no haremos estas cosas en Ruby:
```
String name = new String();
int age;
age = 49;
```

Ruby infiere el tipo de una variable a partir del valor que se almacena dentro de ella.

## Paso 1/12

```ruby
name = "Markus"
```

El intérprete de Ruby se da cuenta de que el programador quiere crear una variable llamada `name`. También determina que el tipo de la variable es una cadena debido a las comillas dobles.

## Paso 2/12

```ruby
name = "Markus"
age = 49
```

Y aquí crea una variable llamada `age` y determina que es un número entero. Los números enteros no tienen puntos decimales en ellos.

## Paso 3/12

```ruby
name = "Markus"
age = 49
height = 71.5
```

La variable de altura es un número de punto flotante (un número con un punto decimal)..

## Paso 4/12

```ruby
name = "Markus"
age = 49
height = 71.5

puts "Age: " + age.to_s
```

La variable `age` no es un string, es un int. `puts` solo imprime string. Para imprimirlo con `puts`, necesito convertirlo en un string.

`to_s` es el método de conversión para convertir un objeto en un string. Este método está disponible en todas las variables.

![](https://markm208.github.io/rubybook/chapter1/02/media/images/1662644737179-01.png)

## Paso 5/12

```ruby
name = "Markus"
age = 49
height = 71.5

# puts "Age: " + age.to_s
puts age
```

Resulta que si se pasa algo que no sea una cadena a `puts`, se llamará a `to_s` automáticamente. Entonces, el código resaltado también funciona.

## Paso 6/12

```ruby
name = "Markus"
age = 49
height = 71.5

#puts "Age: " + age.to_s
#puts age

puts "#{name}'s age is #{age}"
puts
```

Ruby permite incrustar variables en una cadena usando la sintaxis:

```ruby
"texto #{variable} texto"
```

A esto se le llama interpolación de cadenas.

Aquí, en lugar de agregar cadenas y variables juntas, se unen todas en una sola cadena. Vea la captura de pantalla adjunta.

Es una buena forma de tratar con cadenas y variables.

![](https://markm208.github.io/rubybook/chapter1/02/media/images/1662644937914-02.png)

## Paso 7/12

```ruby
name = "Markus"
age = 49
puts "#{name}'s age is #{age}"

puts "Enter a new name, I don't like #{name}"
name = gets
name.chomp!

puts "Enter an age"
age = gets.to_i

puts "#{name}'s age is #{age}"
```

El método `gets` lee la entrada del teclado. Devuelve una cadena de texto con la nueva línea que se generó al presionar la tecla 'enter'.

## Paso 8/12

El método `chomp!` quita el "retorno de carro" del final de la cadena.

El símbolo `!` al final del nombre del método, significa que se va a cambiar el valor de la cadena. La variable, `name`, se actualizará para eliminar la nueva línea.

Hay otra versión de `chomp` que no termina con `!`. Cuando se llama a esta versión del método, se devuelve una cadena nueva sin el "retorno de carro". Sin embargo, la variable `name` original no se modifica.

En general, todos los métodos que cambian los datos de instancia de un objeto deben terminar con un `!` (a menos que sea un setter).

## Paso 9/12

`gets` siempre devuelve una cadena. Me gustaría hacer algo de aritmética con la variable `age`, así que necesito convertir la cadena que se obtiene en un número entero.

Se puede convertir la cadena a un número entero llamando al método `to_i` (convertir a un número entero) en el valor de retorno de `gets`.

La captura de pantalla adjunta muestra un aviso para un nombre y una edad y cómo devolverlo al usuario.

![](https://markm208.github.io/rubybook/chapter1/02/media/images/1662646572961-03.png)

## Paso 10/12

```ruby
name = "Markus"
age = 49
puts "#{name}'s age is #{age}"

puts "Enter a new name, I don't like #{name}"
name = gets
name.chomp!

puts "Enter an age"
age = gets.to_i

puts "#{name}'s age is #{age}"

puts

age += 10
puts "In ten years #{name} will be #{age}"
puts
```

Aquí sumo 10 a la edad ingresada y la imprimo nuevamente. Vea la captura de pantalla adjunta.

El operador 'add-and-equals', +=, es equivalente a este código:

```ruby
age = age + 10
```

![](https://markm208.github.io/rubybook/chapter1/02/media/images/1662646649366-04.png)

## Paso 11/12

```ruby
PI = 3.14
puts "Pi is #{PI}"
```

Ruby tiene constantes. Las constantes deben comenzar con una letra mayúscula. Aquí creo una constante para PI y la imprimo.

![](https://markm208.github.io/rubybook/chapter1/02/media/images/1662646739912-05.png)


## Paso 12/12

```ruby
PI = 3.14
puts "Pi is #{PI}"

PI = 3.14159

puts "Pi is now #{PI}"
```

En Ruby, puedes cambiar el valor de una constante (¿wtf?). Sin embargo, si hace, se recibirá un mensaje de advertencia (vea la captura de pantalla adjunta).

Por eso que las variables no constantes deben comenzar con una letra minúscula.

Ruby es un lenguaje realmente interesante. Verá muchas funciones de lenguaje inteligente que no existían antes. Este es un buen ejemplo, simplemente imprime una advertencia cuando cambia una variable que comienza con una letra mayúscula.

![](https://markm208.github.io/rubybook/chapter1/02/media/images/1662646816273-06.png)
