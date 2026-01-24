
# Hash#fetch

> (Kirill Shevchenko @kirill_shevch) https://twitter.com/kirill_shevch/status/1591729555748048896?t=VfvL0z5NyiWlMGSxFgHw2A&s=35

Usar `Hash#fetch` en lugar de [] puede ser útil cuando se necesita devolver un parámetro predeterminado si la clave no existe.

![](https://pbs.twimg.com/media/Fhb1GukWIAATPLs?format=jpg&name=small)

> (David Paluy @dpaluy)

Uno de mis usos favoritos con ENV.

![](https://pbs.twimg.com/media/FhdFTgCWYAEpWfH?format=jpg&name=small)


# Hash#new

> (Kirill Shevchenko @kirill_shevch) https://twitter.com/kirill_shevch/status/1591200542134800390?t=tb5yvjDGxzrs3itvIQwM8A&s=35

* Un hash generalmente se crea usando las llaves, lo que se comporta igual que `Hash#new`.
* Sin embargo, con la segunda opción, se puede asignar un valor predeterminado para las claves Hash que no existan. Por ejemplo:

![](https://pbs.twimg.com/media/FhUSFi9XwAAzr4x?format=jpg&name=small)


También se proporcionar un bloque que genere el valor predeterminado. Esto es especialmente útil cuando el valor predeterminado es mutable y necesita su propia identidad.

```ruby
a = Hash.new([])

a[1] # => []
```

vs

```ruby
h = Hash.new { |h, k| h[k] = [] }

h[1] << 1
h[2] << 2
```

Creación de hash dinámico infinito:

```ruby
Hash.new do |hash, key|
   hash[key] = Hash.new(&hash.default_proc)
end
```

```ruby
c = Hash.new do |hash, key|
    hash[key] = Hash.new(&hash.default_proc)
end

c       # => {}
c[1]    # => {}
c       # => {1=>{}}
c[1][2] # => {}
c       # => {1=>{2=>{}}}
```
