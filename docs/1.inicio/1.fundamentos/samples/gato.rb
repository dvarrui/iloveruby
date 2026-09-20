#!/usr/bin/env ruby
# Ejemplo: Clase Gato

class Gato
  # Crear getter/setter para name y color
  attr_accessor :name, :color
  
  def mauyar
    "[#{@name}] Miau!"
  end

  def to_s
    "Gato: name=#{@name}, color=#{@color}"
  end
end
  
# Ejemplo: objeto garfield
garfield = Gato.new
garfield.name = "Garfield"
garfield.color = "naranja con rayas negras"
puts garfield.mauyar
puts garfield
