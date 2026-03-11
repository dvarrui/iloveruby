#!/usr/bin/env ruby

class Humano
  def identidad
    puts "[Humano] soy una persona."
  end

  def tarifa_tren(edad)
    if edad < 12
      puts "[Humano] tarifa reducida."
    else
      puts "[Humano] tarifa normal."
    end
  end
end


class Estudiante < Humano
  def identidad
    puts "[Estudiante] soy un estudiante."
  end
end


class Profesor < Humano
  def identidad
    puts "[Profesor] Soy un profesor y además...."
    super
  end
end

Humano.new.identidad
Estudiante.new.identidad
Profesor.new.identidad

