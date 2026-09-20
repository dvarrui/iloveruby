
# RBS: tipado estático en Ruby

# 1. Introducción

Una de las cosas más emocionantes de Ruby es ver cada nueva entrega y probar las cosas nuevas que ofrece. Pero además hay que resaltar que Ruby Core Team no añade funcionalidades nuevas simplemente. NO. Ellos no trabajan así.

Cuando piensan en incorporar una nueva idea... se debate, se nuestran las alternativas y se explican el diversas RubyConf... pueden pasar años hasta que la idea esté madura y sobretodo... y lo más importante... hasta que se encuentra una forma Ruby de implementarlo.

En Ruby no se añaden "pegotes" al lenguaje, por mucha funcionalidad que sea. Se piensan, se estudian y se forma el Ruby Way.

"Este es el camino".

# 2. Tipado dinámico vs estático

Este tema es el típico para tener una discusión acalorada con cualquier programador de otro lenguaje. No me interesa eso ahora. Aunque reconozco que hay bastante que decir bueno y malo de cada propuesta. Sigo.

¿Qué es lo que me interesa ahora?

Me interesa que Ruby tiene tipado dinámico. Y eso... no va a cambiar. Es una de las cosas que me atrajeron al mundo "rojo". El tipado dinámico tiene unas ventajas que no quiero perder... y estoy dispuesto a pagar el precio de los inconvenientes.

No hay NADA perfecto en esta vida. Tomar una decisión SIEMPRE implica escoger un camino sobre otros que no vas a recorrer... ¿o sí?

# 3. Tipado estático en Ruby

Reconozco que la primera vez que oí hablar a Matz (Creador de Ruby) de la idea de incorporar tipado estático al lenguaje... me quedé muy "confuso". ¿Habría perdido Ruby sus principios fundamentales? ¿Habría dejado de ser aquella maravillosa piedra preciosa de la que estaba enamorado? ¿Podría el enamoramiento cegarme tanto que me hiciera perderme de mi camino? ... muchas preguntas.

Leí, y atendí todos los RubyConf que pude. No quería juzgar precipitadamente, pero al mismo tiempo me estaba preparando un plan B. Si llegado el momento Ruby me engaña... tengo que dajarla marchar. Es ley de vida. Pero bueno..

Matz aclara en un RubyConf... y ya eso me dejó flipando... Ruby mantendrá el tipado dinámico... uff que bien... pero también tendrá tipado estático... ¿eh?

Por un momento, no entendí nada. Eso nunca lo había visto antes. En mi mente había dos mundos separados: **tipado dinámico** (el tipo de las variables se establecen en tiempo de ejecución) y **tipado estático** (el tipo de las variables se establece antes de ejecutar el programa). Pues... resulta me mente estaba cerrada... puesto que se pueden tener ambos tipos en tiempos diferentes. Guay!

> NOTA: Ruby tiene ahora...tipado fuerte, dinámico y estático. ¡La pasada!

No sé si hay más lenguajes así... me gustaría saberlo y conocerlos.

Veamos cómo puede ser esto posible.

# 4. Ejemplo

## 4.1 Ejemplo 1 dinámico

Un programa típico de Ruby con tipado dinámico:
* [01-appsignal.rb](01-appsignal.rb)
* [01-main.rb](01-main.rb)

Ejecutamos el main para ver lo que ocurre, comprobamos que funciona y no hay control de tipos.

## 4.2 Ejemplo 2 estático

> Enlaces de interés
> * [RBS: A New Ruby 3 Typing Language in Action](https://blog.appsignal.com/2021/01/27/rbs-the-new-ruby-3-typing-language-in-action.html)
> * [GitHub - ruby/rbs: Type Signature for Ruby](https://github.com/ruby/rbs)
> * [Understanding RBS, Ruby's new Type Annotation System](https://www.honeybadger.io/blog/ruby-rbs-type-annotation/)

Un programa Ruby con tipado estático:
* [lib/02-appsignal.rb](lib/02-appsignal.rb)
* [02-main.rb](02-main.rb)

_¿Eh? ¡Estás bromeando! ¡Es igual al anterior!... ¡Si! Ahora creamos los tipos estáticos._

Para crear los tipos estáticos hacemos lo siguiente:
1. Instalar las gemas rbs y typeprof
```
gem install rbs`.
gem install typeprof
```

2. Vamos a usarlas.

*RBS is a language to describe the structure of Ruby programs. You can write down the definition of a class or module: methods defined in the class, instance variables and their types, and inheritance/mix-in relations. It also allows declaring constants and global variables*.

```
❯ typeprof 02-appsignal.rb
/home/david/.rbenv/versions/3.0.3/lib64/ruby/gems/3.0.0/gems/typeprof-0.21.2/lib/typeprof/lsp.rb:417: warning: One-line pattern matching is experimental, and the behavior may change in future versions of Ruby!
# TypeProf 0.21.2

# Classes
class Super
  @val: untyped

  def initialize: (untyped val) -> void
  def val?: -> untyped
end

class Test < Super
  @flag: untyped

  def initialize: (untyped val, untyped flag) -> void
  def flag?: -> untyped
end
```

Analizar 02-appsignal.... no ayuda mucho. Nos hace una propuesta de tipos, pero no es capaz de deducir nada. Lo podemos hacer manualmente... ¡Che... espera y sigue!

3. Vamos a userla pero esta vez con el fichero principal:

```
❯ typeprof 02-main.rb
/home/david/.rbenv/versions/3.0.3/lib64/ruby/gems/3.0.0/gems/typeprof-0.21.2/lib/typeprof/lsp.rb:417: warning: One-line pattern matching is experimental, and the behavior may change in future versions of Ruby!
# TypeProf 0.21.2

# Classes
class Super
  @val: String

  def initialize: (String val) -> void
  def val?: -> String
end

class Test < Super
  @flag: bool

  def initialize: (String val, bool flag) -> void
  def flag?: -> bool
end
```
¿eh¿ Ya empieza a detectar cositas... Ya sabe que:
* `var` es `String` y
* `flag` es `bool`.

4. `typeprof 02-main.rb > 02-appsignal.rbs`.

## 4.3 Ejemplo 3

Ahora copiamos el ejemplo 2 al 3 y vamos a hacer un error de tipos en main.
Un programa Ruby con tipado estático:
* [lib/03-appsignal.rb](lib/03-appsignal.rb)
* [sig/03-appsignal.rbs](sig/03-appsignal.rbs)
* [03-main.rb](03-main.rb)
