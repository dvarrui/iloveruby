#!/usr/bin/env ruby
#

numeros = (1..20).to_a

for n in numeros do
  potencia = 2 ** n
  puts "a(#{n}) = 2**#{n} = #{potencia}"
end


