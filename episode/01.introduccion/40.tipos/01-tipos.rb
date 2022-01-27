#!/usr/bin/env ruby

myinteger = 1970
myfloat = 1.82

mystring = 'I Love Ruby'

myboolean = false

# Tipado dinámico y fuerte
result1 = 4 + 3
puts result1
puts result1.class

result2 = result1 + 3.0
puts result2
puts result2.class

# Calcular la raíz cuadrada
a = 2
b = -14
c = 24

raiz = (b**2 - 4*a*c)**0.5

x1 = (-b - raiz) / (2*a)
x2 = (-b + raiz) / (2*a)

puts x1
puts x2
