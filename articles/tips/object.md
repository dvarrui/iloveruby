
# Diferencia entre `equal?` y `==`

> (Kirill Shevchenko
@kirill_shevch) https://twitter.com/kirill_shevch/status/1592652547420213248?t=5YIvGDyFHTVkRpUiLqgePw&s=35

Los dos se usan para comparar datos, pero:

1. `==` devuelve verdadero si ambos objetos contienen el mismo valor.
2. `equal?` comprueba si las referencias apuntan al mismo objeto de la memoria (ambos valores son el mismo objeto).

**Ejemplo**

```ruby
message1 = `Hello there!`
message2 = `Hello there!`
message3 = message1

message1 === message2
# => true

message1.equal? message2
# => false

message1.equal? message3
# => true

message1.object_id # => 16000
message2.object_id # => 16020
message3.object_id # => 16000
```
