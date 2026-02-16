[<< back](README.md)

# Hello Ruby!!!

> Enlace de interés:
> * https://markm208.github.io/rubybook/chapter1/01/index.html
> * Example: [files/01.rb](files/01.rb)

En este programa, mostraré algunos de los conceptos básicos de Ruby, incluido cómo ejecutar un programa e imprimirlo en la pantalla.

Ruby es un verdadero lenguaje orientado a objetos. Todo lo que manipulas es un objeto y todo lo que produce tu código también es un objeto. Números, cadenas e incluso nil (el equivalente de un puntero nulo) es un objeto. Uno puede llamar a métodos en estos objetos y pasarlos a métodos.

Ruby es un lenguaje interpretado, no compilado. Esto significa que el código fuente que compone nuestros programas se traduce en instrucciones de máquina mientras se ejecuta el programa. Esto también significa que los errores de sintaxis no se identificarán antes de ejecutar el programa.

Ruby se ejecuta en todas las plataformas principales. La [página de descarga de Ruby está aquí](https://www.ruby-lang.org/en/downloads/). Es una instalación bastante sencilla, así que no la describiré aquí.

¡Empecemos!

## Paso 1/5

A diferencia de otros lenguajes de programación, los programas de Ruby no tienen una función principal. El flujo de control comienza en la parte superior de un archivo específico y continúa hacia abajo. Cuando no hay más declaraciones para ejecutar, entonces el programa está completo.

Para ejecutar un programa desde la línea de comando, use este comando:
```bash
ruby <nombre_archivo>.rb
```

Asegúrese de haber instalado Ruby y de estar en el directorio que contiene el archivo `.rb`.

En la captura de pantalla adjunta, puede ver que emití este comando:

```ruby
ruby 01.rb
```

porque el archivo con el que estoy trabajando se llama `01.rb`.

# Paso 2/5

```ruby
puts ("This is Ruby!")
```

`puts` es un método que significa 'poner cadena'. En otras palabras, escriba en la salida estándar y luego finalice la línea.

![](https://markm208.github.io/rubybook/chapter1/01/media/images/1662643080034-01.png)

# Paso 3/5

```ruby
puts ("This is Ruby!")
puts "Hello World!!!"
```

Los paréntesis son en su mayoría opcionales en las llamadas a métodos de Ruby.

En la línea 2 vuelvo a llamar `puts` pero esta vez sin paréntesis. La captura de pantalla adjunta muestra que no hubo ningún error y que el código se ejecutó como se esperaba.

![](https://markm208.github.io/rubybook/chapter1/01/media/images/1662643154168-02.png)

# Paso 4/5

```ruby
puts ("This is Ruby!")
puts "Hello World!!!"
print "Mark "
print "Robert "
print "Mahoney "
puts
```

El método `print` es similar a `puts` pero no agrega una nueva línea como lo hace `puts`.

En las líneas 3-5 imprimo mi nombre con tres llamadas separadas para imprimir.

En la línea 6 imprimo una línea en blanco. Si no pasa una cadena a `puts`, simplemente imprime una nueva línea.

![](https://markm208.github.io/rubybook/chapter1/01/media/images/1662643316665-03.png)

# Paso 5/5

```ruby
puts ("This is Ruby!")
puts "Hello World!!!"
print "Mark "
print "Robert "
print "Mahoney "
puts

#oh yeah, a '#' starts a single line comment
#oh, oh, and there are no semicolons ;)
```

Ruby tiene comentarios de una sola línea con un `#`. Además, Ruby no requiere punto y coma para terminar las declaraciones, ¡hurra!
