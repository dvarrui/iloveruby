[<< back](../README.md)

# Ejecución

Vamos a aprender lo necesario para ejecutar nuestros scripts de Ruby.

## Instalación de Ruby

Para poder probar los ejemplos de esta guía, necesitaremos tener instalado Ruby en nuestro equipo. Este proceso de puede hacer de varias formas, pero aquí lo haremos por comandos:

**Instalación en OpenSUSE**

No es necesario, porque viene instalado por defecto.
* `ruby -v`, para ver la versión de Ruby que tenemos instalada.

**Instalación en Debian/Ubuntu**

* Abrir una consola como usuario root.
* `apt-get install ruby`, para instalar Ruby.
* `apt-get install irb`, para instalar el intérprete interactivo de Ruby.

La herramienta `irb` no es necesaria para ejecutar nuestros scripts de Ruby, pero sí es útil para depurar nuestros scripts y hacer pruebas para conocer mejor el lenguaje. De modo que lo instalaremos también.

## Script helloworld.sh

Es casi una costumbre empezar a aprender un nuevo lenguaje de programación creando el programa HelloWorld. Primero vamos a ver la versión HelloWorld de Bash para luego compararla con Ruby.

Ejemplo de programa [helloworld.sh](example/helloworld.sh) en bash:
```bash
#!/bin/bash
echo "Hello World!"
```

Para ejecutar el programa, hacemos:
* `chmod +x helloworld.sh`, para asignarle permisos de ejecución al fichero.
* `./helloworld.sh`, para ejecutarlo.

Ejemplo:
```console
> ./helloworld.sh
Hello World!
```

El script de Bash es un fichero de texto que contiene principalmente comandos del sistema. Estos comandos se ejecutarán al iniciarse script.

La primera línea del script con `#!`, es un indicativo para saber qué programa será el resposable de ejecutar las instrucciones del script. Los scripts son programas interpretados. Esto es, están en un lenguaje que la máquina no entiende, por tanto se requiere que un programa (intérprete) las lea y las vaya traduciendo al lenguaje de la máquina mientras se ejecutan.

## Script helloworld.rb

Vamos a ver el ejemplo anterior en versión Ruby. Fichero [helloworld.rb](example/helloworld.rb):
```ruby
#!/usr/bin/env ruby
puts "Hello World!"
```

Para ejecutar el programa, podemos hacer `ruby helloworld.rb`. Pero por comodidad vamos a hacer el mismo proceso que con el script de Bash:
* `chmod +x helloworld.rb`, para asignarle permisos de ejecución al fichero.
* `./helloworld.rb`, para ejecutarlo.

## Invocar desde cualquier directorio

Ahora para poder ejecutar nuestro script de `helloworld.rb`, debemos movernos a la carpeta donde está nuestro archivo y hacer `./helloworld.rb`. Es un poco raro, pero con `./` estamos indicando que se ejecute un fichero llamado `helloworld.rb` que está guardado en la carpeta donde nos encontramos ahora mismo.

Si sabemos donde se encuentra nuestro script, podemos ejecutarlo indicando la ruta o trayectoria para llegar a él. Ejemplo:
```
> ls
helloworld.rb  helloworld.sh

> cd ..
> tree
.
├── example
│   ├── helloworld.rb
│   └── helloworld.sh
└── README.md

> ./example/helloworld.rb
Hello World!

```

A veces, esto puede ser un poco molesto. Hay algunos scripts que nos gustaría invocar desde cualquier directorio, sin necesidad de indicar la ruta o trayectoria del script. Para resolver este punto deberíamos aprender más sobre la variable PATH, pero vamos a coger un atajo. Veamos el contenido de la variable PATH:

```
> echo $PATH
/home/david/bin:/usr/local/bin:/usr/bin:/bin
```

Vemos que PATH contiene varias rutas o directorios de búsqueda. Em estos directorios será donde el sistema buscará los comandos o los scripts cuando los invocamos desde la consola sin necesidad de indicar la ruta o trayectoria del fichero.

Para ello, con el usuario root, pondremos el script (o una copia del mismo) en una de dichas rutas del PATH. Por ejemplo:

```
> su
# cp example/helloworld.rb /usr/local/bin/helloworld
# exit

> ls
example  README.md

> helloworld
Hello World!
```

## Resumen

1. Todos los scripts que pongamos en `/usr/local/bin` se podrán invocar desde cualquier directorio.
2. A los scripts de Ruby les podemos quitar la extensión y seguirán funcionando igual de bien (Gracias a la línea `#!`).
3. Daremos permisos de ejecución a los scripts de Ruby, para poderlos ejecutar sin invocar explícitamente al intérprete.

[<< back](../README.md)
