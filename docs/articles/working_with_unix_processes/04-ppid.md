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
