[<< back](README.md)

# Los procesos tienen nombres

Los procesos de Unix tienen muy pocas formas inherentes de comunicarse sobre su estado.

Los programadores han solucionado esto e inventado cosas como archivos de registro. Los archivos de registro permiten que los procesos comuniquen lo que quieran sobre su estado escribiendo en el sistema de archivos, pero esto funciona a nivel del sistema de archivos en lugar de ser inherente al proceso en sí.

De manera similar, los procesos pueden usar la red para abrir sockets y comunicarse con otros procesos. Pero nuevamente, eso opera en un nivel diferente al del proceso en sí, ya que se basa en la red.

Hay dos mecanismos que operan a nivel del proceso mismo que se pueden utilizar para comunicar información. Uno es el nombre del proceso, el otro son los códigos de salida.

## Nomenclatura

Cada proceso en el sistema tiene un nombre. Por ejemplo, cuando inicia una sesión de `irb`, ese proceso recibe el nombre de 'irb'. Lo bueno de los nombres de los procesos es que se pueden cambiar en tiempo de ejecución y usarse como un método de comunicación.

En Ruby puede acceder al nombre del proceso actual en la variable `$PROGRAM_NAME`. De manera similar, puede asignar un valor a esa variable global para cambiar el nombre del proceso actual.

```ruby
puts $PROGRAM_NAME

10.downto(1) do |num|
  $PROGRAM_NAME = "Process: #{num}"
  puts $PROGRAM_NAME
end
```

Salida:

```
irb
Process: 10
Process: 9
Process: 8
Process: 7
Process: 6
Process: 5
Process: 4
Process: 3
Process: 2
Process: 1
```

Como ejercicio divertido, puede iniciar una sesión `irb`, imprimir el pid y cambiar el nombre del proceso. Luego puede usar la utilidad ps(1) para ver sus cambios reflejados en el sistema.

> Desafortunadamente, esta variable global (y su espejo `$0`) es el único mecanismo proporcionado por Ruby para esto. No hay una forma más reveladora de intenciones para cambiar el nombre del proceso actual.

## En el mundo real

Para ver un ejemplo de cómo se usa esto en un proyecto real, lea Cómo gestiona los procesos [Resque](https://workingwithruby.com/wwup/resque) en los apéndices.

[<< back](README.md)
