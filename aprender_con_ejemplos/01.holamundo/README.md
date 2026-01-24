[<< back](../README.md)

# Hola Mundo

¡Hola Mundo! Lo típico es empezar por el "Hola Mundo!". Así que vamos, pero vamos a hacer un programa que pida por teclado el nombre, edad y altura en metros, y después mostraremos por pantalla un mensaje como el siguiente:

```
El personaje NAME, tiene AGE años de edad y mide HEIGHT metros.
```

**[Ejemplo 1](./01-holamundo.rb)**: print y puts.

En este primer ejemplo vamos a mostrar por pantalla directamente el mensaje:

```
El pesonaje Obiwan, tiene 57 años de edad y mide 1.80 metros.
```

Si nos fijamos en el código, vemos que hemos usado `print` y `puts`. Realmente con una línea lo resolvíamos pero se ha puesto así por motivos didácticos, para ver la diferencia entre `print` (Muestra por pantalla sin retorno de carro) y `puts` (Muestra por pantalla con retorno de carro).

**[Ejemplo 2](./02-holamundo.rb)**: los paréntesis son opcionales

Ahora vamos a usar variables (`name`, `age` y `height`) para poner cada valore por separado. Una nueva observación es que en Ruby los paréntesis de los métodos son opcionales por ese motivo lo podemos omitir si queremos en el método `puts`. Normalmente se suele "omitir" los paréntesis para evitar "ruido" visual pero se aconseja ponerlos cuando son necesarios para definir mejor o aclarar el contenido.

**[Ejemplo 3](./03-holamundo.rb)**: todo son objetos y/o métodos (que también son objetos) ¡No te asustes! ;-)

¿Por qué decimos que `puts` es un método y no una función como pasa en otros lenguajes de programación?. Aunque "parece" una función, es el método del objeto donde estamos escribiendo el código.

En el ejemplo estamos mostrando los valores de `self` y `self.class` para que lo veas.

> En Ruby, siempre estamos escribiendo código dentro de algún objeto.

**[Ejemplo 4](./04-holamundo.rb)**: gets

Ahora los valores de las variables los introduce el usuario mediante el método `gets`. Este método lee la entrada de teclado (incluyendo el salto de línea), de modo que para obtener el valor del nombre sin el retorno de carro usaremos `gets.chomp`.

Esta forma de escribir es una concatenación de métodos, esto es, `gets` devuelve un String con lo que el usuario ha escrito por el teclado (junto con el retorno de líne "\n"), a luego ese String se le aplìca el método `.chomp` para eliminar "\n".

Ejemplo:

```ruby
film = " star wars \n"
film.chmop #=> " star wars "
```

La variable `age` debe contener un número entero, de modo que al leer la entrada del teclado, que es un String (`gets` devuelve un String)), sobre la marcha lo convertimos en un integer con `gets.to_i`.

La variable `height` debe tener un valor Float, entonces siguiendo la misma lógica lo hacemos con `gets.to_f`.

**[Ejemplo 5](./05-holamundo.rb)**: Poniendo un poco de color a la vida.

Vamos a usar la gema `pastel` (Librería Ruby) para darle color al texto de salida por pantalla. Se ha creado el fichero [Gemfile](./Gemfile) que contiene la gemas a instalar, demo que con el comando `bundle install` se instala lo especificado en Gemfile. ¡Sencillo! ¿verdad?

> **INFO:** Si quieres ver la información de la gema o encontrar más gemas y consultar su información, entonces hay que ir a [RubyGems](https://rubygems.org/)

Ya tenemos la gema instalada, ahora para usar la librería en nuestro prgorama ponemos `require "pastel"` y para hacer uso de sus métodos, creamos un objeto `pastel = Pastel.new`. A partir de ahora, invocamos los métodos del objeto para colorear los textos. Ejemplo: `pastel.yellow.bold("Obiwan")`. En este ejemplo invocamos el método del objeto pastel para dar color al String que pasamos por parámetro.

> **NOTA:** Entiendo que esto puede ser un poco más "complicado" de entender ahora que todavía estamos empezando y todos los nuevos conceptos como librerías, objetos, métodos, etc, nos puede sonar raro. ¡No te preocupes!, esto lo iremos explicando más adelante pero ahora como quería usar la librería para añador color no me ha quedado más remedio que mencionarlo.

**[Ejemplo 6](./06-holamundo.rb)**: Mejorando el interfaz.

Es este ejemplo vamos a usar otra gema (`tty-prompt`)
---
# Modificación

¿Eres capaz de modificarlo para que el mensaje sea de la siguiente manera? Solo
pidiendo los tres valores indicados.
“El usuario NOMBRE, de EDAD años de edad y mide METROS metros y CENTÍMETROS
centímetros.”.
Ejemplos:
“El usuario Juan tiene 44 años de edad y mide 1.85 metros”.
“El usuario Juan tiene 44 años de edad y mide 1 metro y 85 centímetros”.