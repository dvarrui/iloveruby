class Integer
  def fac
   raise "Faculty undeﬁned for #{self}" if self < 0
   return (1..self).inject(1) { |result, i| result * i }
  end
end

puts (0..13).map { |i| i.fac }.join(', ')


❯ irb
irb(main):001:0> 4.class
=> Integer
irb(main):002:0> 4.object_id
=> 9
irb(main):003:0> 3.class
=> Integer
irb(main):004:0> 3.object_id
=> 7
irb(main):005:0> 3 + 4
=> 7
irb(main):006:0> 3.+(4)
=> 7
irb(main):007:0>
