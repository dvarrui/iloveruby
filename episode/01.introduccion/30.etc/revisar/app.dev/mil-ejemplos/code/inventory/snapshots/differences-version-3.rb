#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---
unless ARGV.length == 2 
  puts "Usage: differences.rb old-inventory new-inventory"
  exit
end

old_inventory = File.open(ARGV[0]).readlines.collect do | line | 
  line.downcase
end  

file_lines = File.open(ARGV[1]).readlines
new_inventory = file_lines.collect do | line |
  line.downcase
end  

puts "The following files have been added:"
puts new_inventory - old_inventory

puts ""
puts "The following files have been deleted:"
puts old_inventory - new_inventory
