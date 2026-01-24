supermarket = Ractor.new do
  loop do
    order = Ractor.receive
    puts "The supermarket is preparing #{order}"
    Ractor.yield "This is #{order}"
  end
end

customers = 5.times.map{ |i|
  Ractor.new supermarket, i do |supermarket, i|
    supermarket.send("a pack of sugar for customer #{i}")
    fulfilled_order = supermarket.take
    puts "#{fulfilled_order} received by customer #{i}"
  end
}

sleep 1
