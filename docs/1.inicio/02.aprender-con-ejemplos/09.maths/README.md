[<< back](../README.md) | [HOME](../../../index.md)

```
EN CONSTRUCCION!!!
```

# Matemáticas: MCD y MCM

Hacer un programa para:
1. Pedir al usuario dos números enteros N y M.
2. Calcular el máximo común divisor (MCD) de N y M.
3. Mostrar por pantalla em MCD.
4. Calcula y muestra por pantalla el mínimo común múltiplo (MCM) de N y M.
5. Ahora haz lo mismo pero pidiendo varios números al usuario.
6. Almacénalos en una lista y calcula el MCM y el MCD de todos ellos.

---


En Ruby, tienes dos formas principales de calcular el Máximo Común Divisor (MCD): la vía rápida (usando el lenguaje nativo) y la vía algorítmica (implementando el famoso Algoritmo de Euclides).
1. La forma "RubyWay" (Nativa)

Ruby incluye el método gcd directamente en la clase Integer. Es la opción más eficiente y segura.
Ruby

a = 48
b = 18

resultado = a.gcd(b)

puts "El MCD de #{a} y #{b} es: #{resultado}"
# Salida: El MCD de 48 y 18 es: 6

2. Implementación con el Algoritmo de Euclides

Si necesitas hacerlo manualmente (por ejemplo, para un ejercicio de lógica), la forma más elegante en Ruby es mediante recursividad.

El principio es simple: MCD(a,b) es lo mismo que MCD(b,a(modb)). El proceso se repite hasta que el resto es cero.
Shutterstock
Explorar
Ruby

def calcular_mcd(a, b)
  b == 0 ? a : calcular_mcd(b, a % b)
end

puts calcular_mcd(48, 18) # Salida: 6

3. Diferencias entre C y Ruby para el MCD

Ya que hemos estado comparando ambos lenguajes, mira qué curioso:

    En C: Tendrías que preocuparte por si los números son negativos (usando abs()) y por el desbordamiento si los números intermedios fueran muy grandes (aunque en el MCD suelen hacerse más pequeños).

    En Ruby: El método .gcd maneja automáticamente números negativos (siempre devuelve un resultado positivo) y, gracias a lo que vimos de los Bignums, puede calcular el MCD de números con cientos de dígitos sin despeinarse.

¿Cómo funciona el Algoritmo de Euclides?

Imagina que quieres el MCD de 48 y 18:

    Dividimos 48 entre 18: Cociente 2, Resto 12.

    Ahora dividimos 18 entre el resto anterior (12): Cociente 1, Resto 6.

    Dividimos 12 entre 6: Cociente 2, Resto 0.

    Como el resto es 0, el último divisor (6) es el MCD.

¿Te gustaría que creáramos un pequeño script que reciba una lista completa de números y calcule el MCD de todos ellos a la vez?
