
# Reversing DidYouMean Gem

> https://dev.to/yet_anotherdev/reversing-didyoumean-gem-4hbg

# Introducción

¡Vamos a sumergirnos en Ruby! Hay una gema muy útil que no vemos pero que es una especie de salvador para nosotros los desarrolladores.

Es obvio que hablo de la gema DidYouMean.

Quiero profundizar en esta Gema, que a veces puede parecer un poco mágica. Pero cualquier tecnología lo suficientemente avanzada puede parecer magia, ¿verdad?

Quiero dar un agradecimiento especial a mi maravillosa esposa. Eso crea ese mensaje maravilloso y muchos más que vendrán.

# ¿Qué magia es esta?

¿cómo puede Ruby sugerirme métodos o atributos que tal vez estén mal escritos? Parece como si lo adivinara, ¿hay alguna IA compleja detrás de tod esto?

No, en absoluto, solo un buen código Ruby. Pero, ¿cómo puede adivinar qué métodos hay en mi objeto o cosas por el estilo? Las clases y los objetos pueden ser inspeccionados, se puede echar un vistazo dentro y ver lo que hay en cualquier momento.

Por ejemplo, si queremos ver los métodos en la clase `Object`, podemos hcer los siguiente en IRB:

```
irb(main):001:0> Object.methods
```

De la misma manera, si tiene invocamos al métodos `methods` sobre cualquier objeto, podremos consultar sus métodos.

De acuerdo, ahora, ¿cómo puede Ruby adivinar los métodos correctos si cometí un error tipográfico o incluso si escribí métodos en lugar de métodos, por ejemplo?

# Magia Negra aka Matemáticas

No profundizaré mucho en el algoritmo, no es el propósito de este artículo. Pero necesito hablar de ese tema. En matemáticas, tenemos unas funciones que se llaman distancias. Calculan distancias entre "objectos".

Para calcular la distancia entre 2 "objetos" (como 2 cadenas) la Gema DidYouMean utiliza 2 distancias:

* distancia de JaroWinkler
* distancia de Levenstein

Hay varias formas de implementar estos algoritmos. Veamos el código del corrector ortográfico de la gema DidYouMean, y vamos a intentar descomponerla.

```ruby
require_relative "levenshtein"
require_relative "jaro_winkler"

module DidYouMean
  class SpellChecker
    def initialize(dictionary:)
      @dictionary = dictionary
    end

    def correct(input)
      threshold = input.length > 3 ? 0.834 : 0.77

      words = @dictionary.select { |word| JaroWinkler.distance(word, input) >= threshold }
      words.reject! { |word| input.to_s == word.to_s }
      words.sort_by! { |word| JaroWinkler.distance(word.to_s, normalized_input) }
      words.reverse!

      # Correct mistypes
      threshold   = (input.length * 0.25).ceil
      corrections = words.select { |c| Levenshtein.distance(normalize(c), normalized_input) <= threshold }

      # Correct misspells
      if corrections.empty?
        corrections = words.select do |word|
          length = input.length < word.length ? normalized_input.length : word.length

          Levenshtein.distance(word, normalized_input) < length
        end.first(1)
      end

      corrections
    end

  end
end
```

# Diccionario

Empezamos con esta parte:

```ruby
def initialize(dictionary:)
      @dictionary = dictionary
end
```

Definimos un diccionario para nuestro corrector ortográfico, esto será la lista de cadenas contra las que buscará para 'adivinar' una corrección.

Aquí la primera parte de nuestro artículo toma mucho sentido, por ejemplo, nuestro diccionario podría ser la lista de métodos de nuestro objeto, por ejemplo `a.methods`.

# Filtrar las palabras del diccionario

Luego tenemos los métodos correctos en los que voy a centrarme.
Tenemos esta primera parte para los métodos correctos:

```ruby
threshold = input.length > 3 ? 0.834 : 0.77

words = @dictionary.select { |word| JaroWinkler.distance(word, input) >= threshold }
words.reject! { |word| input.to_s == word.to_s }
words.sort_by! { |word| JaroWinkler.distance(word.to_s, normalized_input) }
words.reverse!
```

Definimos un umbral que depende de la longitud de la entrada.

Luego tenemos el filtrado de las posibles correcciones de nuestra palabra. Lo hacemos calculando la distancia JaroWinkler de la entrada con las palabras del diccionario.

Entonces, ¿para qué necesitamos el umbral? Cuando calculamos la distancia, nos dará una puntuación de 'proximidad' entre las cadenas comparadas. Pero por lo visto con una entrada de tamaño inferior a 3, la distancia de JaroWinkler se comporta mal.

# Escogiendo la corrección adecuada

Una vez que hemos encontrado las palabras más cercanas, tenemos que sugerir la mejor.

```ruby
threshold   = (input.length * 0.25).ceil
corrections = words.select { |c| Levenshtein.distance(normalize(c), normalized_input) <= threshold }
```

Usamos un umbral diferente ya que la distancia de Levenstein no está normalizada. Y luego seleccionamos lo valores bajo el umbral.

Puede que se pregunte por qué necesitamos 2 distancias.

Una respuesta podría ser que JaroWinkler es más rápido que Leveinstein pero menos preciso. Así que queremos usar JaroWinkler para filtrar previamente las palabras más cercanas y luego, entre estas, tomar las mejores sugerencias.

Por supuesto, esto es solo una suposición. Si tiene la respuesta o una suposición mejor, no dude en compartirla conmigo.

# La última oportunidad

Para esta parte, también sólo lo supongo, pero creo que no es una suposición. El cálculo anterior puede finalmente no devolvernos ninguna respuesta porque el umbral para la distancia de Levenstein puede ser demasiado pequeño y no hay nada tan cerca como el umbral especificado.

Lo intentamos de nuevo con este código:

```ruby
if corrections.empty?
  corrections = words.select do |word|
    length = input.length < word.length ?
    normalized_input.length : word.length
    Levenshtein.distance(word, normalized_input) < length
  end.first(1)
end
```

Se ha definido un nuevo umbral para que poder encontrar una sugerencia.

# Conclusión

Este ha sido el primer artículo de una serie sobre inmersión en el lenguaje Ruby. Si encuentra algo incorrecto o desea agregar algo, deje un comentario.

Estaré muy feliz de leer sus comentarios y mejorar el artículo si es necesario.
Si desea obtener más explicaciones sobre la distancia de JaroWinkler y Leveinstein, aquí hay dos artículos.

¡Gracias por leerme y hasta la vuelta!

On Twitter : @yet_anotherdev
