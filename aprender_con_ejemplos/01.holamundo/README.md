[<< back](../README.md)

# Hola Mundo

Vamos a hacer un programa que pida por teclado el nombre, edad y altura en metros.

Después mostraremos por pantalla un mensaje del tipo:
```
El personaje NAME, tiene AGE años de edad y mide HEIGHT metros.
```

**[Ejemplo 1](./01-holamundo.rb)**

 Empezamos poniendo los valores directamente en las variables. Esto no es lo que se pedía pero es sólo para empezar. En Ruby los paréntesis de los métodos son opcionales por ese motivo lo ponemos omitir en el método `puts`.

**[Ejemplo 2](./02-holamundo.rb)**

¿Por qué decimos que `puts` es un método y no una función como pasa en otros lenguajes de programación?. Aunque "parece" una función, es el método del objeto donde estamos escribiendo el código.

En el ejemplo estamos mostrando los valores de `self` y `self.class` para que lo veas.

> En Ruby, siempre estamos escribiendo código dentro de algún objeto.

**[Ejemplo 3](./03-holamundo.rb)**

Ahora los valores de las variables los introduce el usuario mediante el método `gets`. Este método lee la entrada de teclado (incluyendo el salto de línea), de modo que para obtener el valor del nombre sin el retorno de carro usaremos `gets.chomp`.

Esta forma de escribir es una concatenación de métodos, esto es, `gets` devuelve un String con lo que el usuario ha escrito por el teclado (junto con el retorno de líne "\n"), a luego ese String se le aplìca el método `.chomp` para eliminar "\n".

Ejemplo:

```ruby
film = " star wars \n"
film.chmop #=> " star wars "
```

Las otras dos variables deben ser números, de modo que al leer la entrada del teclado (que es un String), sobre la marcha lo convertimos en un integer con `gets.to_i`.

# Modificación

¿Eres capaz de modificarlo para que el mensaje sea de la siguiente manera? Solo
pidiendo los tres valores indicados.
“El usuario NOMBRE, de EDAD años de edad y mide METROS metros y CENTÍMETROS
centímetros.”.
Ejemplos:
“El usuario Juan tiene 44 años de edad y mide 1.85 metros”.
“El usuario Juan tiene 44 años de edad y mide 1 metro y 85 centímetros”.