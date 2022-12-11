

```
Greg Navis (https://t.co/oDeLpNi7T9?s=35)
Elixir-style Pipelines in 9 Lines of Ruby
Elixir pipelines are an elegant construct for sequencing operations in a readable way. Fortunately, 9 lines is all it takes to implement them in Ruby.
```

# Pipelines estilo Elixir en 9 líneas de Ruby

> Enlace de interés:
> * https://t.co/oDeLpNi7T9?s=35

Los `pipelines` de Elixir son una construcción elegante para secuenciar operaciones de una manera legible. Afortunadamente, 9 líneas es todo lo que se necesita para implementarlas en Ruby.

## Background: << y >>

Ruby ofrece algunas primitivas. Los objetos `Proc` y `Method` responden a `#<<` y `#>>`, que se pueden usar para crear `pipelines`:

```ruby
FindByLogin = proc { |login| ... }
ConfirmUserAccount = proc { |user| ... }
SendConfirmationNotification = proc { |user| ... }

(FindByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification).call("gregnavis")
```

Este enfoque tiene varios inconvenientes:

* El `Proc` devuelto por `#>>` no se puede llamar usando `result(...)`, sino solo a través de `proc.call(...)` o `proc.(...)` o `proc[...]`, que es inconsistente con regular llamadas a métodos. Es cierto que esto es inevitable, pero se puede hacer que importe menos.
* El argumento de la tubería viene al final, pero tenerlo al frente sería más legible y más consistente con la estructura de la tubería.
* Las operaciones que toman más de un parámetro deben implementarse como procesos de orden superior o usar `curry`. Introducir o eliminar parámetros adicionales implica cambiar entre procesos normales y procesos de orden superior o `curry`.

Para ilustrar el último problema, hagamos que `SendConfirmationNotification` tome un argumento que determine el tipo de notificación: correo electrónico o SMS. Ahora tenemos que reescribirlo como:

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

Desafortunadamente, el `pipeline` sigue con el problema del argumento que llega al final:

```ruby
(FindByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification[:sms])["gregnavis"]
```

En el resto del artículo mostraremos cómo usar los `refine` de Ruby, una función incorporada pero relativamente oscura, para hacer que funcione el siguiente código:

```ruby
"gregnavis" >>
  FindByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification[:sms]
```

Comencemos con las definiciones de los operadores. Inicialmente se usará "Monkey-patching", pero se reemplazará con mejoras al final del artículo.

## Paso 1: Definición de `operation`

Las `operation` con y sin parámetros deberán definirse de la misma manera. Crearemos un nuevo método del `Kernel` para que nos ayude:

```ruby
module Kernel
  def operation(...) = proc(...).curry
end
```

Básicamente, `operation` crea un `Proc` `curry` automáticamente. Ahora los `pipeline` se pueden definir de la siguiente forma:

```ruby
FindByLogin = operation { |login| ... }
ConfirmUserAccount = operation { |user| ... }

# Notice user comes last.
SendConfirmationNotification = operation { |method, user| ... }
```
