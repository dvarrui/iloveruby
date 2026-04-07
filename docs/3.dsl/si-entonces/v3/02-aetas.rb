#!/usr/bin/env ruby
require_relative "lib/latin"

# Ejemplo 1: si-entonces
aetas = 10
nomen = "Pitufo"
escribere "\nEdad: #{aetas}"

si(aetas.maior 17)
.tum { 
  escribere "#{nomen} es adulto" 
}
.si_non {
  escribere "#{nomen} es menor"
}

# Ejemplo 2: sino
aetas = 55
nomen = "Obiwan"
escribere "\nEdad: #{aetas}"

si(aetas.maior 17)
.tum {
  escribere "#{nomen} es adulto" 
}
.si_non {
  escribere "#{nomen} es menor" 
}
