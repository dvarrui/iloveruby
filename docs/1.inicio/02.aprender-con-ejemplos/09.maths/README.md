[<< back](../README.md) | [HOME](../../../index.md)

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
# => El MCD de 48 y 18 es: 6
```

* **[Ejemplo 3](./03-maths.rb): Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M**

Usamos el siguiente algoritmo:

* El `MCD(a, b)` es lo mismo que `MCD(b, (a mod b))`.
* El proceso se repite hasta que el resto sea cero.

```ruby
def mcd(a, b)
  b == 0 ? a : mcd(b, a % b)
end

puts mcd(48, 18) # Salida: 6
```

* **[Ejemplo 4](./04-maths.rb): Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M**

Usamos esta otra fórmula: `MCM = (n * m) / MCD(n, m)`

* **[Ejemplo 5](./05-maths.rb): Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M**

Al final, nos parece más sencillo usar directamentes lo métodos que proporciona Ruby.

* **[Ejemplo 6](./06-maths.rb): Hacer lo mismo pero pidiendo varios números al usuario.**

- Almacenar en una lista y calcular el MCM y el MCD de todos ellos.

* **[Ejemplo 7](./07-maths.rb): Algo más o algo menos**

En los ejemplos anteriores, hemos aprovechado las funciones predefinidas que nos ofrecía el lenguaje para el cálculos del MCD y del MCM. Ahora vamos a reconstruirlo sin usarlas.

* Empezamos leyendo 2 valores N y M introducidos por el usuario.
* Lo siguiente descomponer cada número en sus factores.

```ruby
def factorize(number)
  factors = []
  aux = number
  (2..number).each do |i|
    while (aux % i).zero?
      factors << i
      aux /= i
    end
  end
  factors
end
```

* Conociendo los factores de cada número, ahora creamos 3 Arrays:
    - `mcd`: los factores comunes de N y M.
    - `ext1`: los factores de N que no son comunes.
    - `ext2`: los factores de M que no son comunes.

```ruby
mcd = []
ext1 = n_factors.clone
ext2 = m_factors.clone

n_factors.each do |number|
  if ext2.include? number
    mcd << number
    ind1 = ext1.find_index number
    ext1.delete_at(ind1)
    ind2 = ext2.find_index number
    ext2.delete_at(ind2)
  end
end
mcd = [1] if mcd.empty?
```

* Ahora con esta información ya tenemos los resultados:
    - MCD: resultado de multiplicar todos los números del Array `mcd`.
    - MCM: resultado de multiplicar todos los números del Array `mcd + ext1 + ext2`.

---

_Hasta aquí hemos terminado de "evolucionar" "Matemáticas: MCD y MCM", ahora puedes seguir con el [siguiente problema](../11.fibonacci/README.md)._
