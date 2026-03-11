#!/usr/bin/env ruby

#Variable global, accesible por todos los hilos
$vg = 0
num_iteraciones = 50

def codigo_del_hilo(id, number)
  vl = 0
  number.times do
    puts "Hilo[#{id}]: vl=#{vl}, vg=#{$vg}"
    vl += 1
    $vg += 1
    sleep(0.01* rand)
  end
  puts "Hilo[#{id}] terminado."
end

def crear_hilos_y_esperar(a, number)
  t = []
  a.each do |id|
    # Crear un hilo que ejecuta el método
    t << Thread.new { codigo_del_hilo(id, number) }
  end
  # Esperar por cada hilo creado
  t.each { |i| i.join}
end

hilos = [1,2,3,4,5]
crear_hilos_y_esperar(hilos, num_iteraciones)

num_hilos = hilos.size
total = num_iteraciones * num_hilos
puts "N. de hilos        : #{num_hilos}"
puts "N. iteaciones/hilo : #{num_iteraciones}"
puts "Total debe ser (#{$vg}) == #{total}"
