[<< back](README.md)

# Los procesos son (CoW) friendly

Demos un paso atrás a mirar el código por un minuto para hablar sobre un concepto de nivel superior y cómo se maneja en diferentes implementaciones de Ruby.

## Ser CoW friendly

Como se mencionó en el capítulo de bifurcación, fork(2) crea un nuevo proceso secundario que es una copia exacta del proceso principal. Esto incluye una copia de todo lo que el proceso principal tiene en la memoria.

Copiar físicamente todos esos datos puede ser una sobrecarga considerable, por lo que los sistemas Unix modernos emplean algo llamado semántica de copia en escritura (CoW) para combatir esto.

Como habrá adivinado por el nombre, CoW retrasa la copia real de la memoria hasta que necesita escribirse.

Entonces, un proceso principal y un proceso secundario compartirán los mismos datos físicos en la memoria hasta que uno de ellos necesite modificarlos, momento en el que se copiará la memoria para que se pueda preservar la separación adecuada entre los dos procesos.

```ruby
arr = [1,2,3]

fork do
  # At this point the child process has been initialized.
  # Using CoW this process doesn't need to copy the arr variable,
  # since it hasn't modified any shared values it can continue reading
  # from the same memory location as the parent process.
  p arr
end
```

```ruby
arr = [1,2,3]

fork do
  # At this point the child process has been initialized.
  # Because of CoW the arr variable hasn't been copied yet.
  arr << 4
  # The above line of code modifies the array, so a copy of
  # the array will need to be made for this process before
  # it can modify it. The array in the parent process remains
  # unchanged.
end
```

Esta es una gran ventaja cuando se usa fork(2), ya que ahorra recursos. Significa que fork(2) es rápido ya que no necesita copiar nada de la memoria física del padre. También significa que los procesos secundarios solo obtienen una copia de los datos que necesitan, el resto se puede compartir.

Para que tenga la semántica de CoW, una implementación de Ruby debe escribirse de tal manera que no afecte a esta función proporcionada por el núcleo. Las versiones de MRI >= 2.0 están escritas de tal forma que respetan y preservan esta semántica. Las versiones de MRI <= 1.9 no conservaron la semántica.

> **¿Pero cómo?**
>
> El recolector de basura de MRI utiliza un algoritmo de 'marcar y barrer'. En pocas palabras, esto significa que cuando se invoca el GC, debe atravesar el gráfico de objetos vivos, y para cada uno de ellos, el GC debe 'marcarlo' como vivo.
>
> En MRI <= 1.9, este paso de 'marcar' se implementó como una modificación de ese objeto en la memoria. Entonces, cuando se invocó el GC justo después de un `fork`, se modificaron todos los objetos en vivo, lo que obligó al sistema operativo a hacer copias de todos los objetos Ruby en vivo y renunció a cualquier beneficio de la semántica de CoW.
>
> MRI >= 2.0 todavía usa un GC de marca y barrido, pero conserva la semántica de CoW al almacenar todas las "marcas" en una pequeña estructura de datos en una región dispar de la memoria. Entonces, cuando el GC se ejecuta después de un `fork`, esta pequeña región de memoria debe copiarse, pero el gráfico de los objetos Ruby en vivo se puede compartir entre el padre y el hijo hasta que su código modifique un objeto.

¿Qué significa esto para ti?

Si está creando algo o utilizando herramientas que dependen en gran medida de `fork(2)`, tendremos una utilización de la memoria mejor con MRI 2.0 que con las versiones anteriores.

[<< back](README.md)
