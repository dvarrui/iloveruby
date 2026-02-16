[<< back](../README.md)

# Conversiones

Vamos a hacer un programa para:
* Convertir un número decimal a uno binario.
* Convertir uno binario en decimal.
* y convertir del octal y a hexadecimal.

**[Ejemplo 1](./01-convertir.rb): Convertir un número decimal a binario.**

Con los métodos que tiene la clase Integer, la conversión es directa:
```
>> a = 6
=> 6

>> a.to_s(2)
=> "110"
```

Hemos incluido una poco de funcionalidad extra para:
* Pasar la información por argumentos.
* Hacer comprobaciones para asegurarnos que se usa correctamente el script.

**[Ejemplo 2](./02-convertir.rb): Convertir un número binario a decimal.**

Convertir un texto que representa un número binario a decimal, también es muy sencillo. Ejemplo:

```ruby
>> a = "110"
=> "110"

>> a.to_i(2)
=> 6 
```

Al final, hay una sección "conversión" que consta de `if...elsif..end` para ayudar a decidir la conversión adecuada según el valor de `action`.

**[Ejemplo 2](./02-convertir.rb): Convertir un número octal y a hexadecimal.**

Esta conversión es así `value.to_i(8).to_s(16)`. Explicación:
* En la primera parte se convierte el texto de entrada `value` octal a un valor numérico decimal `value.to_i(8)`
* Y en la segunda parte, el valor numérico decimal se convierte a un texto que representa el número hexadecimal `.to_s(16)`.

---

_Hasta aquí hemos terminado de "evolucionar" la "geometría", ahora puedes seguir con el siguiente problema._