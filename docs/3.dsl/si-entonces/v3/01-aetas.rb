#!/usr/bin/env ruby
require_relative "lib/latin"

# Ejemplo 1: si-entonces
aetas = X
escribere "\nEdad: #{aetas}"

si(aetas.maior XVII)
  .tum { escribere "Adulto" }
  .si_non { escribere "Menor" }

# Ejemplo 2: sino
aetas = LV
escribere "\nEdad: #{aetas}"

si(aetas.maior XVII)
  .tum { escribere "Adulto" }
  .si_non { escribere "Menor" }
