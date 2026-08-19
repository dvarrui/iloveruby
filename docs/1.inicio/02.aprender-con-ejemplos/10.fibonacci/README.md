[<< back](../README.md) | [HOME](../../../index.md)

```
EN CONSTRUCCION!!!
```

# Fibonacci

Hacer un programa que haga lo siguiente:

1. Pedir un número al usuario.
2. Calcular los N primeros elementos de la sucesión de Fibonacci.
3. Mostrar resultado por pantalla.
4. Escribir los resultados en un fichero llamado `fibonacci.txt`.

* **[Ejemplo 1](./01-fibonacci.rb)**: Pedir número al usuario.

* **[Ejemplo 2](./02-fibonacci.rb)**: Calcular los N primeros elementos de la sucesión de Fibonacci. Usando un enfoque iterativo.

* **[Ejemplo 3](./03-fibonacci.rb)**: Repetimos usando un enfoque recursivo.

* **[Ejemplo 4](./04-fibonacci.rb)**: Repetimos usando un enfoque con Memoización.

Para reducir los cálculos repetitivos, vamos almacenando los resultados en una "caché" (memoización).

* **[Ejemplo 5](./05-fibonacci.rb)**: Repetimos usando un enfoque con Enumerator.

* **[Ejemplo 6](./06-benchmark.rb)**: Benchmark. Pruebas de rendimiento.

Como tenemos 4 soluciones diferentes, se nos ocurre quue podemos evaluarlas a ver cuál nos ofrece mejor rendimiento. Para ello usamos la gema `benhcmark`, y ejecutamos las 4 soluciones varias veces para obtener los siguientes resultados:

```bash
$ ./07-benchmark.rb
                      user     system      total        real
Iterativo :       0.000009   0.000001   0.000010 (  0.000007)
Memoizado :       0.000009   0.000002   0.000011 (  0.000011)
Recursivo :       0.078900   0.000000   0.078900 (  0.079172)
Enumerator:       0.000043   0.000000   0.000043 (  0.000043)
```

* La solución menos eficiente es la recursiva.
* La solución más optima es la iterativa.

Tiene sentido, puesto que Ruby es un lenguaje iterativo y aunque permite la recursividad, no está optimizado como Haskell en esta forma de trabajo.

* **[Ejemplo 7](./07-holamundo.rb)**: Escribir los resultados en un fichero llamado `fibonacci.txt`.

Ampliamos la solución con el enfoque iterativo (por ser el más rápido) para guardar los datos en un fichero de texto.

---

_Hasta aquí hemos terminado de "evolucionar" Fibonacci, ahora puedes seguir con el [siguiente problema](../11.dibujitos/README.md)._
