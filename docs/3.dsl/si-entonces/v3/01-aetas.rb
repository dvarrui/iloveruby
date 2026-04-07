#!/usr/bin/env ruby
require_relative "lib/latin"

# Ejemplo 1: si-entonces
aetas = 10
escribere "\nEdad: #{aetas}"

si(aetas.maior 17)
  .tum { escribere "Adulto" }
  .si_non { escribere "Menor" }

# Ejemplo 2: sino
aetas = 55
escribere "\nEdad: #{aetas}"

si(aetas.maior 17)
  .tum { escribere "Adulto" }
  .si_non { escribere "Menor" }
