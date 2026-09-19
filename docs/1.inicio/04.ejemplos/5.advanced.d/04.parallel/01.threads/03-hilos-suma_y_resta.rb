#!/usr/bin/ruby
#

$x = 0
$max = 10
inc = 2
inc_sleep = 0.25
inc_bonito = ' %2d' % inc
dec = -1
dec_sleep = 0.1
dec_bonito = ' %2d' % dec

def create_hilo(name, value, value_bonito, value_sleep)
  Thread.new do
    play = true
    while play
      $x += value
      puts "#{name}[#{value_bonito}]: x=#{$x}\n"
      sleep(value_sleep)
      play = false if value < 0 and $x < -$max
      play = false if value > 0 and $x > $max
    end
    puts "Gana #{name}! x=#{$x} velocidad=#{value_sleep}"
    exit 1
  end
end

t1 = create_hilo('DEC', dec, dec_bonito, dec_sleep)
t2 = create_hilo('INC', inc, inc_bonito, inc_sleep)

t1.join
t2.join
