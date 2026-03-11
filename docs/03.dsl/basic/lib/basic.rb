require "debug"

alias echo print

def PRINT(*args)
  puts args.join(" ")
end

class Basic
  def initialize
    @variables = {}
  end

    # PRINT en BASIC siempre va en mayúsculas
  def print(*args)
    items = args.map { |i|
      return @variables[i] if i.is_a? Symbol
      i
    }
    puts items.join(" ")
  end
  
  # INPUT para capturar datos
  def input(prompt, var_name)
    echo "#{prompt} "
    @variables[var_name] = gets.chomp
  end 
  
  # LET para asignación (opcional en Ruby, pero le da el toque BASIC)
  def let(var_name, value)
    @variables[var_name] = value
  end
  
  # Estructura de repetición controlada (en lugar de GOTO)
  def repeat(times, &block)
    times.times { instance_eval(&block) }
  end
  
  # Acceso a variables mediante method_missing
  def method_missing(name, *args)
    @variables[name] || name
  end
  
  def self.run(&block)
    new.instance_eval(&block)
  end
end