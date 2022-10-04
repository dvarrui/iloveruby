[<< back](README.md)

# Los procesos tienen límite de recursos

En el último capítulo analizamos el hecho de que los recursos abiertos están representados por descriptores de archivos. Es posible que haya notado que cuando los recursos no se cierran, los números de descriptor de archivo continúan aumentando. Surge la pregunta: ¿cuántos descriptores de archivos puede tener un proceso?

La respuesta depende de la configuración de su sistema, pero lo importante es que **hay algunos límites de recursos que son impuestos al proceso por el núcleo**.

## Encontrar los límites

Continuaremos con el tema de los descriptores de archivos. Usando Ruby podemos consultar el número máximo de descriptores de archivo permitidos:

```ruby
p Process.getrlimit(:NOFILE)
# On my machine this snippet outputs:
# => [2560, 9223372036854775807]
```

Usamos `Process.getrlimit(:NOFILE)` para consultar la cantidad máxima de archivos abiertos. Devolvió un Array de dos elementos.

El primer elemento de la matriz es el límite suave para la cantidad de descriptores de archivos, el segundo valor es el límite estricto para la cantidad de descriptores de archivos.

# Límites blandos frente a límites duros

¿Cual es la diferencia? Me alegro de que preguntas. El límite suave no es realmente un límite. Lo que significa que si supera el límite suave (en este caso, al abrir más de 2560 recursos a la vez), se generará una excepción, pero siempre se puede cambiar ese límite si lo desea.

Tenga en cuenta que el límite estricto en mi sistema para la cantidad de descriptores de archivos es un número entero ridículamente grande. ¿Es posible abrir tantos? Probablemente no, estoy seguro de que te encontrarás con restricciones de hardware antes de que se puedan abrir muchos recursos a la vez.

En mi sistema, ese número en realidad representa el infinito. Se repite en la constante `Process::RLIM_INFINITY`. Intente comparar esos dos valores para estar seguro. Entonces, en mi sistema, puedo abrir efectivamente tantos recursos como desee, una vez que alcance el límite suave para mis necesidades.
