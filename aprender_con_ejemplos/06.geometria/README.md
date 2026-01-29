[<< back](../README.md)

# Un poco de geometría

Enunciado:
* Pedir al usuario las coordenadas X e Y de dos puntos en el espacio.
* Mostrar por pantalla la distancia en línea recta entre esos dos puntos.
* Mostrar por pantalla las coordenadas del punto medio exacto de ambos.

**[Ejemplo 1](./01-geometria.rb): Pedir al usuario las coordenadas X e Y de dos puntos en el espacio.**

(Sin comentarios)

**[Ejemplo 2](./02-geometria.rb): Mejoramos la salida por pantalla.**

(Sin comentarios)

**[Ejemplo 3](./03-geometria.rb): Mostrar por pantalla la distancia en línea recta entre esos dos puntos.**

Para calcular la distancia en línea recta entre dos puntos en un plano cartesiano (distancia euclidiana), utilizamos el Teorema de Pitágoras. Donde, la fórmula matemática es: `d=raiz_cuadrada( (x2​−x1​)^2 + (y2​−y1​)^2)​`

* Para calcular la raíz cuadrada usamos el método `sqrt()` del módulo `Math`. Un módulo en Ruby es como una clase de POO pero que no puede tener instancias (esto es, no sirve para construir nuevos objetos), y sus métodos son estáticos del módulo y públicos por defecto para poder ser consumidos por cualquier otro método, objeto, clase, etc. Profundizaremos más en las posibilidades que ofrecen los módulos más adelante, De momento, para nosotros, el módulo nos sirve a modo de "contenedor" de funciones públicas.
* Calcular el cuadrado es lo mismo que elevar a exponente 2. Ejemplo, x al cuadrado es `x**2`, y x al cubo `x**3`. Mmmm visto así, elevar a 1/2 sería lo mismo que calcular la raíz cuadrada ¿verdad?

```
>> 4**(1/2.0)
=> 2.0

>> 4**(0.5)
=> 2.0
```

¡Pues, sí!

**[Ejemplo 4](./04-geometria.rb): Mostrar por pantalla las coordenadas del punto medio exacto de ambos.**

---

_Hasta aquí hemos terminado de "evolucionar" las "listas", ahora puedes seguir con el siguiente problema._