#!/usr/bin/ruby
#

x = 0
max = 10
inc = 2
inc_sleep = 0.3
inc_bonito = ' %2d' % inc
dec = -1
dec_sleep = 0.1
dec_bonito = ' %2d' % dec

# Hilo para decrementar
Thread.new do
  while x > (max * -1)
    x += dec
    puts "DEC[#{dec_bonito}]: x=#{x}\n"
    sleep(dec_sleep)
  end
  puts "DEC[#{dec_bonito}]: x=#{x} Es muy pequeña. Gana DEC!"
  exit 1
end

# Hilo para incrementar
while x < (max)
  x += inc
  puts "INC[#{inc_bonito}]: x=#{x}\n"
  sleep(inc_sleep)
end

puts "INC[#{inc_bonito}]: x=#{x} Es muy grande. Gana INC!"

exit 0
