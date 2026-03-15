#!/usr/bin/ruby

input = "Cabecera...\"title\"=\"Habitación con vistas.\"bonitas."
filter = /\"title\"=\"([A-Za-z.áéíóú ]+)*\"/

result = filter.match(input)

puts "input     : #{input}"
puts "filter    : #{filter}"
puts "\nposition  : #{filter=~input}"
puts "pre_match : #{result.pre_match}"
puts "capture   : #{result.captures}"
puts "post_match: #{result.post_match}"
