[<< back](../README.md)

# Hola Mundo

¡Hola Mundo! Lo típico es empezar por el "Hola Mundo!". Así que vamos, pero vamos a hacer un programa que:

- A. Pedir por teclado el nombre, edad y altura en metros, 
- B. Mostrar por pantalla un mensaje como el siguiente: `El personaje NAME, tiene AGE años de edad y mide HEIGHT metros.`

**[Ejemplo 0](./00-holamundo.rb): Escribimos las ideas como comentarios.**

Esto realmente, no es un programa porque no hace nada. Simplemente vamos a crear comentarios con los objetivos que queremos desarrollar para que tener un esquema inicial.

**[Ejemplo 1](./01-holamundo.rb): print() y puts() para mostrar por pantalla.**

> **NOTA**: En la primera línea del fichero tenemos `#!/usr/bin/env ruby`, esta instrucción sirve para poder ejecutar el script como `./01-holamundo.rb` directamente. La shell ya sabe quién es el responsable de interpretar el contenido de este fichero (El programa `ruby`). Si no ponemos esta línea o estamos en un SO no Unix, entonces para ejecutar el script haremos `ruby 01-holamundo.rb`.

En este primer ejemplo vamos a mostrar por pantalla directamente el mensaje:

```
El pesonaje Obiwan, tiene 57 años de edad y mide 1.80 metros.
```

Si nos fijamos en el código, vemos que hemos usado `print` y `puts`. Realmente con una línea lo resolvíamos pero se ha puesto así por motivos didácticos, para ver la diferencia entre `print` (Muestra por pantalla sin retorno de carro) y `puts` (Muestra por pantalla con retorno de carro).


**[Ejemplo 2](./02-holamundo.rb): los paréntesis son opcionales.**

Ahora vamos a usar variables (`name`, `age` y `height`) para poner cada valore por separado. Una nueva observación es que en Ruby los paréntesis de los métodos son opcionales por ese motivo lo podemos omitir si queremos en el método `puts`. Normalmente se suele "omitir" los paréntesis para evitar "ruido" visual pero se aconseja ponerlos cuando son necesarios para definir mejor o aclarar el contenido.

**[Ejemplo 3](./03-holamundo.rb): todo son objetos y/o métodos (que también son objetos) ¡No te asustes! ;-)**

¿Por qué decimos que `puts` es un método y no una función como pasa en otros lenguajes de programación?. Aunque "parece" una función, es el método del objeto donde estamos escribiendo el código.

En el ejemplo estamos mostrando los valores de `self` y `self.class` para que lo veas.

> En Ruby, siempre estamos escribiendo código dentro de algún objeto.

**[Ejemplo 4](./04-holamundo.rb): gets() para leer del teclado.**

Ahora los valores de las variables los introduce el usuario mediante el método `gets`. Este método lee la entrada de teclado (incluyendo el salto de línea), de modo que para obtener el valor del nombre sin el retorno de carro usaremos `gets.chomp`.

Esta forma de escribir es una concatenación de métodos, esto es, `gets` devuelve un String con lo que el usuario ha escrito por el teclado (junto con el retorno de líne "\n"), a luego ese String se le aplìca el método `.chomp` para eliminar "\n".

Ejemplo:

```ruby
film = " star wars \n"
film.chmop #=> " star wars "
```

La variable `age` debe contener un número entero, de modo que al leer la entrada del teclado, que es un String (`gets` devuelve un String)), sobre la marcha lo convertimos en un integer con `gets.to_i`.

La variable `height` debe tener un valor Float, entonces siguiendo la misma lógica lo hacemos con `gets.to_f`.

**[Ejemplo 5](./05-holamundo.rb): Poniendo un poco de color a la vida.**

Para darle color a la salida por pantalla, vamos a usar la gema `pastel` (Librería Ruby). Se ha creado el fichero [Gemfile](./Gemfile) que contiene la gemas a instalar, A continuación con el comando `bundle install` se instala lo especificado en Gemfile. ¡Sencillo! ¿verdad?

