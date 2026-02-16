[<< back](./README.md)

# 7. Tenemos métodos, no funciones

En Ruby, estrictamente hablando, no existen las funciones. Y no hay porque todo son métodos. Incluso cuando parece que no hay ningún objeto en "la sala", estamos dentro de uno.

Ejemplo:

```ruby
# Ejemplo: factorial recursivo
def factorial(n)
  return 1 if n <= 1
  n * factorial(n -1)
end

puts factorial(3)   #=> 3! = 3*2*1 = 6
```

Aparentemente, se puede pensar que `factorial()` es una función. Pero vamos a añadir unas líneas más para inspeccionar el "contenedor".

```ruby
#!/usr/bin/env ruby
# Ejemplo: factorial recursivo
def factorial(n)
  return 1 if n <= 1
  n * factorial(n -1)
end
  
puts factorial(3)     #=> 3! = 3*2*1 = 6

# Inspeccionando el "contenedor"
puts self                  #=> main
puts self.class            #=> Object
puts Object.ancestors.to_s #=> [Object, Kernel, BasicObject]
```

* Esto es, el código del factorial se escribió dentro de una instancia `main` que es un `Object`.
* A su vez, y sólo por curiosidad, vemos que la clase `Object` hereda de `Kernel` y éste a su vez de `BasicObject`. Es bastante probable que `BasicObject` sea la raíz o el padre último de todos los objetos de Ruby.

> Bueno, está claro que todo es un objeto y que hay que programar Ruby siguiendo la filosofía de la OOP (Programación Orientada a Objetos).

Los nombres de los métodos pueden tener letras, números, guiones bajos, interrogantes, exclamaciones, emojis, etc.
* Los nombres de los métodos se escriben en `snake_case` y representan una acción, o un sustantivo cuando es un getter/setter.
* Los nombres acabados en `?`, por convención, devuelven `true/false`.
* Los nombres acabados en `!`, por convención, son "destructores", en el sentido que modifican los atributos internos del propio objeto. En caso contrario suelen devolver un valor y el objeto no cambia internamente.
* Cuando los métodos son acciones y no acaban en `?`, ni en `!`, por convención, suelen devolver el propio objeto `self` y por tanto se pueden construir sentencias como: `nombre.upcase.reverse.split`. Pongo el nombre en mayúsculas, lo invierto y lo divido en palabras separadas si es un nombre compuesto.

Ejemplos:

```ruby
name = "Obi-wan Kenobi"
name.class    #=> String

# Los métodos con ! suelen modificar el objeto original
name.upcase   #=> "OBI-WAN KENOBI"
name          #=> "Obi-wan Kenobi"
name.upcase!  #=> "OBI-WAN KENOBI"
name          #=> "OBI-WAN KENOBI"

name.ascii_only? #=> true
nombre.upcase.reverse.split #=> ["IBONEK", "NAW-IBO"]
```

Más ejemplos "frikys":

```ruby
# Ejemplo con emojis

Δ = 1
b = 2

puts Δ
puts b

い = "hola"
puts い 
```
