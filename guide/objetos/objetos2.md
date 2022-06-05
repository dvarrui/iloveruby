
# Programación Orientada a Objetos en Ruby (Parte 2)

Hemos dicho que por defecto los métodos de los objetos serán públicos, y los atributos serán privados.

Podemos establecer que un método sea privado:

```ruby
class Person
  def initilize(name)
    @name = name
  end

  private

  def laugh
    puts "Hahaha"
  end
end
```

Pero no podemos hacer que un atributo sea público. Si quieres acceder de forma pública a un atributo debes crearte métodos para ello (properties). En otros lenguajes se llama crear getters y setter. Veamos 2 formas de hacerlo:

```ruby
class Person

  def name
    return @name
  end

  def name=(value)
    @name=value
  end
end
```
![Ejemplo](files/objetos-10-getter-setter.rb)

Creo que queda muy claro cuál es el getter y cuál es el setter.

En la filosofía de Ruby está el buscar la felicidad del programador. El crear getters y setters está claro que va a ser algo que usaremos con frecuencia así que Ruby nos quiere ayudar.

```ruby
class Person
  atter_accesor :name
end
```

¡Guau! ¿Y eso? Necesito una explicación...

Vamos paso a paso...

Creo la clase
```
class Person
  ...
end
```

Consulto los ancestros de Person. Esto es, ¿de quién o de quienes hereda la clase Person?

```
>> Person.ancestors
=> [Person, Object, PP::ObjectMixin, Kernel, BasicObject]
```

Ahora consulto todos los métodos de Object que empiecen por el nombre "attr":

```
>> Object.methods.select { |m| m.to_s.start_with? 'attr' }
=> [:attr, :attr_reader, :attr_writer, :attr_accessor]
```

_¡Ajá! ¡Ahí está!_ "attr_accessor" es un método que Person hereda de Object.
¿Y para qué sirve?... pues `attr_accessor :name` crea un getter y un setter para el atributo "name".

Compruebo que efectivamente la clase Person posee el método:

```
>> Person.methods.select { |m| m.to_s.start_with? 'attr' }
=> [:attr, :attr_reader, :attr_writer, :attr_accessor]
```

_¡Exacto! ¡Lo tiene!_

> Si te intriga saber cómo funciona "attr_accessor"... sigue hasta el apartado DSL y Metaprogramación. :-)
