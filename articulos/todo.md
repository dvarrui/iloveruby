
===================================================
RUBY

* [Why do people like Ruby?](https://dev.to/cjbrooks12/why-do-people-like-ruby-374b)

Percent notation
https://deepsource.io/blog/ruby-percent-notation/

Rubyme: My minimalist Ruby Handbook - DEV Community 👩‍💻👨‍💻
https://dev.to/mikelogaciuk/rubyme-my-minimalist-ruby-handbook-2jl9

Learning: Ruby for begginners
http://ruby-for-beginners.rubymonstas.org/built_in_classes/true_false_nil.html

Welcome to RubyKickstart!
RubyKickstart is an interactive guide to learning the Ruby programming language.
https://github.com/Ghostglass/ruby-kickstart

Data inmutable object
https://blog.saeloun.com/2022/11/22/data-immutable-object

Running ruby on jupiter notebooks
https://alec-c4.com/blog/2022-12-25-jupyter-ruby

* Greg Navis. Ruby tip: object allocation and initialization are two separate steps: https://twitter.com/gregnavis/status/1625983757022031878?t=M3_Bhq9fxq-nnBUqvqDHZQ&s=35

==================================================
BASIC

==================================================
TIP

* https://twitter.com/gregnavis/status/1625983787418152964?t=oy4vTWCietHHY3LFov0agA&s=35. Greg Navis: allocate occurs only twice in the entire Rails code base. I haven't seen it or used it anywhere else.

https://twitter.com/alexandre_ruban/status/1619989010805555203?t=8TlgyFcvaahl9HV_BuNQWQ&s=35
Alexandre Ruban. Here are two ways to define methods in Ruby using metaprogramming that you will encounter when reading gems.

https://www.rubycademy.com/cards/flip-flop

Is gets a method or a function?
Question

Learning Ruby and it seems gets is referred to as a method, from my understanding methods have to be associated with an object. What is the object that gets is associated with that makes it a method? For example with gets.chomp, chomp is a method and is associated with the gets object.

https://www.reddit.com/r/ruby/comments/yxw26u/is_gets_a_method_or_a_function/?utm_source=share&utm_medium=android_app&utm_name=androidcss&utm_term=14&utm_content=share_button


Twitter (https://twitter.com/kddnewton/status/1612575680960802816?t=I8HR-IN6cgV1c2z59bHD0A&s=35)
Kevin Newton
In Ruby, the `not` keyword breaks down to a method call to the `!` method

https://twitter.com/kddnewton/status/1613225554236551168?t=aIiwD3hcH_BmgURQrHeMxg&s=35
In Ruby, the expression in the rescue clause that captures a variable can be a method call. That method call doesn't actually need to exist though, because it automatically has = appended to it.
https://pbs.twimg.com/media/FmNTx5HXEB4RdZk?format=png&name=small

===================================================
MEDIUM

https://medium.com/rubycademy/ruby-is-a-multi-paradigm-programming-language-49c8bc5fca80

https://dev.to/vladhilko/8-design-principles-that-every-ruby-developer-should-know-1e7e

The Difference Between instance_eval And class_eval In Ruby.
https://manny.codes/the-difference-between-instance-eval-and-class-eval-in-ruby/

Design Patterns in Ruby
https://refactoring.guru/design-patterns/ruby

===================================================

Ruby-Crystal-Rust Adventure of Code 2022
https://wyhaines.io/rubycrystalrust-advent-of-code-2022-day-3

Es curioso ver las diferencias (pocas) entre Ruby y Crystal, simplemente porque Crystal es un Ruby compilado.
El hecho de usar tipos de datos que van en la pila(stack) o en el heap marca una diferencia relevante.
A un programador Ruby, el tipo de dato le da igual en el sentido de que el intérprete se encargará de gestionarlo. Pero con Crystal al compilar necesita tener algunos datos. Necesita saber el tipo de dato usado para poder conocer el espacio que ocupa, y así poder hacer la reserva en la pila (stack) del programa. Si no fuera posible por el compilador de Crystal establecer dicho espacio (Por ejemplo para los Arrays mutables), entonces este datos deberá guardarse en el heap. Resulta que un programador Crystal si debe tener en cuenta estos aspectos.

El tema de que un datos vaya al heap o al stack es relevante en cuanto al tema de velocidad por un lado y por otro si va al heap puede ser que cuando el heap se llene tengamos un error en tiempo de ejecución.

La cuestión es que los lenguajes de programación deben elegir:
1) Hacer esta información/circunstancia transparente para el programador y dejar que lo resuelva el intérprete como pueda. 
2) Dejar la toma de decisiones en manos del programador.

---
Ruby/Crystal/Rust Advent of Code 2022 - Day 4
https://wyhaines.io/rubycrystalrust-advent-of-code-2022-day-4

===================================================
GEM - LIB

ruby-async
https://brunosutic.com/blog/async-ruby

TracePoint tip
https://twitter.com/kirill_shevch/status/1603750607051005952?t=B1lrMErb1-dX3dT1YjFI0w&s=35

Download pdf
https://twitter.com/the_ruby_dev/status/1603015709071663106?t=zRTRRiwfvKWmVBwyq34jMQ&s=35

===================================================
INTERNALS

RUBY INTERNALS #1 — Ruby scanning and tokens
A study based on Ruby Under a Microscope — An Illustrated Guide to Ruby Internals, by Pat Shaughnessy
https://medium.com/@iagobm/ruby-internals-1-ruby-scanning-and-tokens-78ee815cd633

YARV

https://kddnewton.com/2022/12/03/advent-of-yarv-part-3.html
https://twitter.com/yukihiro_matz/status/1599403326646341632?t=NUyYcG7kN0hjsD39CfBTXg&s=35
https://kddnewton.com/2022/12/17/advent-of-yarv-part-17.html

https://www.akshaykhot.com/render-dynamic-views-using-erb/

===================================================
Revise:
* loop: unless
* private methods
