def si1(cond, scope = binding)
  eval(cond, scope)
end
  
def si2(cond)
  cond
end

number = 55
puts si1('number > 18', binding)

puts si2(number > 18)
