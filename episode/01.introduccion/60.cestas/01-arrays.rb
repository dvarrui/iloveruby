# ASGMT lists
# asigna valores iniciales
marks = '3,4,3,2,7,8,9,1,1,5'

# code
passed = 0
failed = 0

marks.split(',').each do |item|
  if item.to_i >= 5
    passed += 1
  else
    failed += 1
  end
end

puts passed
puts failed
