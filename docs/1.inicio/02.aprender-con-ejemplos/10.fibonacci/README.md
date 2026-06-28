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

* **[Ejemplo 2](./02-fibonacci.rb)**: 2. Calcular los N primeros elementos de la sucesión de Fibonacci. Usando un enfoque iterativo.

* **[Ejemplo 3](./03-fibonacci.rb)**: 2. Calcular los N primeros elementos de la sucesión de Fibonacci. Usando un enfoque recursivo.

* **[Ejemplo 4](./04-fibonacci.rb)**: 2. Calcular los N primeros elementos de la sucesión de Fibonacci. Usando un enfoque con Memoización.

Para reducir los cálculos repetitivos, se van almacenando los resultados en un "caché" (memoización).

* **[Ejemplo 5](./05-fibonacci.rb)**: 2. Calcular los N primeros elementos de la sucesión de Fibonacci. Usando un enfoque con Enumerator.

* **[Ejemplo 6](./06-benchmark.rb)**: 2. Calcular los N primeros elementos de la sucesión de Fibonacci. Usando un enfoque con Enumerator.

```
$ ./07-benchmark.rb
                      user     system      total        real
Iterativo :       0.000009   0.000001   0.000010 (  0.000007)
Memoizado :       0.000009   0.000002   0.000011 (  0.000011)
Recursivo :       0.078900   0.000000   0.078900 (  0.079172)
Enumerator:       0.000043   0.000000   0.000043 (  0.000043)
```

* **[Ejemplo 7](./07-holamundo.rb)**: Escribir los resultados en un fichero llamado `fibonacci.txt`.

Ampliamos la solución con el enfoque iterativo (por ser el más rápido) para guardar los datos en un fichero de texto.

---

_Hasta aquí hemos terminado de "evolucionar" Fibonacci, ahora puedes seguir con el [siguiente problema](../11.dibujitos/README.md)._
