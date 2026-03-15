require "pastel"

class Code2Code
  def initialize(filename)
    @pastel = Pastel.new
    @filename = filename
    @input_lines = load(@filename)
    @output_lines = []
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
    return if @output_lines.empty?
    puts @pastel.green.bold(@output_lines.join("\n").to_s)
  end

  def code
    l1 = { a: "4", e: "3", i: "1", o: "0"}
    l2 = { b: "8", q: "9", s: "5", t: "7"}
    letters = l1.merge(l2)
    # binding.break
    @input_lines.each do |input_line|
      output_line = input_line.dup
      letters.each_pair do |from, to|
        output_line = output_line.tr(from.to_s, to)
      end
      @output_lines << output_line
    end
  end
end

