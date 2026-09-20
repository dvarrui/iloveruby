
# Static method 

> from: ruby-talk-request@ruby-lang.orgi

## How to implement a static method in ruby class?

Do you think if my following code is correct for implementing a static
method (maybe singleton, or class method) in ruby class?

```ruby
class Foo
   @@x = 0

   def self.count
     @@x += 1
     @@x
   end
end

puts Foo.count
puts Foo.count
puts Foo.count
```

The run results:

```
$ ruby t1.rb
1
2
3
```

I want a method like this one in scala code.
```scala
object Foo {
   var int = 0
   def increase = { int += 1; int }
}

println(Foo.increase)
println(Foo.increase)
println(Foo.increase)
```

## Solution

Avoid using class variables. They don’t quite work the way you think they do. They still have their place, but it’s exceedingly rare.

Prefer instance variables, remembering that classes are instances, too.

```ruby
class Foo
  def self.count
    @count ||= 0
    @count += 1
  end
end
```

## Explication

When to use instance methods or class methods, instance variables or class variables, should be directly related to the semantic meaning that you give to your classes. 

The next 'Foo' example, is a factory of Foo instances that acquire their own progressive ID. Thus, the defined class variable remembers the latest assigned ID. 1, 2 and 3 are thus properties of the three produced instances.

```ruby
class Foo
  @@prog=0

  def initialize
    @@prog+=1
    @prog=@@prog
  end

  def to_s
    "I am Foo ##{@prog}"
  end
end

f1=Foo::new
f2=Foo::new
f3=Foo::new

[f1,f2,f3].each_with_index { |f| puts f }
```

The run results:
```
I am Foo #1
I am Foo #2
I am Foo #3

How would you define Foo in your own example? (sorry but I cannot compare scala code).

(K * Carlo E. Prelz - fluido@fluido.as)

