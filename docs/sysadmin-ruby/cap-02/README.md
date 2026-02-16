[<< back](../README.md)

# Entrada de datos

En el ejemplo `helloworld.rb` del capítulo anterior, teníamos un script que generaba una salida a pantalla pero no recibía datos de entrada. Vamos a ver ahora ejemplos que reciben entrada de datos por parte del usuario.

## Entrada de datos interactiva (online)

Queremos hacer un script que nos salude, pero claro, necesita saber nuestro nombre. Ejemplo:

```
#!/usr/bin/env ruby
puts "Hello David!"
```

Bueno, este script sólo funciona si te llamas David... Vamos a hacer que el script nos pregunte nuestro nombre y luego nos salude.

Ejemplo ejecutando el script dos veces:
```
> ./greet-asking.rb
What's your name? obiwan
Hello Obiwan!

> ./greet-asking.rb
What's your name? OBIWAN
Hello Obiwan!
```

> Recordar que hay que dar permisos de ejecución al script con `chmod +x greet-asking.rb`

Ejemplo [greet-asking.rb](example/greet-asking.rb):
```ruby
#!/usr/bin/env ruby
print "What's your name? "
name = gets.chop
puts "Hello #{name.capitalize}!"
```

> NOTA: [greet-asking.sh](example/greet-asking.sh) es el mismo script, pero escrito usando Bash.

## Destripando un poco el contenido del script

* `print "What's your name?"`, muestra un mensaje en pantalla. Es igual que `puts` pero se continúa en la línea actual. Esto es, no hay salto de línea.
* `name = gets.chop`, `gets` se queda esperando a que escribamos algo por teclado y pulsemos la tecla enter ("\n"). Luego `gets.chop` elimina el último carácter que hemos escrito (La tecla enter) y finalmente `name = gets.chop` se guarda lo que hemos escrito en una variable llamada `name`.

Hay mucha información o muchos pasos en la instrucción anterior. Vamos a usar el intérprete interactivo `irb` para realizar una simulación paso a paso del proceso anterior:

```
> irb

irb> input = gets
obiwan
=> "obiwan\n"

irb> name = input.chop
=> "obiwan"

irb> quit
```

Vemos que gets lee de teclado `obiwan\n` y lo guardamos en la valriable `input`. Luego guardamos en la variable `name` el resultado de aplicar chop a `input`. chop elimina el último carácter. Esto es, el `\n`.

## Métodos de los String

Los String son las cadenas de texto. En nuestro caso, el nombre del usuario es una cadena de texto (String). No tenemos por qué saberlo, pero al usar Ruby estamos utilizando programación orientada a objetos. Esto es, casi todo en Ruby son objetos. Los objetos pertenecen a clases y tienen métodos para hacer muchas acciones sobre el objeto.

En el ejemplo anterior `name` es un objeto de tipo (clase) String. Todos los String tienen disponible el método `chop`. Veamos una sesión con `irb`:


```
> irb

irb> name = gets
quigon
=> "quigon\n"

irb> name.chop
=> "quigon"

irb> name.class
=> String
```

Ir a [ruby-doc.org](https://ruby-doc.org/core-2.6.5/String.html) para consultar la documentación de los métodos/funciones disponibles de los objetos de las clase String.

Vemos el uso de otros métodos de un String:
```
> irb
irb> name = "obiwan"
=> "obiwan"

irb> name.capitalize
=> "Obiwan"

irb> name.upcase
=> "OBIWAN"

irb> name.downcase
=> "obiwan"

irb> name.reverse
=> "nawibo"

irb> name.size
6
```

## Interpolación de cadenas

Nos falta por echar un vistazo a la última instrucción del script `puts "Hello #{name}!"`. `puts` muestra en pantalla un cadena de texto que empieza con "Hello " y sigue con el contenido de la variable `name`. La forma de interpolar el contenido de una variable dentro de una cadena de texto es con la secuencia `#{...}`.

Esta forma es la más común desde el punto de vista de un "rubista", pero si lo prefiere puede usar también `puts "Hello " + name + "!"`. Donde vemos que el operador `+` se usa para concatenar cadenas de texto (String).

## Resumen

¡Bien! Ya sabemos hacer:
1. Salida de datos por pantalla (puts, print).
2. Entrada de datos por teclado (gets).

Pero debo matizar que lo que hemos aprendido es entrada de datos "interactiva". Esto es, que el script se queda esperando a que nosotros le demos la entrada de datos. Hasta que escribamos enter el script se queda parado. Es una entrada de datos interactiva porque el script interactúa con el usuario para poder avanzar en su proceso.

[next >>](entrada-no-interactiva.md)
