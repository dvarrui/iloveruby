[<< back](README.md)

# Los procesos tienen códigos de salida

Cuando un proceso llega a su fin, tiene una última oportunidad para dejar su huella en el mundo: su código de salida. Cada proceso que sale lo hace con un código de salida numérico (0-255) que indica si salió con éxito o con un error.

Tradicionalmente, se dice que un proceso que finaliza con **un código de salida de 0 es exitoso**. Cualquier otro código de salida denota un error, con diferentes códigos apuntando a diferentes errores.

Aunque tradicionalmente se usan para denotar diferentes errores, en realidad son solo un canal de comunicación. Todo lo que necesita hacer es manejar los diferentes códigos de salida con los que puede salir un proceso de una manera que se adapte a su programa y se haya alejado de las tradiciones.

Por lo general, es una buena idea seguir con la tradición del código de salida "0 como éxito" para que sus programas funcionen bien con otras herramientas de Unix.

# Cómo salir de un proceso

Hay varias formas de salir de un proceso en Ruby, cada una para diferentes propósitos.

## exit

La forma más sencilla de salir de un proceso es usar `Kernel#exit`. Esto también es lo que sucede implícitamente cuando su secuencia de comandos finaliza sin una declaración de salida explícita.

```ruby
# This will exit the program with the success status code (0).
exit
```

```ruby
# You can pass a custom exit code to this method
exit 22
```

```ruby
# When Kernel#exit is invoked, before exiting Ruby invokes any blocks
# defined by Kernel#at_exit.
at_exit { puts 'Last!' }
exit

# will output:
# => Last!
```

# exit!

`Kernel#exit!` es casi exactamente lo mismo que `Kernel#exit`, pero con dos diferencias clave. La primera es que establece un código de estado fallido por defecto (1), y la segunda es que no invocará ningún bloque definido usando Kernel#at_exit.

```ruby
# This will exit the program with a status code 1.
exit!
```

```ruby
# You can still pass an exit code.
exit! 33
```

```ruby
# This block will never be invoked.
at_exit { puts 'Silence!' }
exit!
```

# abort

`Kernel#abort` proporciona una forma genérica de salir de un proceso sin éxito. `Kernel#abort` establecerá el código de salida en 1 para el proceso actual.

```ruby
# Will exit with exit code 1.
abort
```

```ruby
# You can pass a message to Kernel#abort. This message will be printed
# to STDERR before the process exits.
abort "Something went horribly wrong."
```

```ruby
# Kernel#at_exit blocks are invoked when using Kernel#abort.
at_exit { puts 'Last!' }
abort "Something went horribly wrong."

# will output:
# => Something went horribly wrong.
# => Last!
```

# raise

Una forma diferente de finalizar un proceso es con una excepción no controlada. Esto es algo que nunca desea que suceda en un entorno de producción, pero casi siempre sucede en entornos de desarrollo y prueba.

Tenga en cuenta que `Kernel#raise`, a diferencia de los métodos anteriores, no saldrá del proceso inmediatamente. Simplemente genera una excepción que puede rescatarse en algún lugar de la pila. Si la excepción no se rescata en ninguna parte del código base, la excepción no controlada hará que el proceso se cierre.

Terminar un proceso de esta manera aún invocará cualquier controlador `at_exit` e imprimirá el mensaje de excepción y retrocederá a `STDERR`.

```ruby
# Similar to abort, an unhandled exception will set the exit code to 1.
raise 'hell'
```

[<< back](README.md)
