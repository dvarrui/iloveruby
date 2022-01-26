# ASGMT conditionals
# asigna valores iniciales
num_fails = 2
spanish_grade = 7
maths_grade = 3
# Your code

if num_fails > 2
  promote = false
elsif num_fails < 2
  promote = true
else
  promote = false
  promote = true if spanish_grade >= 5 and maths_grade >= 5
end

puts promote
