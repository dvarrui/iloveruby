#!/usr/bin/env ruby

puts "Billetes y monedas"
print "Escribir la cantidad de dinero: "
dineroquedebo = gets.to_f

billetesymonedas = [500, 200, 100, 50, 20, 10, 5, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01]
pagarcon = []

for billete in billetesymonedas
  while dineroquedebo >= billete
    pagarcon << billete
    dineroquedebo -= billete
  end
end

puts ""
puts "Al final pago con:"
puts pagarcon.join(", ")
