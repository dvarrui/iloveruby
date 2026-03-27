#!/usr/bin/env ruby

# Definir las clase
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def self_introduce
    puts "Person: #{@name} (age: #{@age})"
  end
end

# Crear objetos
obiwan = Person.new("Obiwan", 55)
obiwan.self_introduce
