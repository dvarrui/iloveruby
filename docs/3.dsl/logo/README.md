
# Logo

El lenguaje Logo (creado por Seymour Papert y su equipo en el MIT) es famoso por su "Geometría de la Tortuga". Fue diseñado bajo una filosofía de construccionismo, donde el aprendizaje ocurre mediante la interacción directa y visual con la máquina.

## 1. Palabras clave (keywords)

Las palabras clave o comandos de Logo están diseñados para ser intuitivos y parecidos al inglés natural, para reducir la carga cognitiva en los principiantes.

Aquí tienes las más importantes, clasificadas por su función:

**1.1 Movimiento de la Tortuga**: Estos comandos controlan cómo se desplaza el cursor (la tortuga) por la pantalla.

| Comando Largo | Abreviatura | Acción                                              |
| ------------- | ----------- | --------------------------------------------------- |
| FORWARD       | FD          | Mueve la tortuga hacia adelante X pasos             |
| BACK          | BK          | Mueve la tortuga hacia atrás X pasos                |
| LEFT          | LT          | Gira la tortuga a la izquierda X grados             |
| RIGHT         | RT          | Gira la tortuga a la derecha X grados               |
| HOME          |             | Envía a la tortuga al centro de la pantalla (0,0)   |
| CLEARSCREEN   | CS          | Borra todo el dibujo y regresa la tortuga al centro |

**1.2 Control del Lápiz**: Permite decidir si la tortuga "dibuja" mientras se mueve o no.

| Comando largo | Abreviatura | Acción                                                 |
| ------------- | ----------- | ------------------------------------------------------ |
| PENUP         | PU          | Levanta el lápiz. La tortuga se mueve sin dejar rastro |
| PENDOWN       | PD          | Baja el lápiz. La tortuga vuelve a dibujar             |
| HIDETURTLE    | HT          | Oculta el icono de la tortuga para ver mejor el dibujo |
| SHOWTURTLE    | ST          | Vuelve a mostrar la tortuga                            |

**1.3 Estructuras de Control y Lógica**: Instrucciones de un lenguaje de programación real.

* `REPEAT`: Permite crear bucles. Ejemplo: `REPEAT 4 [FD 100 RT 90]` (esto dibuja un cuadrado).
* `TO ... END`: Se usa para definir procedimientos (funciones). Ejemplo: `TO CUADRADO REPEAT 4 [FD 50 RT 90] END`.
* `MAKE`: Se usa para asignar valores a variables. Ejemplo: `MAKE "lado 100`.
* `IF / IFELSE`: Para tomar decisiones lógicas.

## 2. Comparativa

Comparativa entre Logo vs. Racket, Ruby y Haskell:
* Con Racket: Logo es un "primo" de Racket. De hecho, Logo es una versión de Lisp simplificada para niños. Bajo el capó, Logo maneja listas y recursión de forma muy similar a Racket.
* Con Ruby: Ambos comparten esa búsqueda de la "humanidad" en el código, usando palabras completas que parecen oraciones.
* Haskell: A diferencia de Haskell, Logo es altamente imperativo. Tú le das órdenes directas a la máquina ("ve allí", "gira aquí").

## 3. HCI

Logo utiliza una "metáfora corporal". Seymour Papert decía que para que un niño entienda RIGHT 90, solo tiene que imaginar su propio cuerpo girando. Esa conexión entre el movimiento físico del humano y el comando de la máquina es lo que hace que Logo sea uno de los diseños de lenguaje más elegantes de la historia.

---
## 4. Hacer un dsl en ruby para imitar a logo

Ruby es un lenguaje flexible y gracias a su metaprogramación y al uso de bloques, podemos hacer que el código Ruby parezca Logo puro.

¿Por qué esto es "Elegancia Ruby"?

Desde la perspectiva de la Interacción Humano-Máquina (HCI), este DSL es potente por tres razones:
* Reducción de Puntuación: Ruby nos permite omitir paréntesis en las llamadas a métodos (fd 100 en lugar de fd(100)), lo que acerca la sintaxis al lenguaje natural de Logo.
* Contexto Implícito: Gracias a `instance_eval`, el usuario no necesita saber qué objeto está moviendo; simplemente da órdenes.
* Extensibilidad: Al ser Ruby, puedes mezclar el DSL con lógica compleja (condicionales, llamadas a APIs, etc.) que el Logo original no tenía.

---
Podrías incluso añadir una gema como gosu o ruby-2d dentro de la clase Turtle para que, en lugar de hacer puts en la consola, se abra una ventana y veas a la tortuga moverse físicamente en tiempo real.

¿Te gustaría que te mostrara cómo integrar una librería gráfica simple para que este DSL realmente dibuje en una ventana?

Si

Para que este DSL no solo imprima texto sino que dibuje de verdad, utilizaremos la gema ruby2d, que es extremadamente sencilla y elegante.

Primero, asegúrate de tener la gema instalada: gem install ruby2d
1. El DSL Gráfico en Ruby

Modificaremos nuestra clase Turtle para que use coordenadas cartesianas y dibuje líneas en una ventana.
Ruby

require 'ruby2d'

