[<< back](../../README.md)

# Los 10 fundamentos

Una pregunta que me hago: 

_"¿Cuáles serían los 10 fundamentos básicos para transmitir a un programador de otro lenguaje, para ayudarle a entender la base de Ruby, y de este modo hacer el camino del Ruby developer un poco más feliz?"_

Pues con esta idea en mente, empiezo a escribir este documento. _¿Por qué 10?_ Pues porque me pareció un número "redondo". Ni mucho, ni poco, "ni para comerse el coco". A ver si me salen 10, + o -.

1. [Todo es texto](#1-todo-es-texto)
2. [Tipado fuerte y dinámico](#2-tipado-fuerte-y-dinámico)
3. [Todo es un objeto](#3-todo-es-un-objeto)
4. [Tu amigo se llama "irb"](#4-tu-amigo-se-llama-irb)
5. [Quitando "ruido" visual](#5-quitando-ruido-visual)
6. [Clases y objetos](#6-clases-y-objetos)
7. [Tenemos métodos, no funciones](#7-tenemos-métodos-no-funciones)
8. [La metaprogramación](#8-la-metaprogramación)

# 1. Todo es texto

Lo primero es instalar Ruby en tu sistema (¡Lo normal!).

A continuación, bastaría con crear un fichero de texto con tu editor favorito y escribir. ¡Ya está! A ver, puedes usar un IDE como VS Code, Codium, o un editor de texto plano como vi, Zed, Notepad, etc. ¡Lo que quieras! Esta idea la "cogió" Matz del lenguaje Perl, pero es lo mismo en Python, Bash, PHP, JavaScript, etc.

Prueba lo siguiente:

```ruby
# File: holamundo.rb
print("Hola Mundo!\n")
```

Crea un fichero de texto con este contenido, y lo ejecutas con `ruby holamundo.rb`. El resultado, será lo que esperas que sea.

* Vemos que para los comentarios usamos `#`, como en otros lenguajes como: Python, Perl, PHP, R, Bash, PowerShell, YAML, Elixir, Crystal, etc.
* Para mostrar un mensaje por consola usamos `print()` como en otros lenguajes: Python, Swift, Kotlin, Lua, Julia, etc.

> **Shebang**: [Definición de Wikipedia](https://es.wikipedia.org/wiki/Shebang)
>
> Por mi comodidad, y como suelo trabajar en GNU/Linux:
>
> * usaré la cabecera "shebang" (`#!/usr/bin/env ruby`)
> * con permisos de ejecución en el fichero (`chmod +x holamundo.rb`)
>
> y ahora puedo ejecutar el fichero directamente como `./holamundo.rb`.

Este es el mismo ejemplo pero con cabecera "shebang":

```ruby
#!/usr/bin/env ruby
# File: holamundo.rb
puts("Hola Mundo!")
```

# 2. Tipado fuerte y dinámico

Ruby es un lenguaje con **tipado fuerte y dinámico**.

Ejemplo:

```ruby
# Tipo dinámico: el tipo de la variable sólo se sabe en tiempo de ejecución
texto = "4"
texto.class   #=> String

numero = 2
numero.class   #=> Integer

# Tipado fuerte
texto + numero #=> Error: `+': no implicit conversion of Integer into String (TypeError)

# Casting: conversión de tipo explícita
texto + numero.to_s   #=> "42"
texto.to_i + numero   #=> 6
"Quiero #{numero} manzanas" #=> "Quiero 2 manzanas"
```

| Tipado   | Ejemplo                             | Descripción | Lenguajes |
| -------- | ----------------------------------- | ----------- | --------- |
| Débil    | JavaScript: 4 + "2" resulta en "42" | En una operación con dos tipos distintos, el lenguaje intenta "adivinar" la intención del usuario y realiza una conversión implícita (coerción) | JavaScript, PHP, C (en ciertos aspectos de memoria), B (El antecesor de C)|
| Fuerte   | Python: 4 + "2" lanzará un error (TypeError)| No permite operaciones entre tipos diferentes a menos que el programador, haga una conversión explícita (casting) | Python, Java, Ruby, Go, Rust |
| Estático | int i; (Variable de tipo entero)| El tipo de las variables se conoce en tiempo de compilación | Java, Rust, C |
| Dinámico | nombre = "Obi-wan" | El tipo de las variables sólo se sabe en el momento de la ejecución | Ruby, Python, JavaScript, PHP |

# 3. Todo es un objeto

Lo siguiente que debes saber de Ruby, es que "todo es un objeto" (o casi casi todo). Ruby fue creado por Matz inspirándose en List, Perl y Samlltalk. Del Smalltalk de Alan Kay "copió" la idea de que "todo es un objeto" e invocar la ejecución de un método en un objeto es lo mismo que enviarle un mensaje. Por ejemplo: `perro.ladrar()` produce el mismo efecto que `perro.send(:ladrar)`.

Ejemplos:

```ruby
# Ejemplo: Cadenas de texto
nombre = "obi-wan kenobi"

nombre.upcase  #=> "OBI-WAN KENOBI"
nombre.split   #=> ["obi-wan", "kenobi"]
nombre.reverse #=> "ibonek naw-ibo"
nombre.class   #=> String
```

```ruby
# Ejemplo: Números
age = 55

age.pred  #=> 54
age.next  #=> 56
age.to_s  #=> "55"
age.between?(1, 100) #=> true
age.class #=> Integer
```

No existe la separación entre tipos de datos primitivos y objetos. Todo son objetos (o casi todo)

```ruby
# Ejemplo: Las clases son objetos
age = 55

age.class           #=> Integer
Integer.class       #=> Class
Integer.class.class #=> Class

# Ejemplo: los métodos son objetos
age.method(:to_s)         #=> #<Method: Integer#to_s(*)>
convertir_a_string = age.method(:to_s) #=> #<Method: Integer#to_s(*)>
convertir_a_string.class  #=> Method
```

# 4. Tu amigo se llama "irb"

IRB (Interactive Ruby), es lo que técnicamente llamamos un REPL (Read-Eval-Print Loop o Bucle de Lectura-Evaluación-Impresión). Es el sueño de cualquier programador que odia esperar: escribes una línea, pulsas Enter y ves el resultado al instante, sin archivos de por medio. Esta idea la "copió" Matz de List.

Otros lenguajes también lo tienen como: Python(`python`), JavaScript(`node`), Elixir(`iex`), Haskell(`ghci`), Closure, PHP(`php -a`), Java(`jshell`), C#(`csi`), etc.

Iniciamos una sesión IRB con el comando `irb`, terminamos con `exit` o `quit`:

```console
$ irb  

irb(main):001> nombre = "Obi-Wan Kenobi"
=> "Obi-Wan Kenobi"

irb(main):002> nombre.upcase
=> "OBI-WAN KENOBI"

irb(main):003> nombre.split
=> ["Obi-Wan", "Kenobi"]

irb(main):004> quit
```

Si escribimos la variable y el punto, IRB espera un método pero con TAB se muestra una ayuda:

![](./images/irb-help.png)

# 5. Quitando "ruido" visual

Ruby además tiene algunas "particularidades" que permiten que el lenguaje se "acerque" al lenguaje natural (el inglés). Por ejemplo:

1. Los paréntesis se pueden omitir si la expresión se entiende bien sin ellos. Por defecto, no los pondremos.
2. La sentencia `return` al final de un método, se puede omitir porque se asume que el valor de la última expresión evaluada será el valor devuelto por el método.
3. Casi todas las sentencias son expresiones y por tanto siempre (o casi siempre) se devuelve algún valor.

Ejemplos:

```ruby
nombre = "Obi-wan"
# (1) Los paréntesis sobran la mayoría de las veces
nombre.upcase #=> "OBI-WAN" 
puts nombre   #=> Muestra "Obi-wan" por el terminal

# (2) La sentencia return sobra al final del método
def suma(a, b)
  a + b
end

# (3) Casi todo es una expresión
persona = if age >= 18
  "Adulta"
else
  "Menor"
end
```

# 6. Clases y objetos

Vamos con el ejemplo:

```ruby
# Ejemplo: Clase Perro
class Perro
  # Este es el constructor de las intancias.
  def initialize(name)
    @name = name
  end

  def ladrar
    "[#{@name}] Guau!"
  end
end

# Ejemplo: objeto snoopy
snoopy = Perro.new("Snoopy")
puts snoopy.ladrar
```

# 7. Tenemos métodos, no funciones

En Ruby, estrictamente hablando, no existen las funciones. No hay porque todo son métodos. Incluso cuando parece que no hay ningún objeto en "la sala", estamos dentro de uno.

Ejemplo:

```ruby
# Ejemplo: factorial recursivo
def factorial(n)
  return 1 if n <= 1
  n * factorial(n -1)
end

puts factorial(3)   #=> 3! = 3*2*1 = 6
```

Aparentemente, se puede pensar que `factorial()` es una función. Pero vamos a añadir unas líneas más para inspeccionar el "contenedor".

```ruby
#!/usr/bin/env ruby
# Ejemplo: factorial recursivo
def factorial(n)
  return 1 if n <= 1
  n * factorial(n -1)
end
  
puts factorial(3)     #=> 3! = 3*2*1 = 6

# Inspeccionando el "contenedor"
puts self                  #=> main
puts self.class            #=> Object
puts Object.ancestors.to_s #=> >> [Object, Kernel, BasicObject]
```

Esto es, el código del factorial se escribió dentro de una instancia `main` que es de la clase `Object`. A su vez, y sólo por curiosidad, vemos que la clase `Object` hereda de `Kernel` y éste a su vez de `BasicObject`. Es bastante probable que `BasicObject` sea la raíz o el padre último de todos los objetos de Ruby.

> Bueno, está claro que todo es un objeto y que hay que programar Ruby siguiendo la filosofía de la POO (Programación Orientada a Objetos).

# 8. La metaprogramación
