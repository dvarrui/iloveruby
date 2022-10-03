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
