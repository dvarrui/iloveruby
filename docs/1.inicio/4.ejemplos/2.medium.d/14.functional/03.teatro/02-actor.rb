
class Actor
  def initialize(name)
    @name = name
    @num_frases = 0
    @num_palabras = 0
  end

  def dice(texto)
    decir_la_primera_frase(texto)
    decir_el_resto_de_frases(texto)
    contar_las_palabras_del texto
  end

  def dice_gritando(texto)
    dice texto.upcase
  end

  def info
    puts @name.strip
    puts " * He tenido #{@num_frases} frases."
    puts " * He dicho  #{@num_palabras} palabras."
  end

  private

  def decir_la_primera_frase(texto)
    frases = texto.split('.')
    primera_frase = frases[0].strip
    puts "#{@name} : #{primera_frase}."
  end

  def decir_el_resto_de_frases(texto)
    frases = texto.split('.')
    frases.delete_at 0
    tab = ' ' * @name.size
    frases.each do |frase|
      puts "#{tab} : #{frase.strip}."
    end
  end

  def contar_las_palabras_del(texto)
    @num_frases += 1
    @num_palabras += texto.split(' ').count
  end
end


def titulo_de_la_obra(titulo)
  size = titulo.size
  puts '=' * size
  puts titulo
  puts '=' * size
end
