[<< back](../README.md) | [HOME](../../../index.md)

# Devolver el cambio

Vamos a hacer un programa para:
1. Recibir un número que represente una cantidad de dinero D, incluyendo céntimos.
2. Calcular la mínima cantidad de monedas necesarias para sumar D, suponiendo que
tenemos monedas de 2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, y 0.01.
3. Mostrar por pantalla la cantidad de cada una de las monedas.

**[Ejemplo 1](./01-cambiar.rb): Empezamos leyendo la cantidad de dinero.**

El punto 1 es fácil.

**[Ejemplo 2](./02-cambiar.rb): Suponemos que tenemos monedas de 2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, y 0.01.**

Empezamos guardando en una lista `coins` todos los valores posibles de las monedas.

```ruby
coins = [2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01]
coins.sort!.reverse!
```

Ahora mismo es redundante, pero por seguridad, si algún día cambiamos los valores y nos equivocamos en el orden, vamos a forzar a que los valores de `coins` estén ordenados de mayor a menor.

Los métodos con `sort!` y `reverse!`, se parecen los métodos `sort` y `reverse`. Pero `sort` devuelve una copia ordenada de la lista y `sort!` devuelve la misma lista pero con los valores ordenados. Los métodos que terminan en exclamación, por convenio (no hay una regla del lenguaje) identifican los métodos que cambian los valores del propio objeto, mientras que si no tiene exclamación se devuelve una copia de los datos que tuviera el objeto. Esta distinción es importante.

Para mostrar el contenido de la lista (Array) `coins`, genero un `String` que serán todos los valores de la lista unidos por `, `. Esto es `coins.join(', ')`.

**[Ejemplo 3](./03-cambiar.rb): Calcular la mínima cantidad de monedas necesarias para sumar D.**

Explicar el código:

```ruby
amount = money
coins.each do |coin|
  while amount >= coin
    change[coin] ||= 0
    change[coin] += 1
    amount -= coin
  end  
end
```

Vamos a ver cómo van cambiando las variables en cada iteración:

| Iteración |coin | amount             | change                   |
| ----------| --- | ------------------ | ------------------------ |
|           | 3.4 |                    |                          |
| primera   | 2   | 1.4                | coin[2] = 1              |
| segunda   | 1   | 0.3999999999999999 | coin[2] = 1, coin[1] = 1 |

El programa no está bien. La culpa es de la CPU. Esto es, la CPU almacena los números en binario y hace las operaciones en binario. Cuando termina para mostrar el resultado en pantalla vuelve a convertir en decimal el valor que tiene. Las conversiones de números con decimales en base 10 a binario y viceversa no son "exactas" en algunas situaciones.

El programa no es correcto puesto que queremos que se ejecute en una máquina basada en las números binarios. De modo que tendremos que modificar el código. 

**[Ejemplo 4](./04-cambiar.rb): Redondear el resultado.**

Se me ocurren varios caminos para resolver el problema, pero quizás el primero que me viene a la mente es redondear `amount` después de cada modificación. El redondeo entiendo que lo puedo hacer a nivel de 2 dígitos decimales que es la moneda más pequeña.

**[Ejemplo 5](./05-cambiar.rb): 3. Mostrar por pantalla la cantidad de cada una de las monedas.**

Explicar código y darle color.

---

_Hasta aquí hemos terminado de "evolucionar" "devolver el cambio", ahora puedes seguir con el siguiente problema._