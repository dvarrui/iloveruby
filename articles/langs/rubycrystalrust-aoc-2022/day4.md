
# Ruby/Crystal/Rust Advent of Code 2022 - Day 4(traducido)

```
Kirk Haines
Dec 28, 2022
https://wyhaines.io/rubycrystalrust-advent-of-code-2022-day-4
```

El día 4 da un giro interesante con nuestras soluciones Rust, y otro giro hacia la paridad arquitectónica con las soluciones Ruby y Crystal. Rust no está orientado a objetos de la misma manera que los otros dos lenguajes, pero tiene características orientadas a objetos que, hasta ahora en AoC, he estado ignorando. Al mismo tiempo, esta solución es la primera que aborda el concepto de duración en Rust. ¡Sigue leyendo para ver cómo se une el día 4!

# El repositorio

Todo el código de las soluciones de este día, así como el archivo de entrada de datos, se pueden encontrar en:

https://github.com/wyhaines/advent-of-code-2022/tree/main/day_4

# Parte 1

Para ver los detalles completos del desafío, visite la página Advent of Code 2022 - Day 4. Sin embargo, la versión tl; dr del desafío es la siguiente:

```
Los Elfos están trabajando para limpiar un campamento y se les han asignado rangos de ID de sección para limpiar. Cada rango se representa como un par de enteros, donde el primer entero representa el inicio del rango y el segundo entero representa el final del rango. Por ejemplo, el rango "2-4" se refiere a las secciones 2, 3 y 4.

Los Elfos han notado que algunas de las tareas se superponen, lo que significa que algunas secciones pueden ser limpiadas por más de un Elfo. Para evitar la duplicación de esfuerzos, los Elfos quieren identificar los pares de tareas en las que un rango contiene completamente al otro. En otras palabras, quieren encontrar pares donde un rango comience y termine dentro del rango del otro. Por ejemplo, en el par "2-5, 3-4", el rango "2-5" contiene completamente el rango "3-4", por lo que se consideraría un par donde un rango contiene completamente al otro.

Los Elfos han creado una lista de pares de asignaciones de secciones y quieren encontrar el número de pares en los que un rango contiene completamente al otro.
```

Entonces, por ejemplo, consideremos el siguiente conjunto de datos de muestra.

```
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
```

Hay dos pares en los que un rango contiene completamente al otro:
* El rango `3-7` en el par `2-8,3-7` está completamente contenido dentro del rango `2-8`.
* El rango `6-6` en el par `6-6,4-6` está completamente contenido dentro del rango `4-6`.

# El enfoque

La tarea de hoy es conceptualmente bastante simple.
* Analizar los datos en una matriz de líneas individuales.
* Transformar la matriz de líneas en una matriz de matrices de dos elementos, siendo cada elemento un rango correspondiente a uno de los pares de enteros en la línea. es decir, `2-8,3-7` se converte en una matriz con dos rangos (que se muestra en la sintaxis de Ruby/Crystal): [(2..8), (3..7)].
* Repetir con cada una de las líneas y determinar si alguno de los rangos está completamente encerrado en el otro.
* Contar el conjunto de rangos.

## Solución Ruby

Esta tarea tiene al menos un par de enfoques básicos diferentes. Lo primero que nos puede venir a la mente es tratar los rangos como matrices/conjuntos y usar métodos de intersección de conjuntos para averiguar si un conjunto encierra completamente al otro. En Ruby y Crystal, esto se puede codificar de la siguiente manera:

```ruby
set = [(2..8), (3..7)]
set_as_arrays = set.map(&:to_a)
set_as_arrays.include?(set_as_arrays[0].to_a & set_as_arrays[1].to_a)
```

La ventaja de este enfoque es que es muy simple. La desventaja, sin embargo, es que es ineficiente. Advent of Code no se trata típicamente de escribir el código más rápido, pero se trata de muchas matrices, luego realiza una intersección de conjuntos bastante costosa. Es mucho trabajo para algo que se puede lograr haciendo solo un puñado de comparaciones económicas de los puntos inicial y final de los rangos, así que elegí hacer las soluciones de esta manera, en lugar de depender de las operaciones establecidas.

