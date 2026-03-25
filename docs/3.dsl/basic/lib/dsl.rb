
class BasicDSL
  def initialize
    @variables = {}
  end

  alias_method :echo, :print
  def print(*args)
    items = args.map { |i|
      return @variables[i] if i.is_a? Symbol
      i
    }
    puts items.join(" ")
  end
  alias_method :PRINT, :print
  
  # INPUT para capturar datos
  def input(prompt, var_name)
    echo "#{prompt} "
    STDIN.flush
    @variables[var_name] = gets.chomp
  end
  alias_method :INPUT, :input

  # LET para asignación (opcional en Ruby, pero le da el toque BASIC)
  def let2(var_name, value)
    @variables[var_name] = value
  end
  def let(value)
    value
  end
  alias_method :LET, :let
  
  # Estructura de repetición controlada (en lugar de GOTO)
  def repeat(times, &block)
    times.times { instance_eval(&block) }
  end
  alias_method :REPEAT, :repeat
  
  # Acceso a variables mediante method_missing
  def method_missing(name, *args)
    @variables[name] || name
  end
  
  def self.run(&block)
    new.instance_eval(&block)
  end
end
