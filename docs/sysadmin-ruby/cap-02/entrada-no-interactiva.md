[<< back](README.md)

# Entrada de datos NO interactiva (offline)

La forma más común de introducir datos al script de forma no interactiva es usando el paso por parámetros. Veamos un ejemplo:

```ruby
#!/usr/bin/env ruby
name = ARGV.first
puts "Hello #{name.capitalize}!"
```

Ejemplo de uso del script [greet.rb](example/greet.rb):
```
> ./greet.rb quigon
Hello Quigon!
```

Vemos que en el código se hace uso de `ARGV`. Este objeto contiene una lista con todos los argumentos que se pasan al script durante la ejecución. En el ejemplo anterior `ARGV = [ 'quigon' ]`, es una lista con un único elemento.

Para acceder al primer elemento de una lista (o Array) podemos hacer `ARGV.first` o `ARGV[0]`. Esta segunda forma es igual en otros lenguajes de programación. El primer elemento de una lista es el elemento 0, luego el 1, etc.

## Control de errores con el operador ||

¿Qué pasa si no pasamos el argumento al invocar al script? Veamos:

```
> ./greet.rb
Traceback (most recent call last):
./greet.rb:3:in `<main>': undefined method `capitalize' for nil:NilClass (NoMethodError)
```

Bueno... tenemos un error cuando el script intenta mostrar por pantalla un contenido que no existe... Esto lo podemos prevenir, añadiendo un valor por defecto cuando no existe. Veamos [greet2.rb](example/greet2.rb) en ejecución:

```
> ./greet2.rb yoda
Hello Yoda!

> ./greet2.rb
Hello Unknown!
```

Este es el código:
```ruby
#!/usr/bin/env ruby
name = ARGV.first || 'Unknown'
puts "Hello #{name.capitalize}!"
```

El cambio que hemos hecho ha sido `name = ARGV.first || 'Unknown'`. Esto significa, añade un valor o contenido a la variable `name`. Primero lo intentas con `ARGV.first`, y si va mal, lo intentas con `Unkown`. Si estás acostumbrado a usar comandos concatenados en la consola del sistema operativo, entonces, ya estarás acostumbrado al uso del operador `||` para concatenar operaciones. Pues es esto funciona igual.
Veamos un ejemplo con comandos:

```
> false          
> false || false || echo "3" || echo "4"
3

> echo "1" || false || echo "3" || echo "4"
1
```

En el ejemplo anterior, se concatenan varios comandos con el operador `||`, y desde que uno devuelva OK (código de salida 0) se termina la secuencia. En caso contrario se sigue por el siguiente comando.

Bueno, pues esta misma idea se ha llevado también a los scripts de Ruby. Pero si no te gusta esto operador, también podemos usar las estructuras condicionales `if`, `unless` o `case`.

> INFO: Los códigos de salida de los comandos (o scripts) serán muy útiles para crear órdenes complejas a partir de secuencias de comandos sencillos, uniéndolos mediante los operadores `||`, `&&` y `;`.

## Control de errores con unless

En este ejemplo [greet3.rb](example/greet3.rb), tenemos que:
* Cuando no hay contenido para `ARGV.first`, entonces se muestra un mensaje en pantalla informado de cómo se usa el script y se termina con ERROR (código de salida 1).
* Cuando `ARGV.first` tiene contenido se saluda a `name`.

```ruby
#!/usr/bin/env ruby
if not ARGV.first
  puts "Usage: #{$0} NAME"
  exit 1
end

name = ARGV.first
puts "Hello #{name.capitalize}!"
```

La instrucción `exit` hace que termine el script inmediatamente. Esta instrucción se acompaña de un valor numérico. Donde:
* `exit 0`, el script terminó correctamente.
* `exit 1`, el script terminó con error.

> Otros valores diferentes de 0 se podrían usar para indicar distintos tipos de errores.

Si el programa acaba de forma natural se asume que terminó de forma correcta, o lo que es lo mismo con un `exit 0`. Estos códigos de salida son muy útiles en los comandos (o nuestros scripts) para poder hacer combinaciones o secuencias de comandos. Veamos ejemplo:

```
> ./greet3.rb yoda || echo "ok"
Hello Yoda!

> ./greet3.rb || echo "FAIL"   
Usage: ./greet3.rb NAME
FAIL
```

En el primer caso el código de terminación es 0 (correcto) y no se llega a mostrar el texto "OK". En el segundo es 1 (error), y por eso la secuencia continúa con el siguiente comando y se llega a mostrar pantalla el mensaje "FAIL".

## Resume

Hemos aprendido:
1. Introducir datos al script usando los argumentos (`ARGV`).
2. Se deben controlar posibles errores en la entrada de datos (`if`, `unless`, etc.).
3. Al terminar usamos `exit 0` o `exit 1` para indicar si el script ha terminado correctamente, o ha habido algún problema.

[next >>](entrada-de-numeros.md)
