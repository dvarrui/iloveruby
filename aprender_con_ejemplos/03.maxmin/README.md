[<< back](../README.md)

#  Máximos y mínimos, pares e impares

Vamos a hacer un programa que pida tres números al usuario, y sin usar Array (listas), muestrar por pantalla:
* El mínimo (indicar si es par o impar)
* El máximo (indicar si es par o impar)

**[Ejemplo 1](./01-maxmin.rb): Ordenamos los 3 números.**

Leemos los 3 números pasados como argumentos `ARGV[]`, y los convertimos a Integer `to_i`.

Lo siguiente que vamos a hacer es ordenarlos. Hay que recordar que un requisito era que no podemos usar Array. Entonces usamos 3 variables `number1, number2, number3` y los ordenamos con sentencias `if`.

Con las sentencias `if` comparamos, por ejemplo el número 1 con el 2, y si el 1 es mayor entonces los intercambiamos. 

Ejemplo:

```ruby
if number1 > number2
  # Itercambiar number1 con number2
  number1, number2 = number2, number1
end
```

> **NOTA**: La forma de intercambiar los valores de las variables es muy sencillo y no requiere el uso de una variable auxiliar o temporal.

**[Ejemplo 2](./02-maxmin.rb): Mínimo y máximo.**

Al tener ordenados los 3 números, ya tenemos el mínimo y el máximo, sin hacer nada.

**[Ejemplo 3](./03-maxmin.rb): Indicar si son pares o impares.**

Lo que nos enseñan, para saber si un número es par o impar, es dividir el número por 2 y si el resto es cero, entonces es par, en caso contrario es impar. Vale, vamos a implementar este algoritmo. El operador para calcular el resto es `%`.


---

_Hasta aquí hemos terminado de "evolucionar" los "números", ahora puedes seguir con el siguiente problema._