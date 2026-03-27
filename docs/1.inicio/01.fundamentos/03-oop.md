[<< back](./README.md)

# 3. Todo es un objeto

Lo siguiente que debes saber de Ruby, es que "todo es un objeto" (o casi casi todo). Ruby fue creado por Matz inspirándose en List, Perl y Smalltalk. Y precisamente del Smalltalk de Alan Kay "copió" la idea de que "todo es un objeto" y que invocar un método es lo mismo que enviarle un mensaje a dicho objeto. Por ejemplo: `perro.ladrar()` produce el mismo efecto que `perro.send(:ladrar)`.

> NOTA: `:ladrar` es un símbolo o cadena de texto inmutable. La tienen otros lenguajes de programación. En Elixir las llaman átomos.

## 3.1 Los String son objetos

Ejemplos con String:

```ruby
# Ejemplo: Cadenas de texto
nombre = "obi-wan kenobi"

nombre.upcase        #=> "OBI-WAN KENOBI"
nombre.send(:upcase) #=> "OBI-WAN KENOBI"

nombre.split   #=> ["obi-wan", "kenobi"]
nombre.reverse #=> "ibonek naw-ibo"
nombre.class   #=> String
```

## 3.2 Los números son objetos

Ejemplos con números:

```ruby
# Ejemplo: Números
age = 55

age.pred  #=> 54
age.next  #=> 56
age.to_s  #=> "55"
age.between?(1, 100) #=> true
age.class #=> Integer
```

> No existe la separación entre tipos de datos primitivos y objetos como tiene Java. Aquí todo son objetos (o casi todo).

## 3.3 Crear nuestra propia clase

Ejemplo [samples/person.rb](./samples/person.rb):

```ruby
# Definir las clase
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def self_introduce
    puts "Person: #{@name} (age: #{@age})"
  end
end

# Crear objetos
obiwan = Person.new("Obiwan", 55)  # Crear objeto de la clase Person
obiwan.self_introduce              # => Person: Obiwan (age: 55)
```

## 3.4 Las clases... son objetos

> **NOTA del autor**
>
> * Esto me "rompió la cabeza" la primera vez que lo ví, porque venía de un "mundo OOP" un tanto estático, rígido y limitado.
> * Hay que profundizar un poco más en el lenguaje para entender las grandes implicaciones que tiene y el "nuevo mundo" de posibilidades que se nos abre por delante.
> * Pero por ahora, nos quedamos con la idea de que "casi" todo son objetos y esto desde cierto punto de vista es **máxima coherencia y máxima simplicidad**. Todo es lo mismo y se trata a todos por igual. Así tenemos pocas reglas que aprender. Sólo necesitamos aprender a usar los objetos/clases y así podemos manejarnos con Ruby al 100%.

Ejemplos: Las clases son objetos también.

```ruby
# Ejemplo: Las clases son objetos
age = 55

age.class           #=> Integer
Integer.class       #=> Class
Integer.class.class #=> Class
```

Ejemplos: Hay clases para los métodos.

```ruby
# Ejemplo: los métodos son objetos
age.method(:to_s)         #=> Devuelve el método "to_s" del objeto "age"
convertir_a_string = age.method(:to_s) #=> #<Method: Integer#to_s(*)>
convertir_a_string.class  #=> Method
```

## 3.5 Reflexión

> **Nota del autor:** Si no estás agusto con el paradigma de programación orientada a objetos... Ruby no es para tí. Pero si le das una oportunidad igual te gusta.

Como hemos dicho Ruby es un lenguaje OOP, no es un lenguaje funcional pero tiene algunas características que con frecuencia se suelen asociar a lenguajes funcionales. Por ejemplo, Ruby no tiene inmutabilidad, pero los objetos tienen el método `freeze()` que los "congela". O dicho de otra manera, los convierte en objetos que no pueden cambiar.

Ejemplo:

```ruby
name = "obi"    #=> "obi"
name << "-wan"  #=> "obi-wan"

name.object_id  #=> 35672
name.frozen?    #=> false

# Congelamos el objeto
name.freeze     #=> "obi-wan"
name.frozen?    # => true
# Es el mismo objeto que antes porque tiene el mismo ID
name.object_id  #=> 35672

name << " kenobi"
# 'String#<<': can't modify frozen #<String>: "obi-wan" (FrozenError) 
```

---
[next >>](./04-irb.md)
