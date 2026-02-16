[<< back](./README.md)

# 6. Clases, objetos, herencia

En Ruby se trabaja mucho con clases y objetos, lógicamente. Vamos con el ejemplo:

```ruby
# Ejemplo: Clase Perro
class Perro
  # Este es el constructor de las intancias
  def initialize(name)
    @name = name
  end

  # Método de instancia (Los paréntesis no son necesarios si no hay argumentos)
  def ladrar
    title + " Guau!"
  end

  private

  def title
    "[#{@name}]"
  end
end

# Ejemplo: objeto snoopy
snoopy = Perro.new("Snoopy")
puts snoopy.ladrar
```

* Una cosa "extraña" a primera vista. Es que los atributos del objeto comienzan con `@`. Por ejemplo, `@name` es el atributo name del objeto y `name` será un nombre de variable local y/o método, y `name()` es un nombre de método.
* Los métodos son públicos por defecto. Para métodos privados se usa la palabra reservada `private`.
* Los atributos son privados, siempre. No se puede hacerlos públicos, pero para ello hay que crear los "getters" y "setters". Y para que no sea "tan pesado" el proceso utilizamos los siguiente:

| Instrucción         | getter                | setter                       |
| ------------------- | --------------------- | ---------------------------- |
| attr_reader :age    | Crea getter `age()`   |                              |
| attr_writter :color |                       | Crear setter `color=(value)` |
| attr_accssor :name  | Crear getter `name()` | Crear setter `name=(value)`  |

`attr_reader`, `attr_writter` y `attr_accessor`, no son palabras reservadas del lenguaje. Son métodos "normales" que están definidos en la clase `Module`. Dado que en Ruby todas las clases son instancias de la clase Class, y Class hereda de Module, el método está disponible automáticamente para ser invocado dentro de cualquier definición de clase o módulo.

Ejemplo: definición de las clase con getter y setter.

```ruby
class Persona
  attr_accessor :name
end

luke = Persona.new
luke.name= "Luke"
luke.name      #=> "Luke"
```

Cuando se crea la definición de la clase `Persona`, se ejecuta lo que hay dentro, y entonces se ejecuta el método `attr_accessor :name`.

Ejemplo: mostrar la herencia de clases y comprobamos dónde se define el método `attr_accessor`.

```ruby
Persona.class  #=> Class
Class.ancestors
# => [Class, Module, Object, JSON::Ext::Generator::GeneratorMethods::Object, PP::ObjectMixin, Kernel, BasicObject]
Module.instance_method(:attr_accessor).owner #=> Module
```

En concreto invocar al método `attr_accessor(:name)` produce el siguiente resultado dentro de la clase `Persona`:

```ruby
class Persona
  # Método setter
  def name=(value)
    @name = value
  end

  # Método getter
  def name
    @name
  end
end
```

Vamos con otro ejemplo:

```ruby
# Ejemplo: Clase Gato

class Gato
  # Crear getter/setter para name y color
  attr_accessor :name, :color
  
  def mauyar
    "[#{@name}] Miau!"
  end

  def to_s
    "Gato: name=#{@name}, color=#{@color}"
  end
end
  
# Ejemplo: objeto garfield
garfield = Gato.new
garfield.name = "Garfield"
garfield.color = "naranja con rayas negras"
puts garfield.mauyar
puts garfield
```

---
[next >>](./07-metodos.md)