name = "Markus"
age = 49
height = 71.5

#puts "Age: " + age.to_s
#puts age

puts "#{name}'s age is #{age}"
puts

puts "Enter a new name, I don't like #{name}"
name = gets
name.chomp!

puts "Enter an age"
age = gets.to_i

puts "#{name}'s age is #{age}"

puts

age += 10
puts "In ten years #{name} will be #{age}"
puts

PI = 3.14
puts "Pi is #{PI}"

PI = 3.14159

puts "Pi is now #{PI}"