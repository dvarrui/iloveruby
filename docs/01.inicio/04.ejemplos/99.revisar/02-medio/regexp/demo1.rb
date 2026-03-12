#!/usr/bin/env ruby 

a = "IDP\\Administrador\nIDP\\Alumno\nIDPe\\Alumno\nIDP\\Alumnito"
b = a.split("\n")

filter = /^IDP\\Alumno$/

b.each do |i|
  puts format("Filter? %20s => %s", i, filter.match(i))
end