```ruby
# frozen_string_literal: true

class CampCleanup
  def initialize(filename)
    assignments = parse_assignments(filename)

    puts "Of #{assignments.size} assignments, #{count_redundant_assignments(assignments)} are redundant."
  end

  def parse_assignments(filename)
    File.read(filename).split("\n").map do |line|
      line.split(",").map do |assignment|
        min, max = assignment.split("-").map(&:to_i)
        (min..max)
      end
    end
  end

  def count_redundant_assignments(assignments)
    assignments.select do |left, right|
      redundant?(left, right)
    end.size
  end

  def redundant?(left, right)
    smaller, larger = sort_by_containment(left, right)
    smaller.min >= larger.min && smaller.max <= larger.max
  end

  def sort_by_containment(left, right)
    if left.min <= right.min && left.max >= right.max
      [right, left]
    else
      [left, right]
    end
  end
end

CampCleanup.new(ARGV[0] || 'input.txt')
```

El código de lectura y análisis de archivos es sencillo.

```ruby
def parse_assignments(filename)
  File.read(filename).split("\n").map do |line|
    line.split(",").map do |assignment|
      min, max = assignment.split("-").map(&:to_i)
      (min..max)
    end
  end
end
```

El archivo se lee en memoria, luego se divide cada línea en una matriz de líneas. Esa matriz se asigna a una nueva matriz, cada línea a su vez se divide por la coma en dos asignaciones separadas, y finalmente la asignación se divide por el guión en dos enteros que representan el extremo inferior y superior del rango de asignación.

Una vez hecho esto, casi la mitad del trabajo para esta tarea ya está completa. Ruby tiene un método, `Array#select`, que llama a un bloque una vez con cada elemento de la matriz. Devuelve una matriz que contiene cada elemento para el cual el bloque se evalúa como verdadero. Si ese bloque puede determinar si uno de los rangos está contenido en el otro, entonces el tamaño de la matriz final es el número de rangos redundantes.

```ruby
def count_redundant_assignments(assignments)
  assignments.select do |left, right|
    redundant?(left, right)
  end.size
end
```

El verdadero trabajo ocurre en la llamada `redundant?(left, right)`. Veamos cómo funciona:

```ruby
def redundant?(left, right)
  smaller, larger = sort_by_containment(left, right)
  smaller.min >= larger.min && smaller.max <= larger.max
end

def sort_by_containment(left, right)
  if left.min <= right.min && left.max >= right.max
    [right, left]
  else
    [left, right]
  end
end
```

Hay que comprobar las tres opciones posibles.
* La asignación de la _izquierda_ encierra completamente la asignación de la _derecha_.
* La asignación de la _derecha_ encierra completamente la asignación de la _izquierda_.
* _Ninguno_ de los anteriores es cierto.

El código anterior lo aborda llamando primero a `sort_by_containment`. Este método hace una cosa. Comprueba si la asignación de la izquierda encierra completamente la asignación de la derecha. Si esto es cierto, entonces sabe que la derecha es igual o menor que la izquierda y está completamente encerrada por la izquierda, por lo que devuelve un resultado en una matriz, `[right, left]`. De lo contrario, asume que la inversa podría ser verdadera, que la izquierda es, de hecho, menor que la derecha y está encerrada por ella, por lo que devuelve la inversa, `[left, right]`.

Luego, el método `redundant?` toma este orden y confirma la hipótesis al validar que cualquier rango que se haya devuelto como el rango más pequeño tiene un mínimo que es mayor o igual que el mínimo del rango más grande supuesto, y que el máximo del rango más pequeño es menor o igual al máximo del rango más grande. Si esto es cierto, entonces se confirma que lo más `pequeño` está completamente encerrado por lo más `grande` y se devuelve verdadero. De lo contrario, se devuelve falso.

