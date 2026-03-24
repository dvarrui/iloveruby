[<< back](../README.md)

```
iLoveRuby -> DSL
```

# DSL si-entonces

Este va a ser un "experimento" diferente. Vamos a crear el DSL de forma iterativa para irnos moviendo poco a poco desde le lenguaje clásico de Ruby hacia una forma más alejada. Y todo ello, buscando "simular" la estructura condicional `si COND entonces ACCION1 sino ACCION2`.

## Versión 1: Usando métodos y variables globales

Ejemplos usando métodos y almacenando el estado temporalmente en variables globales:

**Modo de uso** del DSL `si-entonces-sino-v1`:

```ruby
# Estructura si-entonces-sino sin ;
edad = 10
nombre = "Pitufo"

si (edad >= 18 )
  entonces { puts "#{nombre} es adulto" }
  sino { puts "#{nombre} es menor" }

# Estructura si-entonces-sino con ;
edad = 52
nombre = "Obiwan"

si (edad >= 18)
entonces {
  puts "#{nombre} es adulto"
}; sino {
  puts "#{nombre} es menor"
}
```

**Consultar la biblioteca** [si-entonces-sino-v1](./v1/lib/si-entonces-sino-v1.rb).

Reflexiones:

* La implementación se basa en almacenar el estado en variables globales, lo cual no es muy limpio y además no va a funcionar correctamente si se plantean condicionales dentro de otras, porque se alterarían los valores temporales de estas variables.

## Versión 2: Usando clases para encapsular

Ejemplo usando una clase `SpanishConditional` envuelta en un método `si()`.

**Modo de uso** del DSL `si-entonces-sino-v2`:

```ruby
edad = 10
puts "\nEdad: #{edad}"

si(edad >= 18)
  .entonces { puts "Adulto" }
  .sino { puts "Menor" }
```

**Consultar la biblioteca** [si-entonces-sino-v2](./v2/lib/si-entonces-sino-v2.rb).

Reflexiones:

* Esta forma es un poco "sucia", porque si nos fijamos bien podemos notar que estamos usando OOP. Pero a mí no me disgusta.
* Como el estado se almacena dentro de una instancia, si es posible anidar condicionales dentro de otro sin conflictos entre sus estados.