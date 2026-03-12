
class ModernC
  def initialize
    @vars = {}
    @types = {}
    @sizes = {}
  end
  
  def run(block)
    instance_eval(&block)
  end

  def method_missing(name, *args)
    # Acceso a variables mediante method_missing
    return name if @vars[name].nil?
    return name if @vars[name] == :null
    @vars[name]
  end
  

  def char(varname, size=1)
    @types[varname] = :char
    @sizes[varname] = size
  end

  def chars(varname)
    @types[varname] = :chars
    @sizes[varname] = 255
  end

  def int(varname)
    @types[varname] = :int
    @sizes[varname] = 2
  end

  def debug
    puts "vars:"
    @vars.each { |k,v| puts "- #{k}=#{v}" }
    puts "types:"
    @types.each { |k,v| puts "- #{k}=#{v}" }
  end

  def for_i(range)
    for i in range do
      yield
    end
  end

  def fgets2(stdin)
    gets.chomp
  end

  def fgets(varname, stdin)
    if varname.is_a? Symbol
      @vars[varname] = gets.chomp
    else
      varname = gets.chomp
    end
  end
  
  def printf(*args)
    if (args.count == 1) && args.is_a?(Array)
      print args.first
    else 
      format = args.shift
      print format % args
    end
  end

  def sizeof(varname)
    @sizes[varname.to_sym] || 0
  end

  # Acceso a variables mediante method_missing
  def method_missing(name, *args)
    @vars[name] || name
  end
end

def main(&block)
  modern_c = ModernC.new
  modern_c.run(block)
end
