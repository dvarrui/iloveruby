[<< back](../README.md)

# Hola Mundo

Vamos a hacer un programa que pida por teclado el nombre, edad y altura en metros.

Después mostraremos por pantalla un mensaje del tipo:
```
El personaje NAME, tiene AGE años de edad y mide HEIGHT metros.
```

* [Ejemplo 1](./01-holamundo.rb): Empezamos poniendo los valores en tres variables. En Ruby los paréntesis de los métodos son opcionales por ese motivo no lo ponemos en el método `puts`.
* [Ejemplo 2](./02-holamundo.rb): Ahora los valores los introduce el usuario mediante el método `gets`. Este método lee la entrada de teclado pero también incluye el salto de línea, de modo que para poner el valor del nombre sin el retorno de carro usamod `gets.chomp`. Las otras dos variables deben ser números, de modo que al leer la entrada del teclado (que es un String), sobre la marcha lo convertimos en un integer con `gets.to_i`.

# Modificación

¿Eres capaz de modificarlo para que el mensaje sea de la siguiente manera? Solo
pidiendo los tres valores indicados.
“El usuario NOMBRE, de EDAD años de edad y mide METROS metros y CENTÍMETROS
centímetros.”.
Ejemplos:
“El usuario Juan tiene 44 años de edad y mide 1.85 metros”.
“El usuario Juan tiene 44 años de edad y mide 1 metro y 85 centímetros”.