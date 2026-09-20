require "prism"
require "pp"

def show_lex(code)
  puts "---"
  Prism.lex(code).value.each do |item|
    type = item[0].type.to_s
    value = item[0].value
    loc = item[0].location
    location = "#{loc.start_line},#{loc.start_offset}(#{loc.length})"
    value = "<nl>" if value == "\n" 
    puts "#{type.ljust(15)} | #{value.ljust(15)} | #{location}"
  end  
end

def show_sexp(code, mode=:default)
  data = Prism::Translation::Ripper.sexp(code)
  if mode == :default
    p data
  else
    show_item(0, data)
  end
end

def show_item(tab, item)
  if item.is_a? Array
    show_nodes(tab + 1, item)
  else
    show_node(tab, item)
  end
end

def show_node(tab, node)
  print '  ' * tab
  p node
end

def show_nodes(tab, nodes)
  nodes.each { |node| show_item(tab, node) }
end