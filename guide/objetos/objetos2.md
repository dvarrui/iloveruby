
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

Creo que queda muy claro cuál es el getter y cuál es el setter.
