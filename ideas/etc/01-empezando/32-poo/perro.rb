require_relative 'animal'

class Perro < Animal
  def initialize(raza, nombre)
    @raza = raza
    super(nombre)
  end

  def show
    puts "[Perro] nombre=#{@nombre}, raza=#{@raza}"
  end
end
