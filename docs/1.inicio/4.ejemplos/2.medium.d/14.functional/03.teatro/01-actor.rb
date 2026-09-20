
class Actor
  def initialize(name)
    @name = name
  end

  def dice(texto)
    info = @name
    frases = texto.split('.')
    # Decir la primera frase
    puts "#{info} : #{frases[0].strip}."
    frases.delete_at 0
    # Decir el resto de frases
    info = ' ' * @name.size
    frases.each do |frase|
      puts "#{info} : #{frase.strip}."
    end
  end

  def dice_gritando(texto)
    dice texto.upcase
  end
end