> **INFO:** Si quieres ver la información de la gema o encontrar más gemas y consultar su información, entonces hay que ir a [RubyGems](https://rubygems.org/)

Ya tenemos la gema instalada, ahora para usar la librería en nuestro prgorama ponemos `require "pastel"` y para hacer uso de sus métodos, creamos un objeto `pastel = Pastel.new`. A partir de ahora, invocamos los métodos del objeto para colorear los textos. Ejemplo: `pastel.yellow.bold("Obiwan")`. En este ejemplo invocamos el método del objeto pastel para dar color al String que pasamos por parámetro.

Para que el código sea un poco más legible hemos creado nuevas variables coloreadas. Por ejemplo `colored_name` tiene el mismo contenido de `name` pero incluyendo el color.

> **NOTA:** Entiendo que esto puede ser un poco más "complicado" de entender ahora que todavía estamos empezando y todos los nuevos conceptos como librerías, objetos, métodos, etc, nos puede sonar raro. ¡No te preocupes!, esto lo iremos explicando más adelante pero ahora como quería usar la librería para añador color no me ha quedado más remedio que mencionarlo.

Cuando ponemos el nombre, puede ser que los escribamos `Obiwan` o nos equivoquemos y pongamos `obiwan` por ir un poco rápido. Esto lo podemos mejorar usando el método `capitalize()` del String. Ejemplo: ` "obiwan".capitalize => "Obiwan".

**[Ejemplo 6](./06-holamundo.rb): Mejorando el interfaz de entrada.**

Es este ejemplo vamos a usar otra gema (`tty-prompt`). Ya está instalada con el proceso del ejemplo anterior (`bundle install`). Ahora para usarla dentro de nuestro programa ponemos `require "tty-prompt"`.

Se crea un objeto `prompt = TTY::Prompt.new`. Ahora usando el método `ask(MESSAGE, default: VALUE)` del objeto mostramos MESSAGE por pantalla y si pulsamos enter la variable de carga por defecto con el valor VALUE. Esto mejora notablemente la usabilidad del programa.

**[Ejemplo 7](./07-holamundo.rb): Paso de argumentos de entrada. Es lo habitual en comandos y scripts.**

En esta versión del programa vamos a usar otra forma de introducir los datos al programa (script). Vamos a usar el paso de argumentos. En este caso el programa se invoca en el terminal de la siguiente forma: `./07-holamundo.rb NAME AGE HEIGHT`

Ejemplo de uso:

```bash
$ ./07-holamundo.rb obiwan 57 1.80
El personaje Obiwan, tiene 57 años de edad y mide 1.8 metros.```
```

Para leer los argumentos existe el objeto `ARGV`. Realmente es un Array (o lista)

> **NOTA:** En Ruby a las listas se les llama Array. Los Array de Ruby no tienen tamaño fijo.
>
> Esto puede confundir, dependiendo del lenguaje de programación que vengas, ya que en otros lenguajes de programación a este tipo de objetos se les llama List, y se usa Array cuando son listas de tamaño fijo en memoria.
>
> IMHO: El nombre List hubiera sido un poco más "adecuado".

**[Ejemplo 8](./08-holamundo.rb): Cambiamos la lógica para separ metros de centímetros.**

Vamos modificar el mensaje de salida del siguiente modo:

```
El usuario NAME, de AGE años de edad y mide MTS metros y CMS centímetros.”
```

El usuario introduce su altura en la forma `1.80` (variable `height`), y nosotros tenemos que separar la parte entera de la parte decimal de la siguiente forma:

```ruby
# Nos quedamos con la parte entera de la altura
mts = height.to_i 

# Nos quedamos con la parte decimal, luego ese valor lo multiplicamos por 100
# y redondeamos sin dejar decimales en el resultado final.
cms = ((height % mts) * 100).round(0) 
```

---

_Hasta aquí hemos terminado de "evolucionar" el "hola mundo" ahora puedes seguir con el [siguiente problema](../02.numeros/README.md)._
