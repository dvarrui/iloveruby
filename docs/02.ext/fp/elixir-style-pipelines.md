[<<back](../README.md)

# Pipelines estilo Elixir en 9 líneas de Ruby

```
Elixir-style Pipelines in 9 Lines of Ruby
Greg Navis (https://t.co/oDeLpNi7T9?s=35)

Elixir pipelines are an elegant construct for sequencing operations in a readable way.
Fortunately, 9 lines is all it takes to implement them in Ruby.
```

> Traducción del artículo de Greg Navis (https://t.co/oDeLpNi7T9?s=35)

Los `pipelines` de Elixir son una elegante construcción para secuenciar operaciones de manera legible. Por suerte, sólo se necesitan 9 líneas en Ruby para implementarlo.

## Background: << y >>

Los objetos `Proc` y `Method` responden a `#<<` y `#>>`, y éstos se pueden usar para crear los "pipelines":

```ruby
FindByLogin = proc { |login| ... }
ConfirmUserAccount = proc { |user| ... }
SendConfirmationNotification = proc { |user| ... }

(FindByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification).call("gregnavis")
```

Inconvenientes:

* El `Proc` devuelto por `#>>` no se puede llamar usando `result(...)`, sino que se debe invocar a través de `proc.call(...)`, `proc.(...)` o `proc[...]`. Es cierto que esto es inevitable, pero se puede hacer de forma más disimulada.
* El argumento del "pipeline" está al final, pero sería más legible y más coherente con la estructura de las tuberías ponerlo al principio.
* Las operaciones que tiene varios parámetros, se tienen que implementar como procesos de orden superior o usando `curry`. De modo que eliminar o introducir parámetros adicionales implica cambiar entre procesos normales y procesos de orden superior o `curry`.

Para ilustrar esto último vamos a hacer que `SendConfirmationNotification` tome como argumento el tipo de notificación: correo electrónico o SMS. Ahora lo reescribimos como:

```ruby
# Using a higher-order proc.
SendConfirmationNotification = proc do |method|
  proc { |user| ... }
end

# Using currying; notice .curry after the block
SendConfirmationNotification = proc do |method, user|
  ...
end.curry
```

Por desgracia, seguimos con el problema de tener el argumento de entrada al final del "pipeline":

```ruby
(FindByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification[:sms])["gregnavis"]
```

A continuación veremos cómo usar `refine`, una función de Ruby pero relativamente oscur, para hacer funcionar el código siguiente:

```ruby
"gregnavis" >>
  FindByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification[:sms]
```

Comencemos con las definiciones de las operaciones. Empezaremos usando "Monkey-patching", pero luego lo cambiaremos al final del artículo.

## Paso 1: Definición de `operation`

Las `operation` con y sin parámetros deberán definirse de manera similar. Creamos un nuevo método del `Kernel` para que nos ayude con eso:

```
module Kernel
  def operation(...) = proc(...).curry
end
```

Básicamente, `operation` crea automáticamente un `Proc` de tipo `curry`. Ahora los "pipeline" se pueden definir de la siguiente forma:

```ruby
FindByLogin = operation { |login| ... }
ConfirmUserAccount = operation { |user| ... }

# Notice user comes last.
SendConfirmationNotification = operation { |method, user| ... }
```

Debido al "curry", el primer argumento de `SendConfirmationNotification` se puede proporcionar en el "pipeline", mientras que la ejecución se "pausa" hasta que también se proporcione el segundo argumento (usuario). El siguiente código ahora funciona como queríamos:

```ruby
(FindByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification[:sms])["gregnavis"]
```

Ahora el siguiente objetivo es mover el valor de entrada al principio de la turbería.

## Paso 2: Canalización de argumentos con `callable`

Vamos a convertir en equivalentes las siguientes dos expresiones:

```ruby
# When we write this:
argument >> callable

# we actually mean this:
callable.call(argument)
```

El fragmento anterior da una idea de lo que se pretende lograr: todos los objetos responderán a `>>` y ese método, a su vez, hará una llamada a `call`. Por tanto, hay que modificar la clase de nivel superior (`Object` o `BasicObject`) para que el método `#>>` esté disponible en todas los objetos. De este modo obtenemos lo siguiente:

```Ruby
class Object
  def >>(callable) = callable.call(self)
end
```

Finalmente, podemos escribir lo siguiente:

```ruby
"gregnavis" >>
  FindUserByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification[:sms]
```

Los parches realizados en `Kernel` y `Object` debemos convertirlos a refinamientos con `refine`, para evitar un "Monkey-patching" a nivel global.

## Paso 3: Introduciendo refinamientos

Los refinamientos son tema para un artículo aparte, pero resumiendo, son como "Monkey-patches" que redefinen dentro de un módulo o clase específico llamando a `Module#using`. Veamos el problema de afuera hacia adentro comenzando con cómo queremos que se use el código.

Supongamos que estamos trabajando dentro de un controlador Rails. Nos gustaría poder escribir el código como:

```ruby
class UsersController < ApplicationController
  using Pipelines

  def confirm
    params[:login] >>
      FindUserByLogin >>
      ConfirmUserAccount >>
      SendConfirmationNotification[:sms]
  end
end
```

`using` está integrado en Ruby, y `Pipelines` es el módulo de refinamiento que queremos activar. Es un módulo Ruby ordinario que refina (es decir, "parchea") `Kernel` y `Object`:

```
module Pipelines
  refine Kernel do
    def operation(...) = proc(...).curry
  end

  refine Object do
    def >>(callable) = callable.call(self)
  end
end
```

¡Eso es todo! Ahora los "pipelines" están activos solo en `UsersController` y no afecta a ningún otro código. También refinaremos con `using` cuando se definan las `operations`.

## Resumen

Esta implementación de "pipeline" cabe en una servilleta. Hagamos un poco de crítica a esta solución.

Primero, llamar a un proceso `curry` sin argumentos mantiene la ejecución "en pausa", por lo que perder un argumento puede hacer que la canalización devuelva un proceso `curry`, en lugar del valor de retorno esperado. Esto puede generar errores difíciles de entender.

En segundo lugar, los procesos son difíciles de inspeccionar. Ver `#<Proc:0x...>` en el terminal no es muy útil durante la depuración. Es posible inspeccionar los parámetros pasados a una operación a través de `operation_object.binding.local_variables` y `operation_object.binding.local_variable_get(name)` para los parámetros que nos interesen. Aunque sería más útil que la inspección de una operación produjera algo como `SendConfirmationNotification[método: :sms]`.

## Próximos pasos

Este fue mi segunda idea para implementar "pipelines". La primera estaba orientado a objetos y no tenía los inconvenientes mencionados anteriormente, pero por el contrario la implementación era un poco más compleja.

Lo explicaré en un próximo artículo.

----

**Ejemplo 1**

```ruby
module Pipelines
  refine Kernel do
    def operation(...) = proc(...).curry
  end

  refine Object do
    def >>(callable) = callable.call(self)
  end
end

using Pipelines

Upcase = operation { |text| text.upcase }
Reverse = operation { |text| text.reverse }

puts ("obiwan" >> Upcase >> Reverse)
# => NAWIBO
```

**Ejemplo 2**

```ruby
module Pipelines
  refine Kernel do
    def operation(...) = proc(...).curry
  end

  refine Object do
    def |(callable) = callable.call(self)
  end
end

using Pipelines

Upcase = operation { |text| text.upcase }
Reverse = operation { |text| text.reverse }

puts ("redav htrad" | Upcase | Reverse)
# => DARTH VADER
```
