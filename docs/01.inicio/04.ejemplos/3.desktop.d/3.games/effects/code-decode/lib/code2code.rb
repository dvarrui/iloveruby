require "pastel"

class Code2Code
  def initialize(filename)
    @pastel = Pastel.new
    @filename = filename
    @input_lines = load(@filename)
  end

  def load(filename)
    if filename.nil?
      puts @pastel.yellow.bold("Error: Debes proporcionar el nombre de un archivo.")
      puts @pastel.yellow.bold("Uso: code2code FILENAME")
      exit 1
    end
  
    unless File.exist?(filename)
      puts @pastel.red.bold("Error: El archivo '#{filename}' no existe.")
      exit 1
    end
  
    lines = File.readlines(filename).map(&:chomp)
    puts "==> load: Archivo cargado con éxito. El array tiene #{lines.size} líneas."
    lines
  end

  def show
    puts "==> show: "
    puts @pastel.blue.bold(@input_lines.join("\n").to_s)
  end
end

