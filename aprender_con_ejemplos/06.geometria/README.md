[<< back](../README.md)

# Un poco de geometría

Enunciado:
* Pedir al usuario las coordenadas X e Y de dos puntos en el espacio.
* Mostrar por pantalla la distancia en línea recta entre esos dos puntos.
* Mostrar por pantalla las coordenadas del punto medio exacto de ambos.

**[Ejemplo 1](./01-geometria.rb): Pedir al usuario las coordenadas X e Y de dos puntos en el espacio.**

(Sin comentarios)

**[Ejemplo 2](./02-geometria.rb): Mejoramos la salida por pantalla.**

A parte de moejorar la salida por pantalla añadiendo color. Hemos creido conveniente que el código era más legible si pasábamos los valores del Array de 2x2 a variables independientes. Por ahora, nos vale así.

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

**[Ejemplo 5](./05-geometria.rb): Refactorizar con Structs.**

No me quedé del todo contento con la forma de almacenar los datos.
* Primero leemos los datos y los guardamos en un Array 2x2 donde las posiciones de almacenamiento dentro del Array tienen un significado concreto. Por ejemplo: punto 0 vs punto 1, x vs y.
* Luego tampoco me termina de dejar contento el que hubiéramos pasado el contenido del Array 2x2 a variables independientes `x0, y0, x1, y1`. Ahora sólo sólo 2 puntos, pero si fueran 10 puntos, o 20, entonces se volvería todo un poco engorroso.

En Ruby, un Struct es la forma más rápida y elegante de crear una clase pequeña para agrupar atributos como coordenadas.

```ruby
# Definición de un Struct llamado Point
Point = Struct.new(:x, :y)

# Uso
punto = Point.new(10, 20)
punto.x  # => 10
punto.y = 30
```


---
2. Definición con lógica interna (Recomendado)

Podemos abrir un bloque al definir el Struct para añadirle métodos, como el cálculo de distancia que vimos antes.
Ruby

Point = Struct.new(:x, :y) do
  # Método para calcular distancia a otro punto
  def distance_to(other)
    Math.hypot(other.x - x, other.y - y)
  end

  # Representación amigable en consola
  def to_s
    "(#{x}, #{y})"
  end
end

p0 = Point.new(0, 0)
p1 = Point.new(3, 4)

puts "La distancia de #{p0} a #{p1} es #{p0.distance_to(p1)}"
# => La distancia de (0, 0) a (3, 4) es 5.0

3. Ventajas de usar Struct en lugar de una Clase

    Comparación automática: Si creas dos puntos con las mismas coordenadas Point.new(1,1) == Point.new(1,1), Ruby te dirá que son iguales (true). En una clase normal, tendrías que programar esa lógica.

    Iteración: Puedes usar métodos como .each o .each_pair sobre los atributos del punto.

    Conversión: Puedes convertirlo a un hash fácilmente con .to_h.

4. keyword_init (Para mayor claridad)

---

Si quieres obligar a pasar los nombres de los parámetros al crear el punto (estilo programación funcional moderna), puedes usar keyword_init:
Ruby

Point = Struct.new(:x, :y, keyword_init: true)

# Ahora se crea así:
punto = Point.new(x: 5, y: 12)

¿Te gustaría que cree un script que genere una secuencia lazy de objetos Point aleatorios para practicar el filtrado por distancia?
---

_Hasta aquí hemos terminado de "evolucionar" las "listas", ahora puedes seguir con el siguiente problema._