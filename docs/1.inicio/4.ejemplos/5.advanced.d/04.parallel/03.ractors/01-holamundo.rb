#!/usr/bin/env ruby
$VERBOSE=nil

# Creamos un Ractor que simplemente devuelve un mensaje
ractor = Ractor.new do
  "¡Hola desde el Ractor!"
end

# Leemos el valor devuelto por el Ractor
result = ractor.take

puts result
# Salida: ¡Hola desde adentro del Ractor!
