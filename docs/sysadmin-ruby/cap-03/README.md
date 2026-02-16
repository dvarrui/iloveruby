[<< back](../README.md)

1. [Comandos de lectura](#comandos-de-lectura)
2. [Comandos de escritura](#comandos-de-escritura)

# Comandos de lectura

He llamado "comandos de lectura" a aquellos comandos del sistema que nos muestran información sobre el estado del sistema. No hacen cambios en el sistema, sólo leen y nos muestran datos en pantalla.

Desde nuestros script de Ruby podemos usar la instrucción `username = %x[whoami]` para ejecutar el comando `whoami` y el valor devuelto no se muestra en pantalla sino que se almacena en la variable `username`.

Ejemplo [myuser.rb](example/myuser.rb) en Ruby:

```ruby
#!/usr/bin/env ruby
username = %x[whoami].chop
puts "You are #{username}."
```

Ejemplo [myuser.sh](example/myuser.sh) en Bash:

```bash
#!/bin/bash
USERNAME=$(whoami)
echo "You are $USERNAME."
```

Otra forma de conseguir el mismo resultado es usando las "comillas francesas". Ejemplo:

```
myuser = `whoami`
```

Ejemplo [myuser2.rb](example/myuser2.rb) en Ruby:

```ruby
#!/usr/bin/env ruby
username = `whoami`.chop
puts "You are #{username}."
```

Ejemplo [myuser2.sh](example/myuser2.sh) en Bash:

```bash
#!/bin/bash
USERNAME=`whoami`
echo "You are $USERNAME."
```

Ruby es un lenguage de scripting que hereda ideas de Bash. Esta segunda forma también es utilizada en los script de Bash (no es casualidad). Es cómoda, limpia y me gusta... pero no lo voy a usar en esta guía por dos razones:

1. Estas comillas son complicadas de mostrar en un documento Markdown como éste, porque Markdown le da un significado especial.
2. Los principiantes suelen confundir con frecuencia esas comillas con esta otra ' o con las tildes.

Así que... voy a usar la forma `%x[command]` para ejecutar "comandos de lectura" del sistema operativo.

Un uso muy común de esta instrucción, será para comprobar si estamos ejecutando el script con el usuario `root`.

```
> sudo ./myuser.rb
You are root.
```

## Comandos de escritura

Llamaré "comandos de escritura" a aquellos comandos del sistema que al ejecutarse hacen alguna modificación del mismo. Por ejemplo: touch, mkdir, rm, chmod, etc.

> OJO también sirve para invocar comandos de otros sistemas operativos.

Para ejecutar "comandos de escritura" en Ruby, usaremos la instrucción `system("mkdir public")`. Esto invoca al comando del sistema `mkdir public`. Además, `system` devuelve true/false para indicar si la acción se ha podido ejecutar. Normalmente haremos comprobación de posibles errores de la siguiente forma:

```ruby
ok = system("mkdir public")
if ok
  puts "Created public folder!"
else
  puts "ERROR: Can't create public folder!"
end  
```

[next >>](funciones.md)
