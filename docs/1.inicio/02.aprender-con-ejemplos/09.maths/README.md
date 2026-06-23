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

* **[Ejemplo 3](./03-maths.rb): Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M**

Usamos el siguiente algoritmo:

* El `MCD(a, b)` es lo mismo que `MCD(b, (a mod b))`.
* El proceso se repite hasta que el resto sea cero.

```ruby
def calcular_mcd(a, b)
  b == 0 ? a : calcular_mcd(b, a % b)
end

puts calcular_mcd(48, 18) # Salida: 6
```

* **[Ejemplo 4](./04-maths.rb): Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M**

Usamos este otra fórmula: `MCM = (n * m) / MCD(n, m)`

* **[Ejemplo 5](./05-maths.rb): Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M**

Al final, nos parece más sencillo usar directamentes lo métodos que proporciona Ruby.

* **[Ejemplo 6](./06-maths.rb):**

- Hacer lo mismo pero pidiendo varios números al usuario.
- Almacenar en una lista y calcular el MCM y el MCD de todos ellos.