Si ha mirado el [código en el repositorio](https://github.com/wyhaines/advent-of-code-2022/blob/main/day_4/day_4_1.rb#L34), habrá visto que hay una nota en la versión de Ruby. Esta implementación es más complicada de lo que debe ser. Dado que, en este caso, solo hay tres resultados discretos, podríamos usar una declaración `if` un poco más grande en lugar de dividir las cosas en dos métodos.

```ruby
def redundant?(left, right)
  if left.min <= right.min && left.max >= right.max
    true
  elsif left.min >= right.min && left.max <= right.max
    true
  else
    false  
  end
end
```

Sin embargo, esto lo sentí como un momento de enseñanza Rust para usar el enfoque de métodos múltiples en lugar de la simple declaración `if` anterior. Continúe leyendo la solución de Rust para ver por qué, pero sepa que lo anterior es la mejor manera de resolver este problema porque es a la vez un poco más eficiente en términos de tiempo de ejecución y más fácil de ver y razonar para una persona.

Sin embargo, de cualquier manera, esta tarea particular de ayudar a esos Elfos laboriosos es bastante simple de implementar en Ruby. ¡Eso también es un buen augurio para Crystal!

## Solución Crystal

Es virtualmente un cortar y pegar de la solución de Ruby.

```ruby
class CampCleanup
  def initialize(filename)
    assignments = parse_assignments(filename)

    puts "Of #{assignments.size} assignments, #{count_redundant_assignments(assignments)} are redundant."
  end

  def parse_assignments(filename)
    File.read(filename).split("\n").reject(&.empty?).map do |line|
      line.split(",").map do |assignment|
        min, max = assignment.split("-").map(&.to_i)
        (min..max)
      end
    end
  end

  def count_redundant_assignments(assignments)
    assignments.select do |(left, right)|
      redundant?(left, right)
    end.size
  end

  def redundant?(left, right)
    smaller, larger = sort_by_containment(left, right)
    smaller.min >= larger.min && smaller.max <= larger.max
  end

  def sort_by_containment(left, right)
    if left.min <= right.min && left.max >= right.max
      [right, left]
    else
      [left, right]
    end
  end
end

CampCleanup.new(ARGV[0]? || "input.txt")
```

Las únicas diferencias están cosas que ya hemos tratado en días anteriores.
* `CampCleanup.new(ARGV[0] || 'input.txt') => CampCleanup.new(ARGV[0]? || "input.txt")`
* `File.read(filename).split("\n").map do |line| => File.read(filename).split("\n").reject(&.empty?).map do |line|`
* `assignments.select do |left, right| => assignments.select do |(left, right)|`

## Solución Rust

Hay mucho que desempaquetar hoy aquí.

```rust
use std::env;

struct CampCleanup {
    assignments: Vec<Vec<Assignment>>,
}

#[derive(Debug)]
struct Assignment {
    start: i32,
    end: i32,
}

impl CampCleanup {
    fn new(filename: &str) -> CampCleanup {
        let assignments = Self::parse_assignments(filename);

        //CampCleanup { assignments }
        Self { assignments }
    }

    fn run(&self) {
        println!(
            "Of {} assignments, {} are redundant.",
            self.assignments.len(),
            self.count_redundant_assignments(&self.assignments)
        );
    }

    fn parse_assignments(filename: &str) -> Vec<Vec<Assignment>> {
        let text = std::fs::read_to_string(filename).unwrap();
        text.lines()
            .map(|line| {
                line.split(",")
                    .map(|assignment| {
                        let mut parts = assignment.split("-");
                        let min = parts.next().unwrap().parse().unwrap();
                        let max = parts.next().unwrap().parse().unwrap();
                        Assignment {
                            start: min,
                            end: max,
                        }
                    })
                    .collect::<Vec<_>>()
            })
            .collect::<Vec<_>>()
    }

    fn count_redundant_assignments(&self, assignments: &Vec<Vec<Assignment>>) -> usize {
        assignments
            .iter()
            .filter(|assignment| self.is_redundant(&assignment[0], &assignment[1]))
            .count()
    }

    fn is_redundant(&self, left: &Assignment, right: &Assignment) -> bool {
        let (smaller, larger) = self.sort_by_containment(left, right);
        smaller.start >= larger.start && smaller.end <= larger.end
    }

    fn sort_by_containment<'a>(
        &self,
        left: &'a Assignment,
        right: &'a Assignment,
    ) -> (&'a Assignment, &'a Assignment) {
        if left.start <= right.start && left.end >= right.end {
            (right, left)
        } else {
            (left, right)
        }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let mut filename = "input.txt";
    if let Some(arg) = args.get(1) {
        filename = arg;
    }

    CampCleanup::new(filename).run();
}
```

Si ha estado siguiendo los [días anteriores](https://wyhaines.io/rubycrystalrust-advent-of-code-2022-day-3), verá que he hecho un cambio en la estructura de la solución Rust desde los primeros días.

Rust no está orientado a objetos como lo son lenguajes como Ruby o Crystal. Si bien esto me sale mejor, las capacidades de programación orientada a objetos de Rust me recuerdan mucho al diseño OO de Perl. A partir de esta solución, las soluciones de Rust ahora están estructuradas de una manera que se asemeja más a cómo están estructuradas las soluciones de Ruby y Crystal, con un objeto que se puede instanciar para resolver la tarea del día.

Sin ánimo de convertir este artículo en un tutorial completo sobre cómo hacer programación orientada a objetos en Rust, echemos un vistazo rápido a esa implementación.

```
struct CampCleanup {
    assignments: Vec<Vec<Assignment>>,
}

impl CampCleanup {
    fn new(filename: &str) -> CampCleanup {
        let assignments = Self::parse_assignments(filename);

        CampCleanup { assignments }
    }

    fn run(&self) {
        // Implementation stuff here
    }

    fn parse_assignments(filename: &str) -> Vec<Vec<Assignment>> {
        // implementation stuff here
    }
}
```

En Rust, una clase solo es una estructura a la que se le aplica una implementación. Y la implementación, que se especifica con la palabra clave `impl`, seguida del nombre del `struct` a la que se aplica, y de un bloque que contiene la implementación que es un conjunto de funciones que desempeñan los roles de métodos de clase y métodos de instancia.

La principal diferencia entre si algo es un método de clase o un método de instancia se encuentra en su definición y se refleja en cómo se llama.

Los métodos de clase son esencialmente funciones. Sin embargo, se requiere que los métodos de instancia acepten `&self` como su primer argumento. Se llaman usando la sintaxis de puntos:

```
some_rust_object.method_call("an argument")
```

Cuando se llama con esta sintaxis, Rust sabe pasar, implícitamente, una referencia a `some_rust_object` como su primer argumento. La firma de la función, sin embargo, debe escribirse de manera que pueda aceptar lo siguiente:

```
fn method_call(&self, text: &str) {
    // Implementation here
}
```

Entendido esto, echemos un vistazo más de cerca a la implementación específica de hoy.

```rust
#[derive(Debug)]
struct Assignment {
    start: i32,
    end: i32,
}

impl CampCleanup {
    fn new(filename: &str) -> CampCleanup {
        let assignments = Self::parse_assignments(filename);

        CampCleanup { assignments }
    }

    fn parse_assignments(filename: &str) -> Vec<Vec<Assignment>> {
        let text = std::fs::read_to_string(filename).unwrap();
        text.lines()
            .map(|line| {
                line.split(",")
                    .map(|assignment| {
                        let mut parts = assignment.split("-");
                        let min = parts.next().unwrap().parse().unwrap();
                        let max = parts.next().unwrap().parse().unwrap();
                        Assignment {
                            start: min,
                            end: max,
                        }
                    })
                    .collect::<Vec<_>>()
            })
            .collect::<Vec<_>>()
    }
}
```

En el código anterior, se ve otra definición de `struct`, para `Assignment`. Esta estructura es un simple contenedor para los valores inicial y final de la tarea. Se podría haber usado `Range`: `(mín..=máx)`, pero usar `Range` conlleva algunos desafíos, que podrían describirse en un artículo completo, y además son más pesados de lo que necesitamos, dado que todo lo que se requiere para esta solución son los números que indican el inicio y el final del intervalo de asignación.

El método constructor, `new()`, sólo tiene dos tareas. Llamar a un método de clase para analizar las asignaciones: `Self::parse_assignments(filename)`. Esto a su vez llama a la función p`arse_assignments()` en la implementación de `CampCleanup`, pasándole un nombre de archivo. Luego hace esto:

```
CampCleanup { assignments }
```

Eso crea la instancia de `CampCleanup`, que es lo que devuelve `new()`. También podría haberse escrito como `Self {asignaciones}`, porque `Self` se refiere al módulo actual. En este caso, es más claro ser explícito sobre lo que se devuelve.

No hay nada particularmente novedoso en el método `parse_assignments()`, si lo has estado siguiendo días anteriores. Lo único sobre lo que llamaremos la atención es el hecho de que, como método de clase, su definición no es diferente a la de cualquier otra función. Los métodos de clase son esencialmente solo funciones que existen dentro de la estructura/espacio de nombres en el que se definieron.

Lo que sigue a continuación es el núcleo de la solución.

```rust
fn run(&self) {
    println!(
        "Of {} assignments, {} are redundant.",
        self.assignments.len(),
        self.count_redundant_assignments(&self.assignments)
    );
}

fn count_redundant_assignments(&self, assignments: &Vec<Vec<Assignment>>) -> usize {
    assignments
        .iter()
        .filter(|assignment| self.is_redundant(&assignment[0], &assignment[1]))
        .count()
}

fn is_redundant(&self, left: &Assignment, right: &Assignment) -> bool {
    let (smaller, larger) = self.sort_by_containment(left, right);
    smaller.start >= larger.start && smaller.end <= larger.end
}

fn sort_by_containment<'a>(
    &self,
    left: &'a Assignment,
    right: &'a Assignment,
) -> (&'a Assignment, &'a Assignment) {
    if left.start <= right.start && left.end >= right.end {
        (right, left)
    } else {
        (left, right)
    }
}
```

Recordemos que en el método `main()`, se creó una instancia de la estructura `CampCleanup` y luego se llamó al método `run()` en la misma línea, `CampCleanup::new(filename).run();`.

El método `run()` es un método de instancia. En Rust, se requiere que los métodos de instancia tengan a `&self` como su primer argumento. La sintaxis de llamada para dicho método pasa implícitamente una referencia a la instancia del objeto en el que se ejecuta el código.

Por lo tanto, en el método `run()`, se pueden hacer referencias a otros métodos de instancia a través de `self`:

```rust
fn run(&self) {
    println!(
        "Of {} assignments, {} are redundant.",
        self.assignments.len(),
        self.count_redundant_assignments(&self.assignments)
    );
}
```

El cálculo real del número de asignaciones redundantes se maneja en el método `count_redundant_assignments()`. Puede que haya notado que algo diferente de la mayoría del código de Rust que he escrito para AoC hasta ahora en la llamada al método y la definición del método.

El método se llama a través de `self.count_redundant_assignments(&self.assignments)` y la definición se ve así: `fn count_redundant_assignments(&self, asignaciones: &Vec<Vec<Assignment>>) -> usize`. El código no está pasando `self.assignments` en sí mismo. En su lugar, está pasando una referencia a `self.assignments` (Esto es `&self.assignments`). Si uno intentara pasar `assignments`, habría un error.

```
error[E0507]: cannot move out of `self.assignments` which is behind a shared reference
  --> day_4_1.rs:25:46
   |
25 |             self.count_redundant_assignments(self.assignments)
   |                                              ^^^^^^^^^^^^^^^^ move occurs because `self.assignments` has type `Vec<Vec<Assignment>>`, which does not implement the `Copy` trait
```

Puede leer más sobre el atributo `Copy` en la documentación de Rust, pero en esencia, si se implementa a través de una línea `#[derive(Copiar)]` en `struct Assignment`, se permitiría duplicar instancias de esa estructura. Esto no es necesario para esta solución, por lo que en su lugar, pasaremos una referencia a `Vec<Vec<Assignment>>`.

`count_redundant_assignments()` crea un iterador a partir del `Vec` que recibe. Esa llamada tiene otra característica interesante de Rust.

```rust
fn count_redundant_assignments(&self, assignments: &Vec<Vec<Assignment>>) -> usize {
    assignments
        .iter()
        .filter(|assignment| self.is_redundant(&assignment[0], &assignment[1]))
        .count()
}
```

La firma nos dice que el método recibe dos referencias. Una es una referencia a sí mismo, y la otra, una referencia a las asignaciones. Sin embargo, en el cuerpo del método, no se eliminan las referencias ni a sí mismo ni a las asignaciones. Para ver lo que quiero decir, el siguiente código funcionará de manera idéntica:

```rust
fn count_redundant_assignments(&self, assignments: &Vec<Vec<Assignment>>) -> usize {
    (*assignments)
        .iter()
        .filter(|assignment| (*self).is_redundant(&assignment[0], &assignment[1]))
        .count()
}
```

Un asterisco inicial, como en `*assignments`, es un [operador de desreferenciación](https://rustwiki.org/en/reference/expressions/operator-expr.html#the-dereference-operator). Permite que el programa acceda al valor al que apunta una referencia. En el código que escribí, no desreferencié `assignments` ni a `self` antes de usarlos, y aun así funcionó. ¿Pero qué está sucediendo?

El lenguaje Rust [fuerza implícitamente una operación de desreferenciación](https://doc.rust-lang.org/book/ch15-02-deref.html#implicit-deref-coercions-with-functions-and-methods) en los argumentos de funciones y métodos si el tipo en cuestión implementa el `trait` `Deref`. Esto permite mantener el código visualmente más limpio y elimina una pequeña cantidad de escritura.

El código de este método crea un iterador para `Vec` y luego llama a `filter()` sobre él. El método `filter()` filtra los elementos para los cuales la evaluación del bloque devuelve `true`. El método `is_redundant()` toma las asignaciones izquierda y derecha y determina si una es redundante con respecto a la otra; es decir, si está completamente encerrado por el rango del otro. Luego llamamos a `count()` sobre los elementos que quedan para determinar el número de pares de asignaciones donde haya uno encerrado por el otro.

La verdadera esencia de todo esto, al igual que con las versiones de Ruby y Crystal, está en los métodos `is_redundant()` y `sort_by_containment()`. También es interesante ver cómo se definen estos métodos mediante formas interesantes que no han aparecido en soluciones anteriores de AoC Rust. Así que concentrémonos en esos dos métodos por un momento.

```rust
fn is_redundant(&self, left: &Assignment, right: &Assignment) -> bool {
    let (smaller, larger) = self.sort_by_containment(left, right);
    smaller.start >= larger.start && smaller.end <= larger.end
}

fn sort_by_containment<'a>(
    &self,
    left: &'a Assignment,
    right: &'a Assignment,
) -> (&'a Assignment, &'a Assignment) {
    if left.start <= right.start && left.end >= right.end {
        (right, left)
    } else {
        (left, right)
    }
}
```

El método `is_redundant()` es, más o menos, idéntico a la versión Ruby y Crystal. Sin embargo, si observa la sintaxis utilizada para definir `sort_by_containment()`, debería notar algo nuevo. ¿Qué es esa `'a` que hay en la definición del método?

Esa, amigo mío, es la sintaxis para especificar un [Lifetime](https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/lifetimes.html) en Rust. Lifetime es una forma de garantizar que las referencias en su código sean válidas y no estén colgando (es decir, apuntando a una ubicación en la memoria que ha sido desasignada). Antes de continuar, esto es lo que sucede si intenta compilar la solución de Rust sin la sintaxis lifetime en ese método:

```rust
error: lifetime may not live long enough
  --> day_4_1.rs:78:13
   |
73 |         &self,
   |         - let's call the lifetime of this reference `'2`
74 |         left: &Assignment,
   |               - let's call the lifetime of this reference `'1`
...
78 |             (right, left)
   |             ^^^^^^^^^^^^^ associated function was supposed to return data with lifetime `'2` but it is returning data with lifetime `'1`
   |
help: consider introducing a named lifetime parameter and update trait if needed
   |
72 ~     fn sort_by_containment<'a>(
73 ~         &'a self,
74 ~         left: &'a Assignment,
   |

error: lifetime may not live long enough
```

Esto significa que el compilador no está seguro de que las referencias que devuelve esta función vivirán lo suficiente. Si se desasignan antes de que se usen, daría como resultado un error, y el compilador quiere evitar eso, por lo que arroja un error y le aconseja al programador que use una lifetime explícito.

Sería lógico suponer que toda una vida tiene algún tipo de poder prescriptivo. Es decir, le dice al compilador/comprobador de préstamos cómo administrar la desasignación de datos. Sin embargo, las vidas son descriptivas. El momento en que se desasignan los datos se determina únicamente por cómo se escribe el código. El tiempo de vida solo permite que el programador ayude al compilador a comprender situaciones más complejas.

Volviendo a `sort_by_containment()`, la especificación de por vida:

```rust
sort_by_containment<'a>(
        &self,
        left: &'a Assignment,
        right: &'a Assignment,
    ) -> (&'a Assignment, &'a Assignment)
```

le está diciendo al compilador que las referencias devueltas por la función tendrán la misma duración que las referencias pasadas a la función. Por lo tanto, el compilador está satisfecho de que todo vivirá lo suficiente como para evitar el error de intentar acceder a algún dato que ha sido desasignado. Las vidas son un concepto importante, y si aún te parecen desconcertantes, vale la pena que revise [esa parte del Rust Book](https://web.mit.edu/rust-lang_v1.25/arch/amd64_ubuntu1404/share/doc/rust/html/book/first-edition/lifetimes.html) para tener información más detallada.

Con soluciones en los tres lenguajes, podríamos terminar. Sin embargo, los Elfos no están satisfechos. Quieren más información.

# Parte 2
...

# Conclusión

El desafío del día 4 fue bastante simple, en los tres lenguajes. Elegí una respuesta un poco más compleja y menos eficiente para el Día 1 simplemente para presentar el concepto de lifetime de Rust. De lo contrario, la solución del Día 1 habría sido tan simple como la solución del Día 2. Los tiempos de vida en Rust son cruciales para que un desarrollador de Rust los entienda porque no siempre podremos elegir una solución que no los necesite.