class Turtle
  def initialize
    @x, @y = 320, 240 # Centro de una ventana de 640x480
    @angle = 0        # En grados (0 es derecha)
    @pen_down = true
    @color = 'white'
  end

  def forward(steps)
    # Cálculo de la nueva posición usando trigonometría
    new_x = @x + steps * Math.cos(@angle * Math::PI / 180)
    new_y = @y + steps * Math.sin(@angle * Math::PI / 180)
    
    if @pen_down
      Line.new(
        x1: @x, y1: @y,
        x2: new_x, y2: new_y,
        width: 2, color: @color
      )
    end
    
    @x, @y = new_x, new_y
  end

  def right(degrees)
    @angle += degrees
  end

  def left(degrees)
    @angle -= degrees
  end

  def color(c); @color = c; end
  def pen_up;   @pen_down = false; end
  def pen_down; @pen_down = true;  end

  alias_method :fd, :forward
  alias_method :rt, :right
  alias_method :lt, :left
  alias_method :pu, :pen_up
  alias_method :pd, :pen_down
end

# El orquestador del DSL
def logo_gráfico(&block)
  set title: "Ruby Logo DSL", width: 640, height: 480
  turtle = Turtle.new
  turtle.instance_eval(&block)
  show
end

# Re-abrimos Integer para el bucle repeat
class Integer
  def repeat(&block)
    times { instance_eval(&block) }
  end
end

2. Dibujando algo complejo: Un Fractal

Gracias a que nuestro DSL vive dentro de Ruby, podemos usar recursión (como en Haskell o Racket) para dibujar un árbol fractal con sintaxis de Logo.
Ruby

logo_gráfico do
  # Función recursiva dentro del DSL
  def dibujar_arbol(longitud)
    return if longitud < 5
    
    fd longitud
    rt 20
    dibujar_arbol(longitud - 15)
    lt 40
    dibujar_arbol(longitud - 15)
    rt 20
    pu; bk longitud; pd # Volver al origen
  end

  # Posicionar la tortuga
  pu; rt 270; fd 150; pd # Mirar hacia arriba
  color 'green'
  
  # Ejecutar
  36.repeat do
    dibujar_arbol(60)
    rt 10
  end
end

Análisis de la "Elegancia" en este diseño

Desde el punto de vista de la Interacción Humano-Máquina (HCI), hemos creado una jerarquía de elegancia:

    Visibilidad de la Tarea: El usuario no ve la trigonometría (Math.cos), solo ve la intención (forward).

    Extensibilidad del Paradigma: Hemos mezclado el paradigma Imperativo (dar órdenes a la tortuga) con el Funcional (recursión para el árbol), todo bajo una capa de Metaprogramación de Ruby.

    Feedback Inmediato: Al integrar una librería gráfica, reducimos la distancia entre el código y el resultado visual, que es el núcleo del éxito original de Logo.

¿Quién gana aquí?

Si comparamos este DSL con los lenguajes que vimos:
* Es más legible que Go (no hay PascalCase ni manejo de errores ruidoso).
* Es más flexible que Logo original (tienes toda la potencia de Ruby detrás).
* Es menos estricto que Rust (si cometes un error en el ángulo, simplemente el dibujo sale mal, no explota el compilador).

# Enfoque "Pythonic DSL"

Vamos a intentar replicar un DSL en Python para Logo aunque Python sea más rígido que Ruby con su sintaxis.

Mientras que en Ruby puedes omitir paréntesis y usar bloques libremente, en Python estamos obligados a usar paréntesis para llamar funciones.

Sin embargo, Python tiene una ventaja: ya incluye un motor de Logo profesional llamado turtle. Para crear la "sensación" de un DSL, usaremos el contexto de Python para limpiar la sintaxis.

# Comparativa de DSL

Característica	Ruby (DSL)	Python (DSL)
Puntuación
  * RUby Más limpia: fd 100 (sin paréntesis).	
  * Python: Más ruidosa: l.fd(100) (requiere . y ()).
Bloques	Nativos:
  * Ruby: El uso de do...end es perfecto para Logo.
  * Python: Limitados: Las lambda en Python solo permiten una línea de código.
Instalación
  * Ruby: Requiere gemas externas (ruby2d).
  * Python: Baterías incluidas: turtle viene de serie con Python.
Legibilidad
  * Ruby: Se siente como un lenguaje nuevo.
  * ython: Se siente como una librería de Python.
Análisis desde la Interacción Humano-Máquina (HCI)
  * Consistencia Estructural: Python gana aquí. Aunque es menos "mágico" que Ruby, no rompe las reglas del lenguaje para crear el DSL. Esto hace que sea más fácil de predecir para un programador experimentado.
  * Carga de Memoria: En Ruby, instance_eval oculta dónde viven los métodos. En Python, al usar l.fd(), siempre sabes de dónde viene el comando. Esto reduce la posibilidad de errores de "método no encontrado", pero añade ruido visual.
  * Feedback Visual: Ambos lenguajes permiten ver el dibujo en tiempo real, lo que cumple con el principio de manipulación directa de la HCI.

Para crear una experiencia educativa para alguien que no sabe programar, la sintaxis de Ruby es preferible porque es casi indistinguible del Logo real.

# ANEXO

* ver cómo se define una función recursiva en Logo para crear un fractal (como el árbol de Pitágoras)? Es impresionante lo simple que resulta comparado con otros lenguajes.
