[<< back](README.md)

# Multiplataforma

Despues de acabar el script anterior para crear/eliminar usuarios en nuestro SO GNU/Linux se nos ocurre pensar...
* ¿Podría servir este script para otros sistemas operativos?
* En caso contrario ¿se podría adaptar de forma sencilla? o
* ¿Debemos crear otro script desde cero?

Vemos que el script tiene dos tipos de instrucciones:
* **Instrucciones escritas en Ruby** y que implementan la lógica del script (algoritmo de programación). Este algoritmo se encarga que resolver nuestro problema concreto. Esto es: Verificar argumentos de entrada, leer los datos de entrada desde fichero y procesar los datos (usuarios).
* **Comandos específicos del sistema operativo** que son los que finalmente interactúan con el sistema. En nuestro script son: `cat`, `useradd` y `userdel`.

Puesto que Ruby se puede instalar en cualquier plataforma, si queremos hacer una versión del script independiente del sistema operativo, podríamos resolver el problema sustituyendo todos los comandos específicos por instrucciones de Ruby.

## Sustitución de comandos específicos

Para la lectura del fichero de entrada habíamos usado el comando `cat` para ver el contenido, y luego `split` para separar las líneas. Ahora sustituiremos el comando por instrucciones propias de Ruby. Esto es, usando la instrucción `File.read(FILENAME)`.

Veamos un ejemplo de uso con `irb` (Interface interactiva):
* Leemos el contenido del archivo `list-users.txt`, y obtenemos un String `a` con todo el contenido del fichero de texto:
```
> irb
irb> a = File.read('list-users.txt')
=> "#Action:Username:Password:HomeFolder:Shell\ncreate:obiwan:123456:/home/obiwan:/bin/bash\ncreate:luke:::\ndelete:vader:::\n"

irb> a.class
=> String
```
* Descomponemos el String `a` en varias líneas, y obtenemos un Array `b`:
```
irb> b = a.split("\n")
=> ["#Action:Username:Password:HomeFolder:Shell", "create:obiwan:123456:/home/obiwan:/bin/bash", "create:luke:::", "delete:vader:::"]

irb> b.class
=> Array

irb> b.size
=> 4

irb> b[0]
=> "#Action:Username:Password:HomeFolder:Shell"

irb> b[1]
=> "create:obiwan:123456:/home/obiwan:/bin/bash"
```
* El Array `b` contiene 4 elementos, que son las 4 líneas del fichero de entrada `list-users.txt`, pero la primera línea no la necesitamos. Es una línea que empieza por `#` y no se debe tener en cuenta.
```
irb> b.delete_at(0)
=> "#Action:Username:Password:HomeFolder:Shell"

irb> b.size
=> 3

irb> b
=> ["create:obiwan:123456:/home/obiwan:/bin/bash", "create:luke:::", "delete:vader:::"]
```

Veamos ahora cómo lo integramos todo:

```ruby
  # Read input file => Array with file content
  lines = File.read(filename).split("\n")

  # Remove first line with field names
  lines.delete_at(0)

  # Iterate "lines"
  lines.each do |line|
    ...
  end
```

* Primero leemos el contenido del fichero `File.read(filename)`, y usando `split("\n")` separamos cada línea. Obtenemos como resultado un Array de líneas que guardamos en `lines`.

> Tenemos el script modificado en [userctl4.rb](example/userctl4.rb).

## Comandos que no se pueden sustituir

En nuestro ejemplo tenemos comandos del sistema que no podemos sustitutir por instrucciones de Ruby (`useradd` y `userdel`). Si queremos ejecutar este script en otro sistema operativo tendremos que cambiar estos comandos. Por tanto, vamos a seguir otro camino. Vamos tratar de detectar el sistema operativo donde se está ejecutando el script, para tener lo comandos que podemos usar.

## Detectar el sistema operativo

Para detectar el sistema operativo desde Ruby, podemos hacerlo de muchas formas. Lo que veo más sencillo, es instalar la gema **OS** (`gem install os`) y a partir de ahí la usamos.

```
> irb

irb> require 'os'
irb> OS.windows?
=> false

irb> OS.linux?
=> true
```

Bien, modifiquemos el script para tener en cuenta el sistema operativo.

## Script multiplataforma

Modificamos el script anterior para detectar el sistema operativo antes de ejecutar los comandos del sistema. Como el script ha crecido demasiado... lo dividimos en dos ficheros: userctl5 y lib-userctl5.

En el fichero principal ([userctl5.rb](example/usertcl5.rb)) tenemos:
* Se "incluye" el código de nuestro fichero auxiliar/librería (`require_relative 'lib-userctl5'`).
* Definimos las funciones `check_arguments`, `read_input_data` y `process_users`.
* Se invoca el código principal del script:
```
filename = check_arguments
process_users(read_input_data(filename))
```

En el fichero auxiliar/librería ([lib-userctl5.rb](example/lib-usertcl5.rb) tenemos definidas las siguientes funciones:
* create_user
* create_user_on_linux
* create_user_on_windows
* delete_user
* delete_user_on_linux
* delete_user_on_windows

Esta librería está preparada para ampliarse con definiciones de nuevos comandos para diferentes sistemas operativos.

[>> next](filtrado.md)
