
require 'colorize'

def title(input)
  text = input.to_s.capitalize
  output = '=' * 15
  output += " #{text} "
  output += '=' * (20 - text.size)
end

def now_cames(header, code)
  print "\nNext code example? ".white
  gets
  system('clear')

  puts title(header)
  puts code.light_yellow
  print "Press ENTER to execute code:".white
  gets
  puts
  eval(code)
end
