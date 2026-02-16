[<< back](./README.md)

# 3. Todo es un objeto

Lo siguiente que debes saber de Ruby, es que "todo es un objeto" (o casi casi todo). Ruby fue creado por Matz inspirándose en List, Perl y Samlltalk. Y precisamente del Smalltalk de Alan Kay "copió" la idea de que "todo es un objeto" y que invocar un método es lo mismo que enviarle un mensaje a dicho objeto. Por ejemplo: `perro.ladrar()` produce el mismo efecto que `perro.send(:ladrar)`.

> NOTA: `:ladrar` es un símbolo o cadena de texto inmutable. La tienen otros lenguajes de programación. En Elixir las llaman átomos.

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

> Si no estás agusto con el paradigma de programación orientada a objetos... Ruby no es para tí. Pero si le das una oportunidad igual te gusta.

**Reflexión**

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