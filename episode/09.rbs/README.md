
# RBS: tipado estático en Ruby

Enlaces de interés:
* [RBS: A New Ruby 3 Typing Language in Action](https://blog.appsignal.com/2021/01/27/rbs-the-new-ruby-3-typing-language-in-action.html)
* [GitHub - ruby/rbs: Type Signature for Ruby](https://github.com/ruby/rbs)
* [Understanding RBS, Ruby's new Type Annotation System](https://www.honeybadger.io/blog/ruby-rbs-type-annotation/)

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

No sé si hay más lenguajes así... me gustaría saberlo y conocerlos.

Veamos cómo puede ser esto posible.

# 4. Ejemplo
