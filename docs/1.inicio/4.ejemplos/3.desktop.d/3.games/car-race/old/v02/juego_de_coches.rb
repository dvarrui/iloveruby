
require_relative 'circuito'
require_relative 'coche'

class JuegoDeCoches

  def initialize
    @circuito = Circuito.new
    @coche = Coche.new(@circuito.carretera.last + 3 )
  end

  def render
    @circuito.render
    @coche.render
  end

  def update
    @circuito.update
    @coche.update
  end

  def start
    while(true) do
      render
      update
    end
  end
end
