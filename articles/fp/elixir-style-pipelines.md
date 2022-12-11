

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

Ruby ofrece algunas primitivas de canalización. Los objetos `Proc` y `Method` responden a `#<<` y `#>>`, que se pueden usar en los `pipelines`:

```ruby
FindByLogin = proc { |login| ... }
ConfirmUserAccount = proc { |user| ... }
SendConfirmationNotification = proc { |user| ... }

(FindByLogin >>
  ConfirmUserAccount >>
  SendConfirmationNotification).call("gregnavis")
```
