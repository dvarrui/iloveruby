r = Ractor.new { puts "This is my first ractor" }
# This is my first ractor

# create a ractor with a name
r = Ractor.new name: 'second_ractor' do
  puts "This is my second ractor"
end
# This is my second ractor

puts r.name
# => "second_ractor"
sleep 1
