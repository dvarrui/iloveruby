tripple_number_ractor = Ractor.new do
  puts "I will receive a message soon"
  msg = Ractor.receive
  puts "I will return a tripple of what I receive"
  msg * 3
end
# I will receive a message soon
puts "[INFO] Sending 15"
tripple_number_ractor.send(15) # mailman takes message to the door
# I will return a tripple of what I receive
result = tripple_number_ractor.take # mailman takes the response
puts "[INFO] Receiving #{result}" # => 45
