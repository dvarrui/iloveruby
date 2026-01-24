
require 'colorize'

def title(input)
  text = input.to_s.capitalize
  output = '=' * 15
  output += " #{text} "
  output += '=' * (20 - text.size)
end

def now_cames(type, text)
  print "\nNext code example? ".white
  gets
  system('clear')

  puts title(type)
  puts text.light_yellow
  print "Press ENTER to execute code:".white
  gets
  puts
end
