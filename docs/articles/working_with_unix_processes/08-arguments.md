[<< back](README.md)

# Los procesos tienen argumentos

Cada proceso tiene acceso a un lista especial llamada `ARGV`. Otros lenguajes de programación pueden implementarlo de forma ligeramente diferente, pero cada uno tiene algo llamado 'argv'.

argv es una forma abreviada de 'vector de argumentos'. En otras palabras: un vector, o matriz, de argumentos. Contiene los argumentos que se pasaron al proceso actual en la línea de comandos. Aquí hay un ejemplo de cómo inspeccionar `ARGV` y pasar algunas opciones simples.

```bash
$ cat argv.rb
p ARGV
$ ruby argv.rb foo bar -va
["foo", "bar", "-va"]
```

## ¡Es una lista!

A diferencia del capítulo anterior, donde aprendimos que `ENV` no es un `Hash`, `ARGV` es simplemente un `Array`. Puede agregarle elementos, quitarle elementos, cambiar los elementos que contiene, lo que quiera. Pero si simplemente representa los argumentos pasados en la línea de comando, ¿por qué necesitaría cambiar algo?

Algunas bibliotecas leerán desde `ARGV` para analizar las opciones de la línea de comandos, por ejemplo. Puede cambiar `ARGV` mediante programación antes de que tengan la oportunidad de verlo para modificar las opciones en tiempo de ejecución.

## En el mundo real

Probablemente el caso de uso más común para `ARGV` es aceptar nombres de archivos en un programa. Es muy común escribir un programa que toma uno o más nombres de archivo como entrada en la línea de comandos y hace algo útil con ellos.

El otro caso de uso común, como se mencionó, es para analizar la entrada de la línea de comandos. Hay muchas bibliotecas de Ruby para manejar la entrada de la línea de comandos. Uno llamado `optparse` está disponible como parte de la biblioteca estándar.

Pero ahora que sabe cómo funciona `ARGV`, puede omitir esa sobrecarga adicional para obtener opciones de línea de comandos simples y hacerlo a mano. Si solo desea admitir algunas banderas, puede implementarlas directamente como operaciones de matriz.

```ruby
# did the user request help?
ARGV.include?('--help')
# get the value of the -c option
ARGV.include?('-c') && ARGV[ARGV.index('-c') + 1]
```

[<< back](README.md)
