[<< back](README.md)

## 3. Separar el código de los datos

Para mejorar el problema del script anterior, Vamos a nacesitar 2 ficheros:
1. Un script que realiza la instalación o de los paquetes.
2. Un fichero de texto que contenga el listado de los paquetes.

Cuando terminemos tendremos un script que no cambia y un fichero de texto que se personaliza para cada usuario y/o instalación.

**Entrada de datos**

Primero necesitamos definir la entrada de datos. Esta va a ser un fichero de texto que contenga la lista de todos los paquetes que queremos instalar. Ejemplo [package-list.txt](example/package-list.txt)

```
tree
vim
gedit
nmap
```

**Script**

Ahora haremos un script [softwarectl3.rb](example/softwarectl3.rb) que lea el contenido del fichero. Separe cada línea para identificar el nombre de cada paquete y luego ejecute los comandos necesarios para instalar dicho paquete.

```
> ./softwarectl3.rb                                 
Usage: ./softwarectl.rb FILENAME
       FILENAME is a text file with a list of package names.

> sudo ./softwarectl3.rb package-list.txt
```

---
## 4. Añadiendo controles al proceso de instalación

Con el script anterior, me pasa mucho que me despisto, no inicio sesión como `root` y tengo que leer una lista enorme de mensajes de error.

```
> ./softwarectl3.rb package-list.txt

Se requieren privilegios de administrador (root) para ejecutar este comando.
[ERROR] Package 'tree' not installed!
Se requieren privilegios de administrador (root) para ejecutar este comando.
[ERROR] Package 'vim' not installed!
Se requieren privilegios de administrador (root) para ejecutar este comando.
[ERROR] Package 'gedit' not installed!
Se requieren privilegios de administrador (root) para ejecutar este comando.
[ERROR] Package 'nmap' not installed!
```

Así que vamos a crear [softwarectl4.rb](example/softwarectl4.rb), donde vamos a controlar:
1. Existe el fichero de entrada.
2. Se haya iniciado sesión con el usuario `root`.


```ruby
##
# Check input file exist
unless File.exist?(ARGV.first)
  puts "[ERROR] File \'#{ARGV.first}\' dosn\'t exist!".light_red
  exit 1
end

##
# Check current user
unless %x[whoami].chop == 'root'
  puts "[ERROR] Run as \'root\' user!"
  exit 1
end
```

**colorize**

Se me ocurre además, que podría dar un toque de "color" a los mensajes de nuestros scripts. Sobre todo para remarcar aquellas partes que deban destacarse y poner en rojo lo errores. Para esto vamos a instalar una librería o gema Ruby llamada "colorize".

* `sudo gem install colorize`, para instalar la gema (librería) colorize en nuestro sistema.

Veamos cómo usamos "colorize":

```ruby
#!/usr/bin/env ruby
require 'colorize'

##
# Check input arguments
if ARGV.empty?
  puts "Usage: #{$0} FILENAME"
  puts "       FILENAME is a text file with a list of package names."
  exit 1
end

##
# Check current user
unless %x[whoami].chop == 'root'
  puts "[ERROR] Run as \'root\' user!".light_red
  exit 1
end
```

Explicación:
* Con `require 'colorize'` cargamos la librería (o gema) Rainbow.
* `puts "ERROR".light_red`, muestra el texto ERROR coloreado en rojo brillante.

Si quieres ver qué otras funciones o colores tiene "colorize", lee [este enlace](https://github.com/fazibear/colorize).

Tenemos que:
1. El script muestra una ayuda cuando se ejecuta sin parámetros.
2. Muestra un error cuando no se ejecuta con el superusuario root.
3. Instala los paquetes del fichero que se pasa por parámetros.

## 5. Organización

Seguramente seré un maniático... pero voy a organizar mejor el código para que sea más legible. Voy a organizarlo agrupando el código en bloques, y luego creando los métodos.

> **IMPORTANTE**: Los nombres de los métodos deben ser verbos en inglés que indiquen la acción que se va a ejecutar dentro del mismo.

Vemos que en el script [softwarectl5.rb](example/softwarectl5.rb) se han creado 2 métodos:
* `check_arguments`, comprobar los argumentos de entrada.
* `install_packages`, leer e instalar los paquetes.

¿Por qué he creado 2 métodos?... Realmente no hay un regla estricta al respecto. Podía haber hecho 2, 3 o 4... pero lo que intenté fue agrupar el código en bloques (no muy grandes) que tengan sentido por sí mismos (Sentido para mí, al menos).

> **Mi truco para agrupar el código:**
>
> Normalmente me guío o me apoyo por el nombre del método. Esto es, si puedo poner un nombre de método rápidamente y que de forma clara defina y explique bien el contenido que representa, entonces opino que he agrupado bien el código dentro de dicho método. Si por el contrario, veo que pierdo mucho tiempo en decidir un nombre apropiado para el método o lo pongo y no me termina de gustar porque no representa con claridad su contenido... entonces sé que no he hecho una correcta agrupación y/o bloque y debo agrupar de otra forma.
