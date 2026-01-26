[<< back](../README.md)

#  Máximos y mínimos, pares e impares

Vamos a hacer un programa que pida tres números al usuario, y sin usar Array (listas), muestrar por pantalla:
* El mínimo (indicar si es par o impar)
* El máximo (indicar si es par o impar)

**[Ejemplo 1](./01-maxmin.rb): Ordenamos los 3 números.**

Leemos los 3 números pasados como argumentos `ARGV[]`, y los convertimos a Integer `to_i`.

Lo siguiente que vamos a hacer es ordenarlos. Hay que recordar que un requisito era que no podemos usar Array. Entonces usamos 3 variables `number1, number2, number3` y los ordenamos con sentencias `if`.

Con las sentencias `if` comparamos, por ejemplo el número 1 con el 2, y si el 1 es mayor entonces los intercambiamos. 

Ejemplo:

```ruby
if number1 > number2
  # Itercambiar number1 con number2
  number1, number2 = number2, number1
end
```

> **NOTA**: La forma de intercambiar los valores de las variables es muy sencillo y no requiere el uso de una variable auxiliar o temporal.

**[Ejemplo 2](./02-maxmin.rb): Mínimo y máximo.**

Al tener ordenados los 3 números, ya tenemos el mínimo y el máximo, sin hacer nada.

**[Ejemplo 3](./03-maxmin.rb): Indicar si son pares o impares.**

Lo que nos enseñan, para saber si un número es par o impar, es dividir el número por 2 y si el resto es cero, entonces es par, en caso contrario es impar. Vale, vamos a implementar este algoritmo.

> NOTA: El operador para calcular el resto es `%`.

Para mayor claridad usaremos dos nuevas variables `min_parity` y `max_parity` para establecer la paridad de cada valor.

**[Ejemplo 4](./04-maxmin.rb): En Ruby todo son objetos. Métodos `odd?` y `even?`.**

Dentro de una sesión de `irb` podemos inspeccionar los métodos que tienen los Integer:

```bash
>> 3.odd?
   3.odd?Press Alt+d to read the full document   
         Integer.odd?                            
                                                 
         (from ruby core)                        
         ----------------------------------------
           int.odd?  ->  true or false           
                                                 
         ----------------------------------------
                                                 
         Returns true if int is an               
         odd number.         
>> 3.odd?
=> true

>> 3.even?
   3.even?Press Alt+d to read the full document   
          Integer.even?                           
                                                  
          (from ruby core)                        
          ----------------------------------------
            int.even?  ->  true or false          
                                                  
          ----------------------------------------
                                                  
          Returns true if int is an               
          even number.         
>> 3.even?
=> false
```

> **NOTA**: Lo nombres de los métodos en Ruby pueden contener el carácter `?`. Lo habitual es que los rubydevelopers pongan nombres como `es_un_jedi?()` o `color_de_sable_laser?()` cuando el método devuelve un valor booleano. De esta forma, se consigue mayor "naturalidad" a la hora de escribir y leer el código.

Vamos a modificar el ejemplo anterior para usar estos métodos de los números, pero también vamos a modificar los `if`. Como los condicionales sólo tienen una línea o instrucción dentro de su bloque... los podemos convertir a "operadores ternarios".

**Definición de "operador ternario"**: El condicional en una sola línea se conoce comúnmente en programación como "operador ternario". Es una forma concisa de evaluar una condición y devolver un valor específico si es verdadera (true) o uno diferente si es falsa (false), reemplazando la estructura tradicional if-else. Su sintaxis general es: `condición ? expresión_si_verdadero : expresión_si_falso`.

**[Ejemplo 5](./05-maxmin.rb): Usando Array (Listas).**

¡Sí! En el enunciado se "prohibía" expresamente usar Array (Listas) para resolver este problema. De modo que nos debemos quedar con el ejemplo anterior y ¡listo!. 

Pero no he podido resistirme. Resulta que desde el momento que leí el enunciado mi mente sólo pensaba en Array, Array, Array. ¿Por qué? Porque este objeto está pensado para resolver este problema de forma "natural". De modo, que como no me puedo resistir... pongo esta evolución del ejemplo usando Arrays.

Empezamos creando una variable `numbers` de tipo Array con los 3 valores:

```ruby
# Leer tres números por argumentos y creamos un Array
numbers = [
  ARGV[0].to_i,
  ARGV[1].to_i,
  ARGV[2].to_i
]
```

El código se simoplifica mucho porque NO tenemos que ordenar los números para calcular el mínimo y el maximo. Resulta que el Array es un objeto tiene los métodos `min()` y `max()` que se encargan de hacer el trabajo por nosotros:

```ruby
# ¿Ordenamos los números? No hace falta
# Tenemos el mínimo y el máximo
min = numbers.min
max = numbers.max
```

---

_Hasta aquí hemos terminado de "evolucionar" los "máximos y mínimos", ahora puedes seguir con el siguiente problema._