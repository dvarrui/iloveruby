#!/usr/bin/ruby

print "Ejecutando",$0,"\n"

class Persona
  def initialize(nombre)
    @nombre = nombre
  end

  def saludar
    puts "#{@nombre}: Soy #{self.class}."
  end
end

david = Persona.new('David')
david.saludar

class Japones < Persona
end

matz = Japones.new('Matz')
matz.saludar
