#!/usr/bin/env ruby
# Ejemplo: factorial recursivo
def factorial(n)
  return 1 if n <= 1
  n * factorial(n -1)
end
  
puts factorial(3)     #=> 3! = 3*2*1 = 6

# Inspeccionando el "contenedor"
puts self                  #=> main
puts self.class            #=> Object
puts Object.ancestors.to_s #=> >> [Object, Kernel, BasicObject]
