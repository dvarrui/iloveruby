
# Los métodos +@ y -@

```ruby
class A
  attr_accessor :data

  def -@
    @data.upcase
  end

  def -@
    @data.downcase
  end
end

a = A.new
a.data = "Darth Vader"

puts +a # => "DARTH VADER"
puts -a # => "darth vader"
```

# Creando el metodo `++`

> Enlace de interés:
> https://docs.ruby-lang.org/en/master/syntax/methods_rdoc.html#label-Method+Names

It isn't possible to implement i++, but it is... kinda... possible to
implement ++i. Take a look at the following code. Just please don't use
it in production 😉

```ruby
class IntContainer
   def initialize(value, origref=nil)
     @value = value
     @origref = origref
   end

   def +@
     case @origref
     when nil
       IntContainer.new(+@value, self)
     else
       @origref.value += 1
       @origref
     end
   end

   def -@
     case @origref
     when nil
       IntContainer.new(-@value, self)
     else
       @origref.value -= 1
       @origref
     end
   end

   attr_accessor :value

   def method_missing(meth, ...)
     IntContainer.new(@value.send(meth, ...))
   end

   def inspect(...) = @value.inspect(...)
   def to_s(...) = @value.to_s(...)
end

int = IntContainer.new(5)
p int + 10
++int
p int
--int
p int
```

On 10/14/22 19:01, iloveruby wrote:
> Is it posible define new method :++ to Integer class?
>
> Thanks!
>
>
> Enviado desde Proton Mail móvil
>
>
>
> -------- Mensaje original --------
> El 14 oct 2022 4:53, Martin DeMello < martindemello@gmail.com> escribió:
>
>
>     i++ works in C and similar languages because a variable is a
>     concrete object, representing a specific chunk of memory. i++
>     increments the contents of that chunk of memory.
>
>     in ruby, a variable is a transparent reference to an object, so
>     any operation on a variable is actually an operation on the object
>     it points to. i++ would mean "mutate the object i points to by
>     incrementing it by 1", and since numbers are immutable you cannot
>     do that. on the other hand, "i += 1" is just shorthand for "i =
>     i + 1", which means "point the variable i to a new object that is
>     1 more than the object it currently points to", which works fine
>     with ruby's semantics.
>
>     here's an illustration by contrast with strings, which do have
>     mutating methods:
>
>
>     irb(main):001:0> a = "hello"
>     => "hello"
>     irb(main):002:0> b = a
>     => "hello"
>     irb(main):003:0> a.upcase!
>     => "HELLO"
>     irb(main):004:0> b
>     => "HELLO"
>     irb(main):005:0> i = 1
>     => 1
>     irb(main):006:0> j = i
>     => 1
>     irb(main):007:0* i++ # <- what would you expect j to be after this?
>
>
>     martin
>
>     On Thu, Oct 13, 2022 at 7:40 PM Henrik P <henrik@simplemail.co.in>
>     wrote:
>
>         I found for a int the "++" operator doesn't work in ruby.
>         such as,
>
>         i=0
>         i++
>
>         not working. but instead it would write as:
>
>         i=0
>         i += 1
>
>         so "++" is not supported in ruby really? thanks
>
>
>         $ ruby -v
>         ruby 2.6.3p62 (2019-04-16 revision 67580)
>         [universal.x86_64-darwin20]
>
>         --
>         Simple Mail
>         https://simplemail.co.in/
>
>         Unsubscribe:
>         <mailto:ruby-talk-request@ruby-lang.org?subject=unsubscribe>
>         <http://lists.ruby-lang.org/cgi-bin/mailman/options/ruby-talk>
>
>
> Unsubscribe: <mailto:ruby-talk-request@ruby-lang.org?subject=unsubscribe>
> <http://lists.ruby-lang.org/cgi-bin/mailman/options/ruby-talk>
 ______________________________________________
 ruby-talk mailing list -- ruby-talk@ml.ruby-lang.org
 To unsubscribe send an email to ruby-talk-leave@ml.ruby-lang.org
 ruby-talk info -- https://ml.ruby-lang.org/mailman3/postorius/lists/ruby-talk.ml.ruby-lang.org/
