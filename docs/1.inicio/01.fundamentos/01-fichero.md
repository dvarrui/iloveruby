[<< back](./README.md)

# 1. Fichero de texto

Lo primero es instalar Ruby en tu sistema (¡Lo normal!).

```
Para empezar, un fichero de texto es suficiente. 
Lo bueno es que se requiere poco para empezar.
```

Basta con crear un fichero de texto con tu editor favorito y escribir. ¡Ya está! A ver, puedes usar un IDE como Codium, o editores de texto plano como vi, Zed, Notepad, etc. ¡Lo que quieras! Esta idea la "cogió" Matz del lenguaje Perl, pero es lo mismo en Python, Bash, PHP, JavaScript, etc. En general lo lenguajes dinámicos tienen esa característica.

Prueba lo siguiente:

```ruby
# File: holamundo.rb
print("Hola Mundo!\n")
```

Crea un fichero de texto con este contenido, y lo ejecutas con `ruby holamundo.rb`. El resultado, será lo que esperas que sea.

* Para los comentarios usamos `#`, como en otros lenguajes como: Python, Perl, PHP, R, Bash, PowerShell, YAML, Elixir, Crystal, etc.
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

---
[next >>](./02-tipado.md)