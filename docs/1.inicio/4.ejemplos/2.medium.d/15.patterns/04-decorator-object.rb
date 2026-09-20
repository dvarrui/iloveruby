#!/usr/bin/env ruby
# https://refactoring.guru/design-patterns/decorator/ruby/example


class Component
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteComponent < Component
  def operation
    'ConcreteComponent'
  end
end

class Decorator < Component
  attr_accessor :component

  def initialize(component)
    @component = component
  end

  def operation
    @component.operation
  end
end

class ConcreteDecoratorA < Decorator
  def operation
    "ConcreteDecoratorA(#{@component.operation})"
  end
end

class ConcreteDecoratorB < Decorator
  def operation
    "ConcreteDecoratorB(#{@component.operation})"
  end
end


simple = ConcreteComponent.new
puts 'Client: I\'ve got a simple component:'
print "RESULT: #{simple.operation}"
puts "\n\n"

decorator1 = ConcreteDecoratorA.new(simple)
decorator2 = ConcreteDecoratorB.new(decorator1)
puts 'Client: Now I\'ve got a decorated component:'
print "RESULT: #{decorator2.operation}"
