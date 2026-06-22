[<< back](../README.md) | [HOME](../../../index.md)

```
EN CONSTRUCCION!!!
```

# Matemáticas: MCD y MCM

Hacer un programa para:

1. Pedir al usuario dos números enteros N y M.
2. Calcular y mostrar el máximo común divisor (MCD) de N y M.
4. Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M.
5. Hacer lo mismo pero pidiendo varios números al usuario.
6. Almacenar en una lista y calcular el MCM y el MCD de todos ellos.


* **[Ejemplo 1](./01-maths.rb)**: Pedir al usuario dos números enteros N y M.

* **[Ejemplo 2](./02-maths.rb)**: Calcular el máximo común divisor (MCD) de N y M, y mostrar por pantalla em MCD.

Hay varios caminos para calcular el Máximo Común Divisor (MCD). Ruby ya incluye el método `gcd()` directamente en la clase Integer. Es la opción más cómoda y muy "RubyWay".

```ruby
a = 48
b = 18

result = a.gcd(b)

puts "El MCD de #{a} y #{b} es: #{result}"
# Salida: El MCD de 48 y 18 es: 6
```

* **[Ejemplo 3](./03-maths.rb): Implementación con el Algoritmo de Euclides**: Ahora volvemos a calcular em MCD usando al algoritmia.

* El `MCD(a, b)` es lo mismo que `MCD(b, (a mod b))`.
* El proceso se repite hasta que el resto sea cero.

```ruby
def calcular_mcd(a, b)
  b == 0 ? a : calcular_mcd(b, a % b)
end

puts calcular_mcd(48, 18) # Salida: 6
```

> De momento seguimos el camino fácil de Ruby.

* **[Ejemplo 3]()**: Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M.
