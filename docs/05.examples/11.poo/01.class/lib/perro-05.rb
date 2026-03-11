require_relative 'animal-05'

class Perro < Animal
  def initialize(raza, nombre)
    @raza = raza
    super(nombre)
  end

  def show
    puts "[Perro] nombre=#{@nombre}, raza=#{@raza}"
  end
end
