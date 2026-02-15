[<< back](./README.md)

# 8. Bloques de código (Closures)

En Ruby, casi todo es un objeto, y por ejemplo los bloques de código o Closures, también lo son. Hay varias formas de escribir estos objetos de código o bloques de código. A veces nos puede interesar utilizar un estilo u otro dependiendo del caso, por lo que nos la podemos encontrar escrita de diferentes formas. Vamos al caso más común.

Lo más común es usar los delimitadores `{ ... }` o `do ... end` para definir los bloques de código. Se puede usar cuaquiera de las dos, pero los RubyLovers siguen el siguiente patrón:
* `{ ... }` para bloques de código de una línea.
* `do ... end` para bloques de código de varias líneas.

Los bloques se usan mucho mucho mucho, y sobre todo en conjunción con los métodos iteradores de modo que se puede implementar el [patrón estrategia](https://refactoring.guru/es/design-patterns/strategy) de una forma muy natural al lenguaje.

Ejemplos:

```ruby
3.times { puts "I love Ruby" }

# Salida: Muestra 3 veces por pantalla el mensaje "I love Ruby"
```

Explicación:

- El objeto `3`, tiene un método `times(block)` que acepta como argumento un bloque de código
- El bloque de código pasado como argumento ejecuta `puts 'I love Ruby'` 

Internamente el pseudocódigo del método podría ser algo como lo siguiente:

```ruby
# Esto no es Ruby, es psedocódigo
def times(block)
  max = self # max=3
  i = 0
  while(i<max)
    block.call()
    i += 1
  end
end
```

Otro ejemplo:
```ruby
# Combinando el bloque con el iterador each() del Array
names = ["obiwan", "yoda", "luke"]

names.each do |name|
   puts "---"
   puts "#{name.capitalize} dice: ¡Que la fuerza te acompañe!"
end

# Salida:
#
# ---
# Obiwan dice: ¡Que la fuerza te acompañe!
# ---
# Yoda dice: ¡Que la fuerza te acompañe!
# ---
# Luke dice: ¡Que la fuerza te acompañe!
```

Explicación:
* El objeto Array `names`, tiene un método `each()`
* El método `each(block)` acepta un bloque como argumento y lo ejecuta en cada uno de los elementos de Array.
* El método `each()` es un iterador
