[<< back](../../README.md)

# Los 10 fundamentos

Una pregunta que me hago: _"¿Cuáles serían los 10 fundamentos básicos para transmitir a un programador de otro lenguaje para ayudarle a entender la base de Ruby, y de este modo hacer el camino del aprendizaje un poco más feliz?"_

Pues con esta idea en mente, empiezo a escribir este documento. _¿Por qué 10?_ Pues porque me pareció un número "redondo". Ni mucho, ni poco. A ver si me salen 10, o menos, o más.

1. [Fichero de texto](#fichero-de-texto)
2. [Todo es un objeto](#todo-es-un-objeto)
3. [Tu amigo se llama "irb"]

1. # Fichero de texto

Lo primero es instalar Ruby en tu sistema (¡Lo normal!). A continuación, bastaría con crear un fichero de texto con tu editor favorito y escribir. ¡Ya está! A ver, puedes usar un IDE, VS Code, Codium, o un editor de texto simple como vi, Zed, etc. ¡Lo que quieras!

Esta idea la "copió" Matz del lenguaje Perl, pero es lo mismo en Python, Bash, PHP, JavaScript, etc.

Prueba lo siguiente:

```ruby
# File: holamundo.rb
print("Hola Mundo!\n")
```

Crea un fichero de texto con este contenido y lo ejecutas con `ruby holamundo.rb`. El resultado, será lo que esperas que sea.

* Vemos que para los comentarios usamos `#`, como en otros lenguajes como: Python, Perl, PHP, R, Bash, PowerShell, YAML, Elixir, Crystal, etc.
* Para mostrar un mensaje por consola usamos `print()` como en otros lenguajes: Python, Swift, Kotlin, Lua, Julia, etc.

> **Shebang**: [Definición de Wikipedia](https://es.wikipedia.org/wiki/Shebang)
>
> Por mi comodidad, y como suelo trabajar en GNU/Linux:
>
> * usaré la cabecera "shebang" ()`#!/usr/bin/env ruby`
> * con permisos de ejecución en el fichero (`chmod +x holamundo.rb`)
>
> para poder ejecutar el fichero como `./holamundo.rb`.

El mismo ejemplo con cabecera "shebang":

```ruby
#!/usr/bin/env ruby
# File: holamundo.rb
print("Hola Mundo!\n")
```

2. # Todo es un objeto

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
# Ejemplo: Las clases y los métodos son objetos
age = 55

age.class           #=> Integer
Integer.class       #=> Class
Integer.class.class #=> Class

age.method(:to_s)         #=> #<Method: Integer#to_s(*)>
convertir_a_string = age.method(:to_s) #=> #<Method: Integer#to_s(*)>
convertir_a_string.class  #=> Method
```

# 3. Tu amigo se llama "irb"

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
