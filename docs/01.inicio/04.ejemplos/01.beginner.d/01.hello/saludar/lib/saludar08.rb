
require 'colorize'

class Saludar
  def self.a(nombre = 'Mundo')
    decir = frase_para_saludar_a nombre
    puts decir
  end

  def self.to(name = 'World')
    say = phrase_to_greet name
    puts say.light_red
  end

  def self.gritando(nombre = 'Mundo')
    decir = frase_para_saludar_a nombre
    puts decir.upcase
  end

  def self.flojito(nombre = 'Mundo')
    decir = frase_para_saludar_a nombre
    puts decir.downcase.white
  end

  def self.coloquial(_nombre = nil)
    decir = '¡Chacho puntaaal!'
    puts decir
  end

  private_class_method def self.frase_para_saludar_a(nombre)
    "¡Hola #{nombre.capitalize}!"
  end

  private_class_method def self.phrase_to_greet(name)
    "Hello #{name.capitalize}!"
  end
end
