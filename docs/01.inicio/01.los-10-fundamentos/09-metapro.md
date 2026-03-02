[<< back](./README.md)

# 9. La metaprogramación

```
IMHO: El arma secreta
```

## 9.1 Introducción

Cuando estudiaba en la Universidad (ULPGC) la carrera de Ingeniería Informática, en 4º teníamos una asignatura muy interesante llamada "Inteligencia Artificial" (no iba de los LLM tan populares hoy en día). Recuerdo que nos enseñaron LISP en la asignatura de IA, aunque ya lo conocía de haber leído un libro de LISP.

En aquella época sólo conocía BASIC, Pascal, C y un poco de ensamblador... y nunca había visto nada parecido. Y recuerdo que se me quedó grabado en la mente, provocando una disonancia cognitiva incómoda pero sorprendente a la vez... **LISP tiene la propiedad de automodificarse en tiempo de ejecución**. A eso es a lo que nos referiremos como "metaprogramación".

Resulta que LISP veía a su propio código como datos y el programa podía cambiarse a sí mismo durante su ejecución. ¡Me flipo! (Si, es una expresión de persona mayor de los 80, pero es el término que encaja). ¿Cómo es posible que existiera algo así? ¿Qué utilidad tenía? ¿No es acaso un sin sentido que se cree un algoritmo determinista que luego cambia y entonces deja de ser tan determinista? ... Esta idea nunca me abandonó pero sí que la dejé "congelada" en mi mente porque tenía que seguir con la vida. De C pasé a C++ y rápidamente dí el salto a Java, y de forma, fortuita (o quizás el destino lo quiso así), llegué a un lenguaje que daba respuesta a los problemas o las fricciones que tenía con los lenguajes anteriores. Ruby en el 2005.

Matz, para crear Ruby, se inspiró en LISP, Perl y SmallTalk, y cogió la idea de metaprogramación de LISP para Ruby (¡Me encantó!).

Pero... debo hacer una advertencia. La metaprogramación divide a los programadores/ingenieros. Para algunos es un superpoder, y para otros es una aberración de la que hay que huir como de la peste. Mi sugerencia es, mira un poco de que va todo esto y si no te gusta te vas y tan felices.

> **NOTA**: Como ya dijimos, siempre vamos a acompañar a nuestros programas de los test adecuados, por lo tanto vamos a tener el superpoder de la metaprogramación "controlado" en todo momento para que no sea como "dispararse en la pierna".

## 9.2 Definición

La metaprogramación en Ruby es, en pocas palabras, escribir código que escribe código. Ruby es uno de los lenguajes más dinámicos que existen, lo que le permite alterarse a sí mismo en tiempo de ejecución.

> Si alguna vez has usado Rails y viste métodos como `find_by_nombre`, ese método no existe físicamente en el código; Ruby lo "fabrica" al vuelo cuando lo necesita.

## 9.3 Los pilares

**El Modelo de Objetos (Open Classes)**: En Ruby, las clases nunca están cerradas. Puedes reabrir cualquier clase (incluso las nativas como String o Integer) y añadirle métodos.

```ruby
class String
  def gritar
    self.upcase + "!!!"
  end
end

puts "hola".gritar # => "HOLA!!!"
```

A esto se le llama a veces "Monkey Patching". Úsalo con cuidado.

**send: Invocar métodos dinámicamente**: El método send te permite llamar a un método pasando su nombre como un símbolo o un string. Esto es útil cuando no sabes qué método llamar hasta que el programa está corriendo.
Ruby

```ruby
user = "pedro"
# En lugar de user.upcase
puts user.send(:upcase) # => "PEDRO"
```

**define_method: Crear métodos sobre la marcha**: Este es el corazón de la metaprogramación. Te permite definir métodos dentro de una clase usando lógica de programación.

```ruby
class Saludador
  [:hola, :adios, :que_tal].each do |metodo|
    define_method(metodo) do |nombre|
      "#{metodo.to_s.capitalize}, #{nombre}!"
    end
  end
end

s = Saludador.new
puts s.hola("Ruby")    # => "Hola, Ruby!"
puts s.que_tal("Gemini") # => "Que_tal, Gemini!"
```

**method_missing: El "Atrapalotodo"**: Cuando llamas a un método que no existe, Ruby lanza un error. Pero antes de eso, pasa por un método especial llamado method_missing. Puedes interceptarlo para crear magia.

```ruby
class DiccionarioMagico
  def method_missing(nombre_metodo, *args)
    "Intentaste llamar a '#{nombre_metodo}' con #{args}. No existe, pero te respondo igual."
  end
end

d = DiccionarioMagico.new
puts d.cualquier_cosa(1, 2) 
# => "Intentaste llamar a 'cualquier_cosa' con [1, 2]..."
```

**instance_eval y class_eval**: Estos métodos rompen la encapsulación para evaluar código dentro del contexto de un objeto o una clase.

* **instance_eval**: Accede a las variables privadas de una instancia.
* **class_eval**: Añade métodos a una clase como si estuvieras escribiendo dentro de su archivo .rb.

```ruby
class Persona
  def initialize
    @secreto = "1234"
  end
end

p = Persona.new
# Accediendo a lo prohibido:
puts p.instance_eval { @secreto } # => "1234"
```

## 9.4 Resumen

```
"Tío Ben: Un gran poder conlleva una gran responsabilidad".
```

La metaprogramación hace que el código sea muy difícil de depurar (porque el método que falla no aparece en el buscador de tu editor). Úsala solo cuando simplifique drásticamente el problema.

Una utilidad muy buena de la metaprogramación de Ruby es para ayudar a la creación de DSL. En esto Ruby es un "crack".

> NOTA: Consultar la sección de DSL para ver algunos ejemplos.
