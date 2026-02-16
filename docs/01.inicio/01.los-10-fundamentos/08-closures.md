[<< back](./README.md)

# 8. Bloques de código (Closures)

En Ruby, casi todo es un objeto, y por ejemplo los bloques de código o Closures, también lo son. 

# 8.1 Delimitadores

Los bloques de código o closures se escriben dentro de sus delimitadores. Tenemo dos estilos de delimitadores que se usan de la siguiente forma:
* `{ ... }` para bloques de código de una línea.
* `do ... end` para bloques de código de varias líneas.

Los closures se usan mucho mucho mucho, y sobre todo en conjunción con los métodos iteradores de modo que se puede implementar el [patrón estrategia](https://refactoring.guru/es/design-patterns/strategy) de una forma muy natural.

Ejemplos:

```ruby
# Closure de una línea
3.times { puts "I love Ruby" }

# Salida: Muestra 3 veces por pantalla el mensaje "I love Ruby"
```

Explicación:

- El objeto `3`, tiene un método `times` que acepta como argumento un bloque de código
- El bloque de código pasado como argumento ejecuta `puts 'I love Ruby'` 

# 8.2 Los parámetros

Los closures aceptan parámetros. Estos se ponen como `|paramname|`. Por ejemplo:

Otro ejemplo:
```ruby
# Combinando el bloque con el iterador each() del Array
names = ["obiwan", "yoda", "luke"]

# Closure multilínea y con el parámetro "name"
names.each do |name|
   puts "---"
   puts "#{name.capitalize} dice:"
   puts "  ¡Que la fuerza te acompañe!"
end

# Salida:
#
# ---
# Obiwan dice: 
#   ¡Que la fuerza te acompañe!
# ---
# Yoda dice:
#   ¡Que la fuerza te acompañe!
# ---
# Luke dice:
#   ¡Que la fuerza te acompañe!
```

Explicación:
* El objeto Array `names`, tiene un método `each`
* El método `each` acepta un bloque como argumento y lo ejecuta en cada uno de los elementos de Array.
* El método `each` es un iterador

---
[next >>](./09-metapro.md)