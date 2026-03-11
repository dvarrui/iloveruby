#!/usr/bin/env ruby 

# https://stackoverflow.com/questions/1108767/terminal-color-in-ruby
#
# All you have to do is start with "\e[##m" and end with "\e[0m"
# Just replace the ## with the color number. Examples are:
#    31:Red
#    32:Green
#    33:Yellow
#    34:Blue
#    35:Magenta
#    36:Teal
#    37:Grey
#
# 1:Bold (can be used with any color)
#
# Here is a Ruby script to show all the terminal colors. Download it or run the code below.

def color(index)
  normal = "\e[#{index}m#{index}\e[0m"
  bold = "\e[#{index}m\e[1m#{index}\e[0m"
  "#{normal}  #{bold}  "
end

8.times do|index|
  line = color(index + 1)
  line += color(index + 30)
  line += color(index + 90)
  line += color(index + 40)
  line += color(index + 100)
  puts line
end


