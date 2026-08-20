
# Ractors

Enlaces de interés:
> Enlace al artículo original:
> * https://blog.appsignal.com/2022/08/24/an-introduction-to-ractors-in-ruby.html
> * TALK: https://www.youtube.com/watch?v=Y29SSOS4UOc
* [Introduction to Ractors in Ruby 3](https://blog.kiprosh.com/ruby-3-introduction-to-ractors/): Ruby 3 has introduced an experimental feature called Ractors.  In this article, let's learn more about Ractor with example usage
* [An Introduction to Ractors in Ruby | AppSignal Blog](https://blog.appsignal.com/2022/08/24/an-introduction-to-ractors-in-ruby.html)


# Aprender sobre los Ractor

* Es una feature disponible en Ruby a partir de la versión 3.0.
* Todavía es una característica experimental.

```bash
$ ruby -e "Ractor.new {}"
-e:1: warning: Ractor is experimental, and the behavior may change in future versions of Ruby! Also there are many implementation issues.
```

* Podemos deshabilitar los mensajes de advertencia con `$VERBOSE=nil`.
* El primer Ractor [01-holamundo.rb](./01-holamundo.rb)

Un Ractor contiene código que se ejecuta de forma independiente del flujo principal sin que le afecte el GVL.

* `Ractor.new do ... end`: Creamos un nuevo Ractor y comienza a ejecutar el bloque de código de inmediato y en paralelo.
* `ractor.take`: El hilo principal (main) espera hasta recibir un valor del Ractor.

