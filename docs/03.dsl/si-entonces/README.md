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
number = 10

si { number >= 18 }
  entonces { puts "Adulto" }
  sino { puts "Menor" }

# Estructura si-entonces-sino con ;
number = 52

si { number >= 18 }
entonces {
  puts "Adulto"
}; sino {
  puts "Menor"
}
```

**Consultar la biblioteca** [si-entonces-sino-v1](./v1/lib/si-entonces-sino-v1.rb).

Reflexiones:

* Es un poco "feo" que la condición se tenga que delimitar con llaves en lugar de paréntesis.
* Además la implementación se basa en almacenar el estado en variables globales, lo cual no es muy limpio y además no va a funcionar correctamente si se plantean condicionales dentro de otros, porque se alterarían los valores temporales de estas variables.

## Versión 3: Usando clases y binding para mover el contexto

Ejemplo usando una clase `SpanishConditional` envuelta en un método `si()`.

**Modo de uso** del DSL `si-entonces-sino-v2`:

```ruby
edad = 10
puts "\nEdad: #{edad}"

si('edad >= 18', binding)
  .entonces { puts "Adulto" }
  .sino { puts "Menor" }
```

**Consultar la biblioteca** [si-entonces-sino-v2](./v2/lib/si-entonces-sino-v2.rb).

Reflexiones:

* Es un poco "sucio" pasar la condición como `String` y tener que pasar por parámetros el contexto (`binding`).
* Como el estado se almacena en una instancia sería posible anidar condicionales dentro de otro sin conflictos entre sus estados.