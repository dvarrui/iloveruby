require "debug"

$BINDING = binding

def main(&block)
  block.call if block_given?
end

def char(varname)
  # Creamos la variable local en el contexto
  $BINDING.local_variable_set(varname, '')
end

def fgets(varname, size, stdin)
  varname = gets.chomp
end

def printf(*args)
  if args.count == 1
    puts args
  else 
    format = args.shift
    puts format % args
  end
end

def sizeof(varname)
  varname.size
end
