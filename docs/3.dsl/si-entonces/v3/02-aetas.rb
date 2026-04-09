#!/usr/bin/env ruby
require_relative "lib/latin"

# Ejemplo 1: si-entonces
aetas = X
nomen = "Pitufo"
escribere "\nEdad: #{aetas}"

si(aetas.maior? XVII)
.tum { 
  escribere "#{nomen} es adulto" 
}
.si_non {
  escribere "#{nomen} es menor"
}

# Ejemplo 2: sino
aetas = LV
nomen = "Obiwan"
escribere "\nEdad: #{aetas}"

si(aetas.maior? XVII)
.tum {
  escribere "#{nomen} es adulto" 
}
.si_non {
  escribere "#{nomen} es menor" 
}
