

# GEM_PATH y GEM_HOME

> (Greg Navis @gregnavis) https://twitter.com/gregnavis/status/1592517832859795457?t=0Z4Vv6krbcvlAmAKJ5Ofiw&s=35

Las variables de entorno `GEM_HOME` y `GEM_PATH` se pueden usar para personalizar la ubicación del repositorio de gemas. Estas variables de entorno determinan dónde se instalan las gemas y donde buscar las gemas.

Echemos un vistazo más de cerca a cada uno.

**GEM_HOME**

* Determina dónde se instalan las gemas cuando se ejecutan `gem install` y `bundler`. Es sencillo instalar las gemas localmente sin usar `rbenv`, `rvm`, etc.
* Así es como lo hago con mis proyectos. Simplemente configuro la variable de entorno `GEM_HOME=$HOME/.gems`

![](https://pbs.twimg.com/media/FhnCiPSUcAACxK9?format=jpg&name=large)

Si ejecuta Ruby e intenta solicitar una de esas gemas, no las encontrará, a menos que también esté presente en la ubicación predeterminada, pero técnicamente necesitaría una instalación diferente.

_¡Aquí es donde entra GEM_PATH!_

**GEM_PATH**

* `GEM_PATH` es una lista separada por comas de repositorios de gemas (Es similar a PATH pero para las gemas de Ruby).
* Ruby toma esa lista y _agrega_ algunas rutas predeterminadas. El primer lugar que tenga la gema gana.

![](https://pbs.twimg.com/media/FhnCiyFUAAEwbvS?format=jpg&name=small)

**LOAD_PATH**

* Ruby permite leer y escribir la lista real de directorios utilizados en la búsqueda de gemas. Se almacenan en una variable global llamada `$LOAD_PATH` o `$:`.
* Se puede modificar en tiempo de ejecución.
* Veamos a continuación mi LOAD_PATH, donde estoy usando Ruby 3.1 de MacPorts. No uso rbenv, rvm, etc.

![](https://pbs.twimg.com/media/FhnCjMyUAAMZ6iZ?format=jpg&name=small)

* A menudo instalo las dependencias en un directorio de proyecto, como... node_modules 😱
* Cambiar a un repositorio de gemas per-Ruby en mi directorio de inicio sería igual de sencilloa.

![](https://pbs.twimg.com/media/FhnCjmyUUAAhRrU?format=jpg&name=small)

* GEM_PATH y GEM_HOME son simples pero a menudo ocultas por el uso de herramientas como rvm o rbenv. Considero que la gestión de gemas es algo simple incluso sin herramientas adicionales.


# Diferencia entre `equal?` y `==`

> (Kirill Shevchenko
@kirill_shevch) https://twitter.com/kirill_shevch/status/1592652547420213248?t=5YIvGDyFHTVkRpUiLqgePw&s=35

Los dos se usan para comparar datos, pero:

1. `==` devuelve verdadero si ambos objetos contienen el mismo valor.
2. `equal?` comprueba si las referencias apuntan al mismo objeto de la memoria (ambos valores son el mismo objeto).

**Ejemplo**

```ruby
message1 = `Hello there!`
message2 = `Hello there!`
message3 = message1

message1 === message2
# => true

message1.equal? message2
# => false

message1.equal? message3
# => true

message1.object_id # => 16000
message2.object_id # => 16020
message3.object_id # => 16000
```
