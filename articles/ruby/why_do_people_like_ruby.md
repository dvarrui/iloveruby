
# Why do people like Ruby?

> Enlace al artículo original: https://dev.to/cjbrooks12/why-do-people-like-ruby-374b

Soy un chico de Java y realmente no me gusta Ruby. Pero mucha gente realmente lo ama. Simplemente creo que no lo entiendo muy bien, y que mi ignorancia me hace odiarlo. No estoy buscando comenzar un flamewar, sólo tengo curiosidad por saber por qué a tanta gente le gusta Ruby.

En mi experiencia, cada vez que he intentado usar Ruby, o un framework como Rails o Jekyll, o una herramienta como Vagrant o Fastlane con una configuración de Ruby, me encuentro irremediablemente confundido por las mismas cosas que se promocionan como "Grandes características de Ruby", y paso interminables horas depurando cosas que resultan ser una extraña peculiaridad de la "magia de Ruby".

Así que, por favor, dígame por qué a la gente le gusta Ruby, y si la gente alguna vez "aprende a amarlo" y realmente lo aprende después de años de trabajar con un lenguaje más "tradicional" o de estilo C, o es solo la gente que comenzó su carrera en Ruby que realmente lo aman?

---
https://dev.to/briankephart
17 jul 18

La flexibilidad y expresividad de Ruby lo hacen ideal para escribir DSL y frameworks y para escribir código con muy pocas repeticiones. La complejidad adicional de los DSL y los frameworks a menudo dificulta que los nuevos desarrolladores de Ruby sepan qué está pasando.

Cuando era nuevo en la programación, aprendí C, además de un poco de PHP y Python. Cuando comencé a usar Ruby, era tan FÁCIL. Me encontré preguntándome por qué otros idiomas son tan detallados o requieren una sintaxis bizantina. Todavía no puedo entender por qué alguien haría un idioma sin interpolación de cadenas.

Parte de la razón por la que Ruby parece mágico es por su consistencia en algunas áreas clave. Todo es un objeto, y cada expresión devuelve un objeto. Esto lleva a consecuencias como el retorno implícito y el encadenamiento de métodos. Estas no son características, necesariamente, sino consecuencias naturales de los principios anteriores. Estas cosas tienen mucho sentido si aprendiste Ruby desde cero, basado en los propios principios de Ruby. Pueden ser menos obvios si está tratando de aplicar su paradigma de programación actual a Ruby.

Ciertos principios pueden ser difíciles de pensar en Ruby. Estoy bastante seguro de que cuando Matz lo diseñó, no estaba preocupado por explicar el paso por referencia frente al paso por valor. Eso generalmente se debe a que Ruby lo anima a pensar de otra manera, y eso puede ser doloroso para quienes tienen experiencia.

Creo que tuve una ventaja al aprender Ruby al principio de mi viaje de programación y de aprenderlo como un lenguaje en lugar de a través de Rails. Usé Ruby Koans y CodeAcademy.

De todos modos, no sé por qué escribí todo eso. Debería haber publicado este enlace y callarme.
---
ryan@thepalos.com

17 julio 18

Odié a Ruby la primera vez que intenté aprenderlo (viniendo de Python). Creo que la razón principal fue que traté de aprender Ruby y Rails al mismo tiempo, sumergiéndome directamente en Rails sin obtener una base sólida de Ruby. También odiaba la magia y el vudú de que tenías que simplemente "asumir que funcionó".

Así que me rendí.

Regresé para intentarlo de nuevo un año después, porque tenía muchas ganas de que me gustara Ruby. Esta vez, comencé con Ruby Monk, que es una excelente manera de aprender porque te enseña a hacer las cosas "The Ruby Way(s)". Aprendes que no hay realmente "magia", solo que algunas cosas son implícitas, pero predecibles. Cosas como "puede llamar a una función como puts('hola') o puts 'hola', y ambas están bien. Una vez que tuve una base sólida, Rails tuvo mucho más sentido y pude ver a través y detrás de la magia No tenía que confiar en que estaba funcionando, porque sabía lo que estaban haciendo las cosas detrás de escena.

¡Ahora, amo a Rubí! Me encanta porque puede tomar tareas, procesos o conceptos realmente complejos y el código se parece a lo que podrías decir en voz alta al explicárselo a tu amiguito patito de goma. Ruby es el único lenguaje en el que he escrito que termino un bloque o un método y tengo esta sensación de

Mmm... justo.

Ahhh... eso es bueno. Como cuando alisas las sábanas de una cama a la perfección y todo está plano y suave y todo está bien en el mundo. (Está bien, tal vez ese ejemplo diga más sobre mi personalidad que lo agradable que es Ruby, pero espero que entiendas la idea).

```ruby
fruits = ["apple", "pear", "bananana", "orange"]

puts fruits.sort_by { |item| item.length }
            .map { |item| item.upcase }
            .select { |item| item.length.even? }

# => PEAR, ORANGE, BANANANA
# I know banana has too many na's.  I did it for the sorting to be pretty.
```

---

Leí la siguiente publicación y me encontré de acuerdo con la noción presentada dentro:

mkdev.me/en/posts/los-tres-tipos-...

Esencialmente, argumenta que hay tres mentalidades básicas en la programación y los lenguajes que le gustan con la mentalidad:

* el tipo de ingeniería (le gusta C, Java, JavaScript, Rust, etc.)
* el tipo matemático (como Haskell, Clojure, R, etc.)
* el tipo de escritor (le gusta Ruby, CoffeeScript, "programación alfabetizada", etc.)

Soy muy del tipo de ingeniería e independientemente de si realmente hay 3 tipos o lo que sea, considero que la programación la hacen diferentes personas con mentes muy diferentes y les gustan los lenguajes que vienen naturalmente a su forma de pensar. No es mejor o peor, sino diferente ángulo de enfoque.

---

Back in 2001, freshmen year at college, I was wondering why simple "Hello World!" in C had to look like:

#include <stdio.h>
int main()
{
   printf("Hello, World!");
   return 0;
}

Back in 2003, I was wondering why a simple "Hello World!" in C++ had to look like:

#include <iostream>

int main()
{
  std::cout << "Hello World!" << std::endl;
  return 0;
}

Back in 2007, I was wondering why the simple "Hello World!" in Java has to look like:

public class HelloWorld {

    public static void main(String[] args) {
        System.out.println("Hello, World");
    }
}

In 2008, I found out that it can look like:

puts 'Hello World!'

I was never looking the other way!

Btw., I am an engineer.
