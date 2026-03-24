

Hacer un DSL en Ruby para que parezca Lisp es llevar la flexibilidad de Ruby a su límite absoluto. En Lisp (y Racket), la elegancia proviene de que todo es una lista y el operador va al principio: (operador operando1 operando2).

En Ruby, podemos imitar esto usando arrays, bloques y métodos de una sola letra.
1. El motor: El evaluador Lisp

Para que Ruby entienda la estructura (f, x, y), usaremos el hecho de que en Ruby los paréntesis son opcionales y podemos pasar arrays.
Ruby

class Lisp
  # Definimos las funciones básicas
  def self.+(a, b); a + b; end
  def self.*(a, b); a * b; end
  def self.println(val); puts val; end
  
  # El evaluador: toma un array donde el primer elemento es el método
  def self.eval(list)
    return list unless list.is_a?(Array)
    
    method, *args = list
    # Evaluamos los argumentos recursivamente (por si son listas anidadas)
    evaluated_args = args.map { |arg| eval(arg) }
    
    # Llamamos al método en esta clase
    send(method, *evaluated_args)
  end
end

# Definimos un método global "L" para crear la estructura de lista
def L(*args)
  args
end

2. El DSL en acción: Sintaxis Lisp en Ruby

Ahora podemos escribir código que, aunque técnicamente es Ruby, se lee y estructura como Lisp.
Ruby

# Usamos el método de ayuda 'L' para simular los paréntesis de Lisp
expresion = L(:*, 10, L(:+, 5, 5))

# Resultado: (* 10 (+ 5 5))
Lisp.eval(expresion) # => 100

Lisp.eval L(:println, L(:*, 7, 6)) # Imprime 42

3. Llevándolo al extremo: "S-Expressions" con Bloques

Si queremos evitar las comas y los símbolos (como :+, :*), podemos usar la técnica de method_missing para que Ruby atrape cualquier nombre de función inexistente y lo convierta en una operación.
Ruby

class LispEngine
  def method_missing(name, *args)
    # Si el argumento es un bloque, lo evaluamos
    args = args.map { |a| a.is_a?(Proc) ? a.call : a }
    
    case name
    when :add then args.reduce(:+)
    when :mul then args.reduce(:*)
    when :say then puts args.join(" ")
    else super
    end
  end

  def run(&block)
    instance_eval(&block)
  end
end

# DSL Final
lisp = LispEngine.new
lisp.run do
  say add(5, mul(10, 2)) # => Imprime 25
end

Comparativa HCI: ¿Por qué esto es interesante?

Desde la Interacción Humano-Máquina, comparar el Lisp original con este DSL de Ruby revela cosas profundas sobre la carga cognitiva:

    Uniformidad: Lisp es más elegante porque no distingue entre "funciones" y "operadores". En Ruby, tuvimos que mapear add para evitar problemas con el símbolo +.

    Homoiconicidad: En el primer ejemplo (L(:+, 1, 2)), logramos que el código sea una estructura de datos (un Array de Ruby). Esto permite que el programa pueda "leerse a sí mismo" antes de ejecutarse, que es la esencia de Racket y Lisp.

¿Cuál es mejor para un DSL?

    Ruby: Es mejor para crear lenguajes que parezcan naturales (como Logo o Chef). Su fuerte es ocultar la sintaxis técnica.

    Racket: Es mejor para crear lenguajes que sean lógicamente perfectos. En Racket no "imitas" un lenguaje, creas uno nuevo que el compilador entiende de forma nativa.

¿Te gustaría ver cómo se define una macro en Racket para crear una estructura de control que no existe en ningún otro lenguaje? Sería el cierre perfecto para entender por qué Racket es el "nivel final" de la elegancia.

Puedes definir los métodos como

.+ .* etc

¡Exactamente! Has dado en el clavo de la metaprogramación extrema en Ruby. Debido a que en Ruby los operadores como +, *, [] o -@ son en realidad métodos, puedes definirlos (o redefinirlos) para que se comporten como tú quieras dentro de tu DSL.

Para que tu DSL parezca Lisp, podemos definir estos operadores dentro de una clase "limpia" para que actúen sobre los argumentos que les pases.
1. El DSL "Operador-Primero" en Ruby

Aquí tienes cómo definir los métodos +, * y otros para que funcionen como en Lisp:
Ruby

class LispEnvironment
  # Definimos el operador + para que acepte múltiples argumentos
  def +(a, b, *rest)
    [a, b, *rest].reduce(:+)
  end

  # Definimos el operador *
  def *(a, b, *rest)
    [a, b, *rest].reduce(:*)
  end

  # Definimos una función de impresión
  def prn(val)
    puts "=> #{val}"
  end

  # El método 'L' simplemente evalúa el bloque en este contexto
  def self.run(&block)
    new.instance_eval(&block)
  end
end

# --- USO DEL DSL ---
LispEnvironment.run do
  prn +(1, 2, 3, 4)           # Como en Lisp: (+ 1 2 3 4)
  prn *(10, +(5, 5))         # Como en Lisp: (* 10 (+ 5 5))
end

2. ¿Por qué Ruby permite esto y otros no?

Desde la perspectiva de la Interacción Humano-Máquina (HCI) y el diseño de lenguajes, esto se llama "Syntactic Sugar" llevado al límite:

    Uniformidad de Llamada: En Ruby, escribir 1 + 2 es azúcar sintáctico para 1.+(2). Al definir def +(a, b), estamos permitiendo que el método se llame de forma funcional dentro del contexto del objeto.

    Reducción de la Distancia Semántica: El usuario que quiere escribir Lisp no tiene que aprender un comando nuevo como add(); puede usar el símbolo matemático que ya conoce, pero en la posición que el paradigma requiere (prefijo).

3. La gran limitación frente a Racket/Lisp

Aunque Ruby es muy flexible, hay una diferencia fundamental en la elegancia de ingeniería:

    En Ruby: El número de argumentos está limitado por la definición del método, y seguimos necesitando comas , entre los argumentos porque Ruby es un lenguaje de la familia de C. No podemos deshacernos de las comas sin romper la sintaxis.

    En Racket: No hay comas. El espacio es el separador. (+ 1 2 3) es una lista pura. El "ruido visual" es menor.

Comparativa Final de "Elegancia Sintáctica"
Lenguaje	Sintaxis	¿Es natural?	Flexibilidad
Go	Add(1, 2)	No, es rígido.	Muy baja.
Python	add(1, 2)	Estándar.	Media.
Ruby (DSL)	+(1, 2)	Sí, parece otro lenguaje.	Muy alta.
Racket	(+ 1 2)	Total, es su naturaleza.	Infinita.
El reto final: Macros

En Ruby, acabamos de hacer que el lenguaje parezca Lisp. Pero en Racket, podrías crear una macro que haga que el código se ejecute al revés, o que invente una estructura unless-even que no existe.

¿Te gustaría que te mostrara cómo Racket hace esto con su sistema de Macros, algo que ni Ruby ni Python pueden replicar de forma tan elegante?

