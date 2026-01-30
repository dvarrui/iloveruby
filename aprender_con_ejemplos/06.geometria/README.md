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

No me quedé del todo contento con la forma de almacenar los datos. En los ejemplos anteriores se hizo lo siguiente: 
* Leer los datos y los guardamos en un Array 2x2 donde las posiciones de almacenamiento dentro del Array tienen un significado concreto. Por ejemplo: punto 0 vs punto 1, x vs y.
* Pasar el contenido del Array 2x2 a variables independientes `x0, y0, x1, y1`. Ahora sólo tenemos 2 puntos, pero si fueran 10 puntos, o 20, entonces se volvería todo un poco engorroso.

En Ruby, un Struct es la forma más rápida y elegante de crear una pequeña clase para agrupar atributos como por ejemplo las coordenadas del punto.

```ruby
# Definición de un Struct llamado Point
Point = Struct.new(:x, :y)

# Uso
punto = Point.new(10, 20)
punto.x  # => 10
punto.y = 30
```

Entonces, este ejemplo tiene la misma funcionalidad que el anterior pero ahora usamos los Structs en lugar de Arrays o "variables sueltas".

**[Ejemplo 6](./06-geometria.rb): Seguimos refactorizando Structs.**

Los Struct de Ruby son clases, y por tanto, podemos abrir un bloque al definir el Struct para añadirle métodos, como por ejemplo el cálculo de distancia entre dos puntos, o el cálculo del punto medio. 

> **NOTA**: Mientras programaba este ejemplo, he aprendido algo nuevo del módulo `Math`. Este módulo tiene una función `hypot(x, y)` que calcula la hipotenusa de un triángulo rectángulo con lados `x` e `y`, devolviendo `sqrt(x^2+y^2)` como un Float. Es ideal para calcular distancias euclidianas.

Ejemplo:
```ruby
Point = Struct.new(:x, :y) do
  # Calcular distancia a otro punto
  def distance_to(other)
    Math.hypot(other.x - x, other.y - y)
  end

  def to_s
    "(#{x}, #{y})"
  end
end

p0 = Point.new(0, 0)
p1 = Point.new(3, 4)

puts "La distancia de #{p0} a #{p1} es #{p0.distance_to(p1)}"
# => La distancia de (0, 0) a (3, 4) es 5.0
```

> **NOTA**: Las ventajas de usar un Struct en lugar de la típica clase son:
>
> * **Comparación automática**: Si creas dos puntos con las mismas coordenadas Point.new(1,1) == Point.new(1,1), Ruby te dirá que son iguales (`true`). En una clase normal, tendrías que programar esa lógica.
> * **Iteración**: Puedes usar métodos como `.each` o `.each_pair` sobre los atributos del punto.
> * **Conversión**: Puedes convertirlo a un `Hash` fácilmente con `.to_h`.

Con este cambio, se mantiene la misma funcionalidad pero con diferente código. Y se supone que el código ha mejorado porque supone menos esfuerzo entenderlo. Lo que hemos hecho se llama refactorizar.

---

_Hasta aquí hemos terminado de "evolucionar" la "geometría", ahora puedes seguir con el siguiente problema._