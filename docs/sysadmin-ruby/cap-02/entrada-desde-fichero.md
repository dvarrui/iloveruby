[<< back](README.md)

# Entrada desde fichero (offline)

Como dijimos los Array y los String nos van a ser muy útiles para nuestros scripts. En el ejemplo [greet6.rb](example/greet6.rb) pudimos usar los argumentos para hacer una entrada "masiva" de datos al script. ¡Bueno, no tan "masiva"! Si tuviéramos que saludar a cientos de personas... ¡uf!

## Leer fichero usando la clase File

Otro enfoque será el siguiente. Vamos a escribir todos los nombres de todas las personas a las que queremos saludar en un fichero de texto. Luego el script que lea el archivo, identifique los nombres y los salude todos. Vamos allá.

Contenido de `characters.txt`
```
Obi-wan Kenobi
Qui-gon Jinn
Yoda
```

Veamos la ejecución del script [greet7.rb](example/greet7.rb):
```
> ./greet7.rb               
Usage: ./greet7.rb FILENAME
       FILENAME must contain a list of names.

> ./greet7.rb characters.txt               
Hello Obi-wan Kenobi!
Hello Qui-gon Jinn!
Hello Yoda!
```

Comprobamos que el nuevo script hace un saludo a cada uno de los personajes dentro del fichero `characters.txt`. La parte nueva del script es :

```ruby
filename = ARGV.first
names = File.read(filename).split("\n")

for name in names do
  puts "Hello #{name}!"
end
```

Explicación:
* Empezamos con `File.read(filename)`. Como la variable `filename` es el contenido del argumento que se pasa al script. Esto es `characters.txt`. Entonces `File.read` lee el contenido completo del fichero y lo guarda.
* Pero... este contenido es una cadena de texto y nosotros queremos un Array. Entonces aplicamos `.split("\n")` para forzar una división del String por cada retorno de carro o fin de línea.
* `names` al final contiene un Array con todos los nombres (filas) del fichero `characters.txt`.

Veamos esto mismo dentro de irb:
```
irb> a = File.read('characters.txt')
=> "Obi-wan Kenobi\nQui-gon Jinn\nYoda\n"

irb> a.class
=> String

irb> a.size
=> 33

irb> b = a.split("\n")
=> ["Obi-wan Kenobi", "Qui-gon Jinn", "Yoda"]

irb> b.class
=> Array

irb> b.size
=> 3
```

## Leer fichero usando los comandos del sistema

Vamos a leer el fichero de datos de entrada de otra forma. Esta vez, usando la salida de los propios comandos del sistema. Además usaremos el fichero de entrada `characters2.txt`:

```
#Obi-wan Kenobi
Qui-gon Jinn
#Yoda
#Palpatine
Darth Maul
```

Porque queremos además que el nuevo script [greet8.rb](example/greet8.rb) salude a los personajes del fichero, pero que excluya las líneas que están comentadas.

Explicamos la línea que hemos cambiado:
```ruby
names = %x[cat #{filename} | grep -v '#'].split("\n")
```

* El contenido dentro de `%x[...]` es un comando del sistema que se cuando se ejecuta no se muestra la información en pantalla sino que se guarda dentro del script.
* El comando `cat characters2.txt` muestra el contenido del fichero y `grep -v "#"` filtra ese contenido impidiendo el paso de las líneas que contengan la cadena `#`.
* Al contenido de la ejecución anterior se le pasa `.split("\n")` para separar las filas y tener un Array de elementos que se guardan en la variable `names`.

Veamos esto,paso por paso en irb:

```
irb> a = %x[cat characters2.txt | grep -v "#"]
=> "Qui-gon Jinn\nDarth Maul\n"

irb> a.class
=> String

irb> b = a.split("\n")
=> ["Qui-gon Jinn", "Darth Maul"]

irb> b.class
=> Array
```

Vemos que tenemos varios caminos para leer el contenido de un fichero. Entiendo que cada uno debe elegir la forma que más le guste.

## Leer un fichero con varios campos

Estamos complicando el formato del fichero de entrada. Esta vez tenemos `characters3.txt` de esta forma:
```
Obi-wan Kenobi:hi
#Qui-gon Jinn:hi
#Yoda:hi
#Palpatine:bye
Darth Maul:bye
```

Donde:
1. Las líneas que comienzapor `#` se van a ignorar.
2. Cada línea debe dividirse (`split(":")`) usando como separador el caracter ":", de modo que el campo 0 es el nombre y el campo 1 nos indica cómo saludar al personaje.
3. Si el saludo es de tipo "hi" decimos "Hello", y si es de tipo "bye" nos despedimos.

Veamos el resultado de ejecutar el script [greet9.rb](example/greet9.rb):

```
> ./greet9.rb characters3.txt
Hello Obi-wan Kenobi!
Bye-bye Darth Maul!

> ./greet9.rb                
Usage: ./greet9.rb FILENAME
       FILENAME must contain a list like this:
         Nane1:hi => Say hello to Name1
         Name2:bye => Say Bye-bye to Name2
         #Name3:hi  => Ignore Name3
```

Explicamos los cambios:

```ruby
lines = %x[cat #{filename} | grep -v '#'].split("\n")

for line in lines do
  items = line.split(":")
  puts "Hello #{items[0]}!" if items[1] == 'hi'
  puts "Bye-bye #{items[0]}!" if items[1] == 'bye'
end
```

* Cada línea del fichero (`lines`) es una Array que en cada iteración se vuelve a dividir (`items = line.split(":")`) en cada uno de los dos items que esperamos recibir.
* `items[0]` será el primer campo (El nombre).
* `items[1]` será el segundo campo (El modo de saludo)

---

Hasta ahora no hemos resuelto ningún problema interesante para un administrador de sistemas. Sólo hemos saludado de muchas maneras diferentes. En los próximos capítulos vamos a aplicar lo que hemos aprendido para empezar a resolver problemas más reales.

> Recordar que no estamos aprendiendo a programar en Ruby, sino que estamos haciendo scripts en Ruby y estamos aprendiendo lo necesario para resolver nuestros scripts orientándolos al uso de comandos del sistema para sysadmin.

[<< back](../README.md)
