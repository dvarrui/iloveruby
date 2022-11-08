[<< back](README.md)

# Procesos huérfanos

Posiblemente haya notado en el último capítulo que al ejecutar los ejemplos con procesos secundarios involucrados, ya no es posible controlar todo desde una terminal como estamos acostumbrados.

Cuando iniciamos un proceso a través de una terminal, normalmente solo tenemos un proceso escribiendo en `STDOUT`, y tomando la entrada del teclado o escuchando ese Ctrl-C que le dice que salga.

Pero una vez que ese proceso se ha bifurcado, los procesos secundarios se vuelven un poco más difíciles. Cuando presiona Ctrl-C, ¿qué proceso debe salir? ¿Todos ellos? ¿Solo el padre?

Es bueno saber sobre estas cosas porque en realidad es muy fácil crear procesos huérfanos:

```ruby
fork do
  5.times do
    sleep 1
    puts "I'm an orphan!"
  end
end

abort "Parent process died..."
```

Si se ejecuta este programa desde una terminal, notará que, dado que el proceso principal muere inmediatamente, la terminal lo devuelve al símbolo del sistema. ¡En ese momento, se sobrescribe con STDOUT del proceso secundario! Pueden comenzar a suceder cosas extrañas cuando se bifurcan procesos.

## Niños abandonados

¿Qué le sucede a un proceso hijo cuando su padre muere?

La respuesta corta es, nada. Es decir, el sistema operativo no trata los procesos secundarios de manera diferente a cualquier otro proceso. Entonces, cuando el proceso principal muere, el proceso secundario continúa; el proceso padre no se lleva consigo al hijo.

## Gestión de huérfanos

¿Aún se pueden administrar los procesos huérfanos?

Nos estamos adelantando un poco con esta pregunta, pero hay dos conceptos interesantes.

El primero es algo llamado procesos daemon. Los procesos daemon son procesos de ejecución prolongada que se han dejado huérfanos de forma intencionada y están destinados a seguir ejecutándose para siempre. Estos se tratan en detalle en un capítulo posterior.

La segunda parte interesante aquí es la comunicación con procesos que no están conectados a una sesión de terminal. Puedes hacer esto usando algo llamado señales Unix. Esto también se trata con más detalle en un capítulo posterior.

Pronto hablaremos sobre cómo administrar y controlar adecuadamente los procesos secundarios.

[<< back](README.md)
