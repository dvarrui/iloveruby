[<< back](../README.md)

# Numeros

Vamos a hacer un programa que haga lo siguiente:
* Pedir al usuario un número entero N entre 10 y 20.
* Mostrar por pantalla todos los números enteros entre el 1 y el N.
* Mostrar por pantalla todos los números enteros entre el 30 y el N, en orden inverso.

**[Ejemplo 1](./01-numeros.rb)**: Pedir un número entre 10 y 20.

En esta primera versión empezamos leyendo el primer argumento `ARGV[0]`, ese valor lo convertimos a Integer `to_i` y luego nos aseguramos que el valor está entre 10 y 20.

En caso de incumplir este requisito, mostramos unos mensajes por pantalla dando información de cómo se debe usar el script y salimos con un código de error `exit 1`.

Cuando un programa/script termina correctamente se termina con un código de salida 0, y si el código de salida es distinto de cero entonces es que se ha terminado con error.

Ejemplo: Comando que termina correctamente. Código de salida 0.

```bash
$ id david
uid=1000(david) gid=1000(david) grupos=1000(david))

$ echo $?
0
```

Ejemplo: Comando que termina con error. Código de salida 1.

```bash
$ id vader
id: ‘vader’: no existe ese usuario

$ echo $? 
1
```

**[Ejemplo 2](./02-numeros.rb)**: Mostrar por pantalla todos los números enteros entre el 1 y el N.

Hay varias formas de hacer un bucle o iteraciones en Ruby. De momento, vamos a hacerlo usando un `for`, también usaremos como variable auxiliar del bucle o del iterador a la `i`. Esta variable auxiliar tomará valores entre 1 y number `1..number`.

> **NOTA**: Decimos mejor iterador porque esta estructura establece una serie de valores posibles para la variable `i`, y dicha variable irá repitiendo el bloque de instrucciones para cada iteración.

```ruby
# Mostrar por pantalla todos los números enteros entre el 1 y el N.
for i in 1..number
  puts i
end
```

`1..number` es también un objeto Ruby. Es un Range y también tiene sus métodos.

Ejemplo de un Range:

```ruby
a = 1..3 #=> 1..3
a.class  #=> Range
a.count  #=> 3
a.to_a   #=> [1, 2, 3]
```

**[Ejemplo 3](./03-numeros.rb)**: Mostrar por pantalla todos los números enteros entre el 30 y el N, en orden inverso.

Para este otro iterador entre 30 y number, volvemo a usar una estructura `for` similar al ejemplo anterior, usamos la misma variable auxiliar `i`, pero ahora el Range es diferente.

```ruby
for i in (30..number).step(-1)
  puts i
end
```

El objeto Range es `(30..number)` e invocamos a su método `step(-1)` para indicar que los pasos que hay que realizar para avanzar del primer valor 30 al último number, debe ser decreciente, esto es -1 ([Range docs](https://ruby-doc.org/3.4.1/Range.html#method-i-step))

**Encontrar más información**

A base de programar mucho con Ruby he aprendido a usar muchos objetos y sus métodos pero no lo sé todo. Cuando necesito más información puedo usar el intérprete interactivo `irb` y "preguntar", o ir al URL https://ruby-doc.org.

Ejemplo de una sesión de `irb`:

```bash
$ irb
>> a = 1..3
=> 1..3

>> a.class
=> Range

>> a.step
   a.pretty_print                   █Press Alt+d to read the full document   
   a.last                           ▀Range.step                              
   a.hash                                                                    
   a.step                            (from ruby core)                        
   a.cover?                          ----------------------------------------
   a.to_a                              step(n = 1) {|element| ... } -> self  
   a.to_s                              step(n = 1)                  -> enumer
   a.exclude_end?                                                            
   a.eql?                            ----------------------------------------
   a.entries                                                                 
   a.count                           Iterates over the elements of           
   a.include?                        self.                                   
   a.max                                                                     
   a.min                             With a block given and no argument,     
   a.inspect                         calls the block each element of the     
                                     range; returns self:                    
                                                                             
                                       a = []                                
                                       (1..5).step {|element| a.push(element)
                                       a # => [1, 2, 3, 4, 5]                
```
