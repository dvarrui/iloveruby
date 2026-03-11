
# Bloques numéricos 

## Definición

_Juan Febles, [7/3/22 15:50]_

Supongamos que tenemos un panel con N filas y N columnas.
* Algunos valores del panel ya están establecidos (valores!=0) y no se pueden cambiar.
    * Siempre tiene que haber 2 números en una columna, fila o diagonal
* Rellenar las casillas vacías (valor=0) con números del 1 al 9, de modo que
    * sumando todos los números de cada fila debe dar el valor de la última columna.
    * sumando todos los números de cada columna debe dar el valor de la última fila.
    * sumando todos los números de diagonal principal debe dar el valor de la posición (N,N).

## Pasos

1. Crear panel 4x4
2. Rellenar el panel de 3x3 con números aleatorios entre 1 y 9
3. Calcular los totales de filas, columnas y diagonal
4. Quitar números o dejar huecos suficientes en 3x3

