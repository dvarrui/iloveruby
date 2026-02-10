[<< back](../../README.md)

# Los 10 fundamentos

Una pregunta que me hago: 

_"¿Cuáles serían los 10 fundamentos básicos para transmitir a un programador de otro lenguaje, para ayudarle a entender la base de Ruby, y de este modo hacer el camino del Ruby developer un poco más feliz?"_

Pues con esta idea en mente, empiezo a escribir este documento. _¿Por qué 10?_ Pues porque me pareció un número "redondo". Ni mucho, ni poco, "ni para comerse el coco". A ver si me salen 10, + o -.

1. [Todo es texto](#1-todo-es-texto)
2. [Tipado fuerte y dinámico](#2-tipado-fuerte-y-dinámico)
3. [Todo es un objeto](#3-todo-es-un-objeto)
4. [Tu amigo se llama "irb"](#4-tu-amigo-se-llama-irb)
5. [Creando clases y objetos](#5-creando-clases-y-objetos)
6. [El "idioma" Ruby](#6-el-idioma-ruby)
7. [Tenemos métodos, no funciones](#7-tenemos-métodos-no-funciones)

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
print("Hola Mundo!\n")
```

# 2. Tipado fuerte y dinámico

Ruby es un lenguaje con **tipado fuerte y dinámico**.

Ejemplo:

```ruby
texto = "4"
texto.class #=> String

numero = 2
numero.class #=> Integer

texto + numero #=> Error: `+': no implicit conversion of Integer into String (TypeError)

texto + numero
        ^^^^^^
	from (irb):5:in `<main>'
	from /home/david/.rbenv/versions/3.2.8/lib64/ruby/gems/3.2.0/gems/irb-1.16.0/exe/irb:9:in `<top (required)>'
	from /home/david/.rbenv/versions/3.2.8/bin/irb:25:in `load'
	from /home/david/.rbenv/versions/3.2.8/bin/irb:25:in `<main>'
>> texto + numero.to_s
=> "42"
>> texto.to_i + numero
=> 6
```

## 2.1 Tipado Débil (INFO)

La diferencia entre tipado fuerte vs débil es una de las distinciones más confusas porque, no existe una definición formal única. Sin embargo, en el día a día de la programación, se refiere a qué tan permisivo es el lenguaje con las operaciones entre tipos diferentes.

Si se intenta realizar una operación con dos tipos distintos (como un número y un texto), el lenguaje intenta "adivinar" tu intención y realiza una conversión implícita (coerción).

* El ejemplo clásico en JavaScript: 4 + "7" resulta en "47". El lenguaje convierte el 4 en texto automáticamente.
* Problema: Puede ocultar errores lógicos que solo detectarás con tests de funcionamiento. El programa no "explota", pero da un resultado absurdo.
* Lenguajes: JavaScript, PHP, C (en ciertos aspectos de memoria), B (El antecesor de C).

## 2.2 Tipado Fuerte (Ruby)

No permite operaciones entre tipos diferentes a menos que tú, como programador, hagas una conversión explícita (casting).

* El ejemplo (Python): 4 + "7" lanzará un error (TypeError). El lenguaje dice: "No sé cómo sumar un número y un texto, dime qué quieres hacer exactamente".
* Ventaja: Detecta el error en el momento en que ocurre.
* Lenguajes: Python (aunque es dinámico, es fuerte), Java, Ruby, Go, Rust.

## 2.3 Tipado estático (INFO)

El tipo de las variables se conoce en tiempo de compilación.

## 2.4 Tipado dinámico (Ruby)

El tipo de las variables sólo se sabe en el momento de la ejecución.


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
# Ejemplo: Las clases y los métodos son objetos
age = 55

age.class           #=> Integer
Integer.class       #=> Class
Integer.class.class #=> Class

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

# 5. Creando clases y objetos

Vamos con el ejemplo:

```ruby
# Ejemplo: Clase Perro y objeto snoopy
class Perro
  def initialize(name)
    @name = name
  end

  def ladrar()
    retrun "[#{@name}] Guau!"
  end
end

snoopy = Perro.new("Snoopy")
puts(snoopy.ladrar())
```

# 5. El "idioma" Ruby

# 7. Tenemos métodos, no funciones

En Ruby, estrictamente hablando, no hay funciones. No hay porque todo son métodos. Incluso cuando parece que no hay ningún objeto en "la sala", estamos dentro de uno.