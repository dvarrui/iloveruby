[<< back](README.md)

# Array

Nuestro ejemplo de creación/eliminación masiva de usuarios, usa tres ficheros:
* [userctl5.rb](example/userctl5.rb): script principal.
* [lib-userctl5.rb](example/lib-userctl5.rb): librería con funciones.
* [list-users.txt](example/list-users.txt): entrada de datos.

A la hora de leer el fichero de entrada para poder procesarlo, hicimos lo siguiente:

```ruby
# Read input file => Array with file content
lines = File.read(filename).split("\n")
# Remove first line
lines.delete_at(0)
```

Esto es, leímos el contenido del fichero "filename" y creamos un Array(lista) con todas las líneas (`split("\n")`). Luego eliminamos la línea 0 (`lines.delete_at(0)`)... Bueno, esto lo hicimos porque la primera línea del fichero de entrada no contenía datos en sí. Era una con información acerca del nombre de los campos que debían estar en el fichero. Veamos:

```
# Action:Username:Password:HomeFolder:Shell
create:obiwan:123456:/home/obiwan:/bin/bash
create:luke:::
delete:vader:::
```

Funcionó con ese fichero, ¿pero y si la línea con `#` hubiera sido otra?

# Filtrando la entrada de datos

Vamos a mejorar el filtrado de datos de entrada, aprovechando las posibilidades que nos ofrece la clase Array ([Consultar documentación](https://ruby-doc.org/core-2.7.0/Array.html)).

Array contiene un método `select` que hace un filtrado de los elementos que cumplen el criterio establecido por su argumento de entrada. Esto es, un bloque de código.

```ruby
def read_input_data(filename)
  data = []
  # Read input file => Array with file content
  inputs = File.read(filename).split("\n")

  # Remove lines that start with # character
  lines = inputs.select { |i| !i.start_with?("#") }

  ...
end
```

Aquí tienes la nueva versión [userctl6.rb](example/userctl6.rb). Pero si queremos... podemos "reducirlo" un poco más:

```ruby
def read_input_data(filename)
  data = []
  # Read input file => Array with file content
  # Removing lines that start with # character
  lines = File.read(filename).split("\n").select { |i| !i.start_with?("#") }

  ...
end
```

> Un aspecto muy interesante de la elección de los nombres de los métodos en Ruby, es que parece que estás escribiendo en inglés cuando estamos encadenando métodos de objetos.

Puede ser que no te guste esta forma, y quizás prefieras la anterior... Lo importante es saber que tenemos distintas formas de hacer lo mismo, y luego cada uno que ponga en su código aquella que la parezca... más adecuada.
