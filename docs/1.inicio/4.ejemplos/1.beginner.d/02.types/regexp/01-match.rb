#!/usr/bin/env ruby 

input = "IDP\\Administrador\nIDP\\Alumno\nIDPe\\Alumno\nIDP\\Alumnito"
lines= input.split("\n")

filter = /^IDP\\Alumno$/

lines.each do |line|
  puts format("Filter? %20s => %s", line, filter.match(line))
end

