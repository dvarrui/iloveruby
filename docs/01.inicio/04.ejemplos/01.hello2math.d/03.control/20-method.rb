#!/usr/bin/env ruby

def saludar_a(*nombres)
  nombre.each do |nombre|
    puts "Hola #{nombre.capitalize}!"
  end
end

saludar_a 'obiwan', 'yoda', 'annakin'
