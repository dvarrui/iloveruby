[<< back](../README.md) | [HOME](../../../index.md)

```
EN CONSTRUCCION!!!
```

# Matemáticas: MCD y MCM

Hacer un programa para:

1. Pedir al usuario dos números enteros N y M.
2. Calcular el máximo común divisor (MCD) de N y M.
3. Mostrar por pantalla em MCD.
4. Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M.
5. Hacer lo mismo pero pidiendo varios números al usuario.
6. Almacenar en una lista y calcular el MCM y el MCD de todos ellos.

---

Tenemos varios caminos para calcular el Máximo Común Divisor (MCD):

* la vía rápida (usando el lenguaje nativo) 
* y la vía algorítmica (implementando el famoso Algoritmo de Euclides).

1. **La forma "RubyWay" (Nativa)**. Ruby ya incluye el método `gcd()` directamente en la clase Integer. Es la opción más cómoda.

```ruby
a = 48
b = 18

result = a.gcd(b)

puts "El MCD de #{a} y #{b} es: #{result}"
# Salida: El MCD de 48 y 18 es: 6
```

2. **Implementación con el Algoritmo de Euclides**:

* El `MCD(a, b)` es lo mismo que `MCD(b, (a mod b))`.
* El proceso se repite hasta que el resto sea cero.

```ruby

def calcular_mcd(a, b)
  b == 0 ? a : calcular_mcd(b, a % b)
end

puts calcular_mcd(48, 18) # Salida: 6
```