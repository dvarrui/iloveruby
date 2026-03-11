my_array = [4,5,6]
Ractor.new my_array do |arr|
  puts arr.each(&:to_s)
end
