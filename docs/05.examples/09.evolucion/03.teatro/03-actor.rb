
require 'rainbow'

class Actor
  def initialize(name, color=:green)
    @name = name
    @color = color
    @num_frases = 0
    @num_palabras = 0
  end

  def name
    Rainbow(@name).color(@color).bright.strip
  end

  def dice(texto)
    dice_tranquilo texto
  end

  def dice_tranquilo(texto)
    decir_la_primera_frase(texto)
    decir_el_resto_de_frases(texto)
    contar_las_palabras_del texto
  end

  def dice_gritando(texto)
    dice_tranquilo Rainbow(texto.upcase).red.bright
  end

  def info
    puts
    puts name
    stat_frases = Rainbow("├── He tenido #{@num_frases} frases.").color(@color).bright
    puts "#{tab_minus(1)}#{stat_frases}"
    stat_palabras = Rainbow("└── He dicho  #{@num_palabras} palabras.").color(@color).bright
    puts "#{tab_minus(1)}#{stat_palabras}"
  end

  private

  def tab
    ' ' * @name.size
  end

  def tab_minus(number)
    ' ' * (@name.size - number)
  end

  def decir_la_primera_frase(texto)
    frases = texto.split('.')
    primera_frase = frases[0].strip
    puts "#{name} : #{primera_frase}."
  end

  def decir_el_resto_de_frases(texto)
    frases = texto.split('.')
    frases.delete_at 0
    frases.each do |frase|
      puts "#{tab} : #{frase.strip}."
    end
  end

  def contar_las_palabras_del(texto)
    @num_frases += 1
    @num_palabras += texto.split(' ').count
  end
end

def titulo_de_la_obra(titulo, tab: 0)
  size = titulo.size
  tabs = ' ' * tab
  color = :tanx
  linea_en_color = Rainbow('=' * size).color(color)
  titulo_en_color = Rainbow(titulo).color(color)

  puts "#{tabs}#{linea_en_color}"
  puts "#{tabs}#{titulo_en_color}"
  puts "#{tabs}#{linea_en_color}"
  puts "\n\n"
end
