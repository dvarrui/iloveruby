#!/usr/bin/env ruby

require 'colorize'

class Persona
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def yosoy
    puts "#{cabecera} Yo soy #{@name}"
  end

  def saluda_a(persona)
    puts "#{cabecera} ¡Hola #{persona}!"
  end

  def to_s
    @name
  end

  private

  def cabecera
    " [#{@name}]"
  end
end

adan = Persona.new("Adán")
eva = Persona.new("Eva ")

adan.yosoy
adan.saluda_a eva
eva.saluda_a adan
