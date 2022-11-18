[<< back](README.md)

# Procesos zombis

Al comienzo del último capítulo vimos un ejemplo que usaba un proceso hijo para manejar asincrónicamente una tarea en forma de disparar y olvidar. ¡Necesitamos revisar ese ejemplo y asegurarnos de limpiar ese proceso secundario adecuadamente, para que no se convierta en un zombi!

## Las cosas buenas les llegan a los que wait(2)

En el último capítulo, mostré que el kernel pone en cola la información de estado sobre los procesos secundarios que han finalizado. Entonces, incluso si llama a `Process.wait` mucho después de que el proceso secundario haya salido de su estado, la información aún está disponible. Estoy seguro de que puedes oler un problema aquí...

El núcleo conservará el estado de los procesos secundarios finalizados hasta que el proceso principal solicite ese estado mediante `Process.wait`. Si el padre nunca solicita el estado, el núcleo nunca podrá retirar esa información de estado. Por lo tanto, crear procesos secundarios de disparar y olvidar sin recopilar su información de estado es un mal uso de los recursos del kernel.

**Si no va a esperar a que un proceso secundario termine usando `Process.wait` (o la técnica descrita en el próximo capítulo), entonces necesita "separar" ese proceso secundario**. Aquí está el ejemplo de disparar y olvidar del último capítulo rectificado para separar correctamente el proceso secundario:

```ruby
message = 'Good Morning'
recipient = 'tree@mybackyard.com'

pid = fork do
  # In this contrived example the parent process forks a child to take
  # care of sending data to the stats collector. Meanwhile the parent
  # process has continued on with its work of sending the actual payload.

  # The parent process doesn't want to be slowed down with this task, and
  # it doesn't matter if this would fail for some reason.
  StatsCollector.record message, recipient
end

# This line ensures that the process performing the stats collection
# won't become a zombie.
Process.detach(pid)
```

¿Qué hace `Process.detach`? Simplemente genera un nuevo subproceso cuyo único trabajo es esperar a que finalice el proceso secundario especificado por `pid`. Esto asegura que el kernel no se aferre a ninguna información de estado que no necesitemos.

## ¿Qué aspecto tienen los zombis?

```ruby
# Create a child process that exits after 1 second.
pid = fork { sleep 1 }
# Print its pid.
puts pid
# Put the parent process to sleep so we can inspect the
# process status of the child
sleep 5
```

Ejecutar el siguiente comando en una terminal, usando el `pid` impreso desde el último fragmento, imprimirá el estado de ese proceso zombi. El estado debe decir 'z' o 'Z+', lo que significa que el proceso es un zombi.

```
ps -ho pid,state -p [pid of zombie process]
```

# El mundo real

Tenga en cuenta que cualquier proceso inactivo cuyo estado no se haya esperado es un proceso zombi. Entonces, cada proceso hijo que muere mientras su padre aún está activo será un zombi, aunque solo sea por un corto tiempo. Una vez que el proceso principal recopila el estado del zombi, desaparece de manera efectiva y ya no consume recursos del kernel.

Es bastante poco común bifurcar los procesos secundarios en modo "disparar y olvidar", nunca recopilando su estado. Si el trabajo debe descargarse en segundo plano, es mucho más común hacerlo con un sistema de cola en segundo plano dedicado.

Dicho esto, hay un Rubygem llamado spawnling (https://github.com/tra/spawnling) que proporciona esta funcionalidad exacta. Además de proporcionar una API genérica sobre procesos o subprocesos, garantiza que los procesos de activación y olvido se separen correctamente.

## Llamadas al sistema

No hay una llamada al sistema para `Process.detach` porque se implementa en Ruby simplemente como un hilo y `Process.wait`. La implementación en [Rubinius](https://github.com/rubinius/rubinius/blob/c6e8e33b37601d4a082ddcbbd60a568767074771/kernel/common/process.rb#L377-395) está marcada por su simplicidad.

[<< back](README.md)
