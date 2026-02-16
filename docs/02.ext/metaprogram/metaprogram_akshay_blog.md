[<< back](../README.md)

# Metaprogramming Ruby 2 (traducido al español)

> Enlaces de interés:
> * Metaprogramming in Ruby: https://www.akshaykhot.com/metaprogramming-ruby/
> * Akshay's Blog (https://www.akshaykhot.com/metaprogramming-ruby/)

```
Though it looks like magic, it’s still just programming.
This book will help you really understand the Rails source code.
```

La metaprogramación en Ruby nos permite crear programas elegantes, limpios y bonitos, así como código complejo e ilegible que no se puede mantener.

El principal beneficio que encontré de la metaprogramación no fue tanto escribir código inteligente, sino leer y comprender el código fuente abierto, especialmente el código fuente de Rails.

Rails hace un uso abundante de la metaprogramación. Tener el conocimiento de estos conceptos hace posible leer y comprender el código fuente para obtener una apreciación más profunda del marco de Rails y revelar su magia.

![](https://www.akshaykhot.com/content/images/2022/09/metaprogramming_ruby-1.jpeg)

## El modelo de objetos

Los objetos son ciudadanos de primera clase en Ruby. Los verás en todas partes. Sin embargo, los objetos son parte de un mundo más grande que también incluye otras construcciones del lenguaje, como clases, módulos y variables de instancia. Todas estas construcciones viven juntas en un sistema llamado modelo de objeto.

En la mayoría de los lenguajes de programación, las construcciones del lenguaje como variables, clases, métodos, etc. están presentes mientras programa, pero desaparecen antes de que se ejecute el programa. Se transforman en código de bytes (Java) o CIL (C#), o código de máquina simple (C). No se pueden modificar estas representaciones una vez que el programa ha sido compilado.

En Ruby, sin embargo, la mayoría de las construcciones del lenguaje todavía están ahí. Puedes hablar con ellos, consultarlos, manipularlos. Esto se llama introspección. Por ejemplo, el siguiente ejemplo crea una instancia de una clase y solicita sus variables de clase e instancia.

```ruby
class Language
  def initialize(name, creator)
    @name = name
    @creator = creator
  end
end

ruby = Language.new("Ruby", "Matz")

pp ruby.class              # Language
pp ruby.instance_variables # [:@name, :@creator]
```

## Clases abiertas

Se puede abrir cualquier clase y agregarle nuevos métodos. Por ejemplo, abramos la clase String y agreguemos un nuevo método para iniciar sesión en ella.

```ruby
class String
  def log
    puts ">> #{self}"
  end
end

"Hello World".log	# >> Hello World
```

Esto se denomina [monkey-patching](https://en.wikipedia.org/wiki/Monkey_patch) y puede causar problemas si redefine los métodos existentes sin querer. Sin embargo, si sabe lo que está haciendo, monkey-patching puede ser muy poderoso. Por ejemplo, la gema ActiveSupport en Rails hace un uso intensivo de monkey-patching para abrir las clases principales de Ruby y definir nuevas funciones en ellas.

## Variables de instancia frente a métodos de instancia

Las variables de instancia de un objeto viven en el objeto mismo, y los métodos de un objeto viven en la clase del objeto.

![](https://www.akshaykhot.com/content/images/size/w1000/2022/09/instance.png)

Por esa razón los objetos de la misma clase comparten métodos pero no comparten variables de instancia.

## Las clases son objetos

Todo lo que se aplica a los objetos también se aplica a las clases. Cada clase es también un módulo con tres métodos de instancia adicionales: `new`, `allocate`, y `superclass`.

```ruby
class MyClass
  def my_method
    @v = 1
  end
end

puts MyClass.class        # Class
puts MyClass.superclass   # Object
puts Class.superclass     # Module
puts Object.class         # Class
puts Object.superclass    # BasicObject
pp BasicObject.superclass # nil
```

## ¿Qué sucede cuando se llama a un método?

Cuando se llama a un método, Ruby hace lo siguiente:

1. Encuentra el método mediante _method lookup_. Para esto, el intérprete de Ruby analiza la clase receptora, incluida la cadena de antepasados.
2. Ejecuta el método usando `self`.

El receptor es el objeto sobre el que se llama a un método, por ejemplo, en la sentencia `myObj.perform()`, `myObj` es el receptor.

La cadena de ancestros es la ruta de las clases desde una clase a su superclase, hasta llegar a la raíz, es decir, `BasicObject`.

![](https://www.akshaykhot.com/content/images/2022/09/inheritance-chain.jpeg)

## El Kernel

La clase `Object` incluye el módulo `Kernel`. Por tanto, los métodos definidos en `Kernel` están disponibles para todos los objetos. Además, cada línea en Ruby se ejecuta dentro de un objeto principal. Por lo tanto, se pueden llamar a los métodos de `Kernel`, como `puts`, desde cualquier lugar.

Si agrega un método a `Kernel`, estará disponible para todos los objetos y puede llamarse desde cualquier lugar.

```ruby
module Kernel
  def log(input)
    puts "Logging `#{input}` from #{self.inspect}"
  end
end

# Logging `hello` from main
log "hello"

# Logging `a` from "hello"
"hello".log("a")

# Logging `temp` from String
String.log("temp")
```

## La palabra clave `self`

El intérprete de Ruby ejecuta todas y cada una de las líneas dentro de un objeto: el objeto `self`. Aquí hay algunas reglas importantes con respecto a `self`.

* `self` cambia constantemente a medida que se ejecuta un programa.
* Solo un objeto puede ser `self` en un momento dado.
* Cuando se llama a un método, el receptor se convierte en `self`.
* Todas las variables de instancia son variables de instancia de `self`, y todos los métodos sin un receptor explícito se llaman desde `self`.
* Tan pronto como llama a un método en otro objeto, ese otro objeto (receptor) se convierte en `self`.

En el nivel superior, `self` es `main`, que es un `Object`. Tan pronto como se inicia un programa de Ruby, el intérprete de Ruby crea un objeto llamado `main` y todo el código subsiguiente se ejecuta en el contexto de este objeto. Este contexto también se denomina contexto de nivel superior.

```ruby
puts self       # main
puts self.class # class
```

En una definición de clase o módulo, el rol de `self` lo asume la propia clase o módulo.

```ruby
puts self  # main

class Language
  puts self  # Language

  def compile
    puts self  # #<Language:0x00007fc7c191c9f0>
  end
end

ruby = Language.new
ruby.compile
```

# Definición dinámica de clases y métodos

El constructor `Class` y `define_method` permiten generar clases y métodos sobre la marcha, mientras se ejecuta el programa.

```ruby
Language = Class.new do
  define_method :interpret do
    puts "Interpreting the code"
  end
end

Language.new.interpret # Interpreting the code
```

## Lamada dinámica de métodos

Cuando se llama a un método, en realidad se está enviando un mensaje a un objeto.

```ruby
my_obj.my_method(arg)
```

Ruby proporciona una sintaxis alternativa para llamar a un método dinámicamente, utilizando el método `send`. Esto se llama envío dinámico y es una técnica poderosa, ya que se puede esperar hasta el último momento para decidir a qué método llamar, mientras el código está en ejecución.

```ruby
my_obj.send(:my_method, arg)
```

## Missing Methods

Cuando se llama a un método en un objeto, el intérprete de Ruby va a la clase del objeto y busca el método de instancia. Si no lo puede encontrar, busca en la cadena principal de la clase, hasta llegar a `BasicObject`. Si no encuentra el método en ninguna parte, llama a un método llamado `method_missing` en el receptor original, es decir, el objeto.

El método `method_missing` se define originalmente en la clase `BasicObject`. Sin embargo, puede anularlo en su clase para interceptar y manejar métodos desconocidos.

```ruby
class Language
  def interpret
    puts "Interpreting"
  end

  def method_missing(name, *args)
    puts "Method #{name} doesn't exist on #{self.class}"
  end
end

ruby = Language.new
ruby.interpret # Interpreting
ruby.compile   # Method compile doesn't exist on Language
```

## instance_eval

Este método `BasicObject#instance_eval` evalúa un bloque en el contexto de un objeto.

```ruby
class Language
  def initialize(name)
    @name = name
  end

  def interpret
    puts "Interpreting the code"
  end
end

puts "***instance_eval with object***"

ruby = Language.new "Ruby"

ruby.instance_eval do
  puts "self: #{self}"
  puts "instance variable @name: #{@name}"
  interpret
end

puts "\n***instance_eval with class***"

Language.instance_eval do
  puts "self: #{self}"

  def compile
    puts "Compiling the code"
  end

  compile
end

Language.compile
```

El programa anterior produce la siguiente salida.

```
***instance_eval with object***
self: #<Language:0x00007fc6bb107730>
instance variable @name: Ruby
Interpreting the code

***instance_eval with class***
self: Language
Compiling the code
Compiling the code
```

## Definiciones de clase

Una definición de clase de Ruby es solo un código normal que se ejecuta. Cuando usa la palabra clave `class` para crear una clase, no solo está dictando cómo se comportarán los objetos en el futuro. En realidad estás ejecutando código.

```ruby
class MyClass
  puts "Hello from MyClass"
  puts self
end

# Output
# Hello from MyClass
# MyClass
```

## class_eval()

Evalúa un bloque en el contexto de una clase existente. Esto le permite reabrir la clase y definir un comportamiento adicional en ella.

```ruby
class MyClass
end

MyClass.class_eval do
  def my_method
    puts "#{self}"
  end
end

MyClass.new.my_method  # #<MyClass:0x00007f945e110b80>
```

Una ventaja de `class_eval` es que fallará si la clase no existe. Esto le impide crear nuevas clases accidentalmente.

## Clases y métodos Singleton

Se puede definir métodos en objetos individuales, en lugar de definirlos en la clase del objeto.

```ruby
animal = "cat"

def animal.speak
  puts self
end

animal.speak  # cat
```

Cuando se define el método singleton en el objeto `animal`, Ruby hace lo siguiente:

1. Se crea una nueva clase anónima, también llamada singleton/eigenclass (clase propia).
2. Se define el método `speak`en esa clase.
3. Se hace que esta nueva clase sea la clase del objeto `animal`.
4. Se hace que la clase original del objeto (String), la superclase de la clase singleton.

`animal -> Singleton -> String -> Object`

> **NOTA DEL TRADUCTOR**: Los objetos siempre se crean con una clase y una clase singleton. Ejemplo:
> ```ruby
dog = "dog"
dog.class # => String
dog.singleton_class # => #<Class:#<String:0x00007f9f0b02ddf0>>
> ```
> De modo que realmente el objeto tiene la siguiente cadena de herencia:
> ```ruby
dog.singleton_class.ancestors
=>
[#<Class:#<String:0x00007f9f0b02ddf0>>,
 String,
 Comparable,
 Object,
 PP::ObjectMixin,
 Kernel,
 BasicObject]
> ```
> Aunque para "simplificar" se podría dar por "válida" la explicación anterior.

Las clases son objetos y los nombres de clase son solo constantes. Llamar a un método en una clase es lo mismo que llamar a un método en un objeto.

> La superclase de la clase singleton de un objeto es la clase del objeto. La superclase de la clase singleton de una clase es la clase singleton de la superclase de la clase.

Se pueden definir atributos en una clase de la siguiente manera:

```ruby
class Foo
  class << self
    attr_accessor :bar
  end
end

Foo.bar = "It works"
puts Foo.bar
```

Recuerde que un atributo es solo un par de métodos. Si define un atributo en la clase singleton, se convierten en métodos de clase.

> **NOTA DEL TRADUCTOR**: Realmente un atributo es un atributo privado. Esto es que no se podría acceder desde fuera del objeto. Por ello es necesario crear métodos públicos (getter y setter) para acceder al valor del atributo.
> Ruby permite crear los métodos getter y setter con el mismo nombre de los atributos, y da la "ilusión" de que accedemos directamente al atributo pero no. Accedemos al método.
> Por ejemplo la siguente definición de clase:
> ```ruby
class Person
  attr_accesor :name
end
> ```
> Es equivalente a esta otra:
> ```ruby
class Person
  def name
    @name
  end
  def name=(name)
    @name = name # Attribute definition
  end
end
> ```
> Realmente attr_accesor no crea atributos, sino métodos getter y setter.
> ```ruby
jedi = Person.new
jedi.name = "Obiwan"
jedi.name # => "Obiwan"  
> ```

## Conclusión

Mantenga su código lo más simple posible y agregue complejidad a medida que lo necesite.

Aunque la metaprogramación en Ruby parece magia, sigue siendo solo programación. Está muy arraigado que apenas se puede escribir Ruby idiomático sin usar algunas técnicas de metaprogramación.

Ruby espera que cambie el modelo de objeto, vuelva a abrir clases, defina métodos dinámicamente y cree/ejecute código sobre la marcha.

Escribir un código de metaprogramación perfecto puede ser difícil al principio, por lo que generalmente es más fácil ir mejorando el código sobre la marcha.

Cuando comience, esfuércese por hacer que su código sea correcto en los casos generales y lo suficientemente simple como para que pueda agregar casos especiales más adelante.
