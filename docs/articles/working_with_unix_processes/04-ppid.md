[<< back](README.md)

# Los procesos tienen padres

Cada proceso que se ejecuta en su sistema tiene un proceso padre. Cada proceso conoce el identificador de su proceso padre (en adelante, "ppid").

En la mayoría de los casos, el proceso padre de un proceso determinado es el proceso que lo invocó. Por ejemplo, un usuario de OSX que inicia Terminal.app y aterriza en un indicador de bash. Dado que todo es un proceso, esa acción inició un nuevo proceso Terminal.app, que a su vez inició un proceso bash.

El padre de ese nuevo proceso bash será el proceso Terminal.app. Si luego invoca ls(1) desde el indicador de bash, el padre de ese proceso `ls` será el proceso bash.

Dado que el kernel trata solo con pid, hay una manera de obtener el pid del proceso principal actual. Así es como se hace en Ruby:

```ruby
# Notice that this is only one character different from getting the
# pid of the current process.
puts Process.ppid
```

# Referencias cruzadas

Dejando su sesión irb abierta, ejecute el siguiente comando en una terminal:

```
$ ps -p <ppid-of-irb-process>
```

Ese comando debería mostrar un proceso llamado 'bash' (o 'zsh' o lo que sea) con un pid que coincida con el que se imprimió en su sesión de `irb`.

# En el mundo real

No hay muchos usos para el ppid en el mundo real. Puede ser importante cuando se detectan procesos daemon, algo que se tratará en un capítulo posterior.

# Llamadas al sistema

`Process.ppid` de Ruby se asigna a getppid(2).

[<< back](README.md)
