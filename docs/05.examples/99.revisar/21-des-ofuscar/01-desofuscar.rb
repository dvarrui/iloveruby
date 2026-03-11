#!/usr/bin/env ruby

filepath = ARGV[0]
names = ('a'..'z').to_a

puts "[INFO] Desofuscando #{filepath}..."

content = File.readlines(filepath)

puts "  => Lines : #{content.count}"

ugly_vars = []
content.each do |i|
  line = i.chop
  if line.start_with? '#'
    puts line
    next
  elsif line.include? ' = '
    puts "#{line}"
    ugly_vars << (line.split(' = ')[0].strip)
    next
  end
end

vars={}
ugly_vars.uniq!.each do |i|
  vars[i] = "#{names[0]}#{i.size}"
  names.delete_at 0
end

puts "[INFO] Var detected #{vars.count}"
vars.each_pair { |k,v| puts "  * #{v} -> #{k}" }
