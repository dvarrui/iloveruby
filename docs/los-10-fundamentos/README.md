[<< back](../../README.md)

# Los 10 fundamentos

Una pregunta que me hago: 

_"¿Cuáles serían los 10 fundamentos básicos para transmitir a un programador de otro lenguaje, para ayudarle a entender la base de Ruby, y de este modo hacer el camino del Ruby developer un poco más feliz?"_

Pues con esta idea en mente, empiezo a escribir este documento. _¿Por qué 10?_ Pues porque me pareció un número "redondo". Ni mucho, ni poco, "ni para comerse el coco". A ver si me salen 10, + o -.

1. [Fichero de texto](#1-fichero-de-texto)
2. [Tipado fuerte y dinámico](#2-tipado-fuerte-y-dinámico)
3. [Todo es un objeto](#3-todo-es-un-objeto)
4. [Mi amigo IRB](#4-mi-amigo-irb)
5. [Quitando "ruido" visual](#5-quitando-ruido-visual)
6. [Clases y objetos](#6-clases-y-objetos)
7. [Tenemos métodos, no funciones](#7-tenemos-métodos-no-funciones)
8. [Bloques de código](#8-bloques-de-código)
9. [La metaprogramación](#9-la-metaprogramación)

# 1. Fichero de texto

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

> IMHO: El "tipado" es un de los motivos de discordia y/o separación más fuerte en el mundo de los lenguajes de programación... pero sigamos.

Ruby es un lenguaje con **tipado fuerte y dinámico**. Si, dinámico y fuerte. A veces se entiende mal el concepto de tipado fuerte.

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

**Definiciones de tipos**

| Tipado   | Ejemplo                             | Descripción | Lenguajes |
| -------- | ----------------------------------- | ----------- | --------- |
| Débil    | JavaScript: 4 + "2" resulta en "42" | En una operación con dos tipos distintos, el lenguaje intenta "adivinar" la intención del usuario y realiza una conversión implícita (coerción) | JavaScript, PHP, C (en ciertos aspectos de memoria), B (El antecesor de C)|
| Fuerte   | Python: 4 + "2" lanzará un error (TypeError)| No permite operaciones entre tipos diferentes a menos que el programador, haga una conversión explícita (casting) | Python, Java, Ruby, Go, Rust |
| Estático | int i; (Variable de tipo entero)| El tipo de las variables se conoce en tiempo de compilación | Java, Rust, C |
| Dinámico | nombre = "Obi-wan" | El tipo de las variables sólo se sabe en el momento de la ejecución | Ruby, Python, JavaScript, PHP |

# 3. Todo es un objeto

Lo siguiente que debes saber de Ruby, es que "todo es un objeto" (o casi casi todo). Ruby fue creado por Matz inspirándose en List, Perl y Samlltalk. Del Smalltalk de Alan Kay "copió" la idea de que "todo es un objeto" e invocar la ejecución de un método de un objeto es lo mismo que enviarle un mensaje dicho objeto. Por ejemplo: `perro.ladrar()` produce el mismo efecto que `perro.send(:ladrar)`.

> NOTA: `:ladrar` es un símbolo o cadena de texto inmutable. La tienen otros lenguajes de programación. En Elixir las llaman átomos.

Ejemplos con String:

```ruby
# Ejemplo: Cadenas de texto
nombre = "obi-wan kenobi"

nombre.upcase  #=> "OBI-WAN KENOBI"
nombre.split   #=> ["obi-wan", "kenobi"]
nombre.reverse #=> "ibonek naw-ibo"
nombre.class   #=> String
```

Ejemplos con números:

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

Ejemplos con clases:

```ruby
# Ejemplo: Las clases son objetos
age = 55

age.class           #=> Integer
Integer.class       #=> Class
Integer.class.class #=> Class
```

Ejemplos con métodos:

```ruby
# Ejemplo: los métodos son objetos
age.method(:to_s)         #=> Devuelve el método "to_s" del objeto "age"
convertir_a_string = age.method(:to_s) #=> #<Method: Integer#to_s(*)>
convertir_a_string.class  #=> Method
```

# 4. Mi amigo IRB

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

# 6. Clases y objetos

Vamos con el ejemplo:

```ruby
# Ejemplo: Clase Perro
class Perro
  # Este es el constructor de las intancias
  def initialize(name)
    @name = name
  end

  # Método de instancia (Los paréntesis no son necesarios si no hay argumentos)
  def ladrar
    "[#{@name}] Guau!"
  end
end

# Ejemplo: objeto snoopy
snoopy = Perro.new("Snoopy")
puts snoopy.ladrar
```

En Ruby por defecto:
* Los métodos son públicos, a menos que especifiquemos los contrario. Para hacerlos privados se usa la palabra reservada `private`
* Los atributos son privados, siempre. Para acceder desde fuera hay que crear los "getters" y "setters".
    * `attr_reader :name`: crea un getter `name()`
    * `attr_writter :color`: crea un getter `color=(value)`
    * `attr_accssor :name`:  crea el getter y el setter.

> Otra cosa "extraña" a primera vista. Las variables que son los atributos del objeto comienzan con `@`. Por ejemplo, `@name` es el atributo name del objeto y `name` será un nombre de variable local y/o método, y `name()` es un nombre de método.

Vamos con otro ejemplo:

```ruby
# Ejemplo: Clase Gato

class Gato
  # Crear getter/setter para name y color
  attr_accessor :name, :color
  
  def mauyar
    "[#{@name}] Miau!"
  end

  def to_s
    "Gato: name=#{@name}, color=#{@color}"
  end
end
  
# Ejemplo: objeto garfield
garfield = Gato.new
garfield.name = "Garfield"
garfield.color = "naranja con rayas negras"
puts garfield.mauyar
puts garfield
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

Los nombres de los métodos pueden tener letras, números, guiones bajos, interrogantes, exclamaciones, emojis, etc.

Ejemplos:

```ruby
name = "Obi-wan Kenobi"
name.class    #=> String

# Los métodos con ! suelen modificar el objeto original
name.upcase   #=> "OBI-WAN KENOBI"
name          #=> "Obi-wan Kenobi"
name.upcase!  #=> "OBI-WAN KENOBI"
name          #=> "OBI-WAN KENOBI"

name.ascii_only? #=> true
```

```ruby
# Ejemplo con emojis

Δ = 1
b = 2

puts Δ
puts b

い = "hola"
puts い 
```

# 8. Bloques de código

En Ruby, casi todo es un objeto, y por ejemplo los bloques de código también lo son. Hay varias formas de escribir estos objetos de código o bloques de código. A veces nos puede interesar utilizar un estilo u otro dependiendo del caso, por lo que nos la podemos encontrar escrita de diferentes formas. Vamos al caso más común.

Lo más común es usar los delimitadores `{ ... }` o `do ... end` para definir los bloques de código. Se puede usar cuaquiera de las dos, pero los RubyLovers siguen el siguiente patrón:
* `{ ... }` para bloques de código de una línea.
* `do ... end` para bloques de código de varias líneas.

Los bloques se usan mucho mucho mucho, y sobre todo en conjunción con los métodos iteradores de modo que se puede implementar el [patrón estrategia](https://refactoring.guru/es/design-patterns/strategy) de una forma muy natural al lenguaje.

Ejemplos:

```ruby
3.times { puts "I love Ruby" }

# Salida: Muestra 3 veces por pantalla el mensaje "I love Ruby"
#
# Explicación:
# - El objeto 3, tiene un método "times(block)" que acepta como argumento un bloque de código
# - El bloque de código pasado como argumento ejecuta "puts 'I love Ruby'" 
```

```ruby
names = ["obiwan", "yoda", "luke"]

names.each do |name|
   puts "---"
   puts "#{name.capitalize} dice:"
   puts "¡Que la fuerza te acompañe!"
end

# Salida:
#
# ---
# Obiwan dice:
# ¡Que la fuerza te acompañe!
# ---
# Yoda dice:
# ¡Que la fuerza te acompañe!
# ---
# Luke dice:
# ¡Que la fuerza te acompañe!

# Explicación:
# - El objeto Array "names", tiene un método "each()"
# - El método "each(block)" acepta un bloque como argumento
#   y lo ejecuta en cada uno de los elementos de Array
#
# (El método "each()" es un iterador)
```

# 9. La metaprogramación
